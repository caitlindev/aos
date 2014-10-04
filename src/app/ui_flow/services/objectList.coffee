# Module for webservices
module = angular.module 'services.object-list', []

# Fake resource Service
# ============================
# Mimic a webserice

module.factory 'ObjectList', [
  '$filter'

  ($filter) ->
    items = [
      {
        "id": 1,
        "code": "1",
        "title": "Alpha",
        "description": "Details about item"
      },
      {
        "id": 2,
        "code": "2",
        "title": "Beta",
        "description": "Details about item"
      },
      {
        "id": 3,
        "code": "3",
        "title": "Gamma",
        "description": "Details about item"
      },
      {
        "id": 4,
        "code": "4",
        "title": "Delta",
        "description": "Details about item"
      },
      {
        "id": 5,
        "code": "5",
        "title": "Epsilon",
        "description": "Details about item"
      },
      {
        "id": 6,
        "code": "6",
        "title": "Alpha",
        "description": "Details about item"
      },
      {
        "id": 7,
        "code": "7",
        "title": "Beta",
        "description": "Details about item"
      },
      {
        "id": 8,
        "code": "8",
        "title": "Gamma",
        "description": "Details about item"
      },
      {
        "id": 9,
        "code": "9",
        "title": "Delta",
        "description": "Details about item"
      },
      {
        "id": 10,
        "code": "10",
        "title": "Epsilon",
        "description": "Details about item"
      },
      {
        "id": 11,
        "code": "11",
        "title": "Alpha",
        "description": "Details about item"
      },
      {
        "id": 12,
        "code": "12",
        "title": "Beta",
        "description": "Details about item"
      },
      {
        "id": 13,
        "code": "13",
        "title": "Gamma",
        "description": "Details about item"
      },
      {
        "id": 14,
        "code": "14",
        "title": "Delta",
        "description": "Details about item"
      },
      {
        "id": 15,
        "code": "15",
        "title": "Epsilon",
        "description": "Details about item"
      }
    ]

    query: (api_params) ->

      filtered_list = items

      if api_params.select is 9
        return [ ]

      if api_params.filter_value and api_params.filter_option
        filtered_list = $filter('listFilter')(items, api_params.filter_value, api_params.filter_option)

      filtered_list = filtered_list.slice(
        (api_params.page - 1) * api_params.pageSize,
        api_params.page * api_params.pageSize
      )

      result =
        items: filtered_list
        totalItems: items.length

      return result
]

# Filter stuff
module.filter 'listFilter', [
  '$filter'

  ($filter) ->
    (input, value, option) ->

      output = input

      # Only check when filtering by some input value
      if value.length
        if option && option != '_all'
          filter_column = {}
          filter_column[option] = value
          output = $filter('filter')(input, filter_column)
        else
          output = $filter('filter')(input, value)

      return output
]
