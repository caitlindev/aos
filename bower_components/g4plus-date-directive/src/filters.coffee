filters = angular.module 'g4plus-date.filter', []

filters.filter 'maintenanceDate', ->
  (input, format) ->
    if typeof input is 'string'
      digits = input.replace /\D/g, ''

      switch digits.length
        when 8 then parsed = moment(digits, ['YYYYMMDD','MMDDYYYY'])
        when 6 then parsed = moment(digits, ['YYMMDD','MMDDYY'])
      
      if parsed?.isValid()
        return parsed.format(if format then format else 'MM/DD/YYYY')
    unless input
      input = 'N/A'
    return input

# unixDate
# ========
# Utility filter to format unix timestamp values, will return:
#   1. formated output if input can be parsed
#   2. N/A if input is empty or null
#   3. Original input if none of the above
filters.filter 'unixDate', ->
  (input, format) ->
    # Check if custom output format will be used.
    # By default we have month/day/year
    outputFormat = 'MM/DD/YYYY'
    if format?.length
      outputFormat = format

    output = input
    m = moment.unix(input)
    if m.isValid()
      output = moment.unix(input).format(outputFormat)
    unless input
      output = 'N/A'

    return output
