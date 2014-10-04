'use strict'

#
# Date manipulation directive used for input fields
#

dateManip = angular.module 'g4plus-date.directive', []

dateManip.directive 'g4plusDate', ($filter) ->
  require: 'ngModel'
  restrict: 'A'
  link: (scope, elm, attrs, ctrl) ->

    viewFormat = 'MM/DD/YYYY'
    modelFormat = 'YYYY-MM-DD'

    if attrs.g4plusDateViewFormat?.length
      viewFormat = attrs.g4plusDateViewFormat
    if attrs.$attr.g4plusDateModelFormat?.length
      modelFormat = attrs.g4plusDateModelFormat

    # Parsing of date values.
    # Depending on the presence of inputFormat parameter there are two
    # strategies:
    #   - inputFormat defined - this will be used to parse the value
    #   - inputFormat undefined - the default formats will be tried out by
    #     removing non digits characters.
    #
    # Params:
    #   @param string value       The string value to be parsed.
    #   @param string inputFormat Input format (e.g. "YYYY-MM-DD"). If the
    #                             input format is not defined the date is
    #                             magically guessed.
    parseString = (value, inputFormat) ->

      # The value to be returned, if the value can not be parsed null is returned
      parsed = null

      # Process input value and transform it into string.
      # This is needed for the replace function bellow.
      if typeof value is 'number'
        inputVal = value.toString()
      else
        inputVal = value

      # If inputFormat is defined use this during parsing
      if inputFormat?.length
        # Custom parsing for date format
        parsed = moment(inputVal, inputFormat)
      else
        digits = inputVal?.replace /\D/g, ''

        # Automatically parse a string based on it's length
        switch digits?.length
          when 8
            parsed = moment(digits, ['YYYYMMDD', 'MMDDYYYY', 'DDMMYYYY'])

          when 6
            parsed = moment(digits, ['YYMMDD', 'MMDDYY'])

      return parsed

    # Configure angular input format parsers
    ctrl.$parsers.unshift (value) ->
      parsed = parseString value
      dateMin = parseString attrs.g4plusDateMin
      dateMax = parseString attrs.g4plusDateMax

      # date valid
      if parsed and parsed.isValid()

        # check interval requirements
        if dateMin and dateMax
          ctrl.$setValidity 'dateInterval', (parsed.isSame(dateMin) or parsed.isAfter(dateMin)) and (parsed.isSame(dateMax) or parsed.isBefore(dateMax))
        else
          if dateMax
            ctrl.$setValidity 'dateMax', parsed.isSame(dateMax) or parsed.isBefore(dateMax)
          if dateMin
            ctrl.$setValidity 'dateMin', parsed.isSame(dateMin) or parsed.isAfter(dateMin)

        ctrl.$setValidity 'date', true

        return parsed.format modelFormat
      else if !value
        ctrl.$setValidity 'date', true
        return undefined

      # date not valid
      else
        ctrl.$setValidity 'date', false
        ctrl.$setValidity 'dateInterval', true
        ctrl.$setValidity 'dateMin', true
        ctrl.$setValidity 'dateMax', true
        return undefined

    # Configure input value formatter
    ctrl.$formatters.unshift (value) ->
      parsed = parseString value, modelFormat

      if parsed and parsed.isValid()
        return parsed.format viewFormat
      else
        return value

    elm.on 'blur', () ->
      parsed = parseString ctrl.$viewValue
      if parsed and parsed.isValid()
        ctrl.$viewValue = parsed.format viewFormat
        ctrl.$render()

#
# Display date in a given format
#
dateManip.directive "date", () ->
  restrict: 'E'
  scope:
    format: '@'
  template: '<span>{{date}}</span>'
  link: (scope, elm, attrs) ->
    scope.date = moment().format(scope.format)
