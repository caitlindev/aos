filters = angular.module 'app.filters', [

]

filters.filter 'date', ->
  (input) ->
    if typeof input is 'string'
      digits = input.replace /\D/g, ''

      switch digits.length
        when 8 then parsed = moment(digits, ['YYYYMMDD','MMDDYYYY'])
        when 6 then parsed = moment(digits, ['YYMMDD','MMDDYY'])
      
      if parsed?.isValid()
        return parsed.format('YYYY/MM/DD')

    return input