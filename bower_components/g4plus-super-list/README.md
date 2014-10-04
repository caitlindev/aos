G4Plus Super List Directive
===========================

## Installation

The easiest way is to add `g4plus-super-list` as a module in your `app.coffee`.

## Configuration

In your template file where you want to use:

```html
  div(
    g4plus-super-list
    g4-service="superList.service"
    g4-actions="superList.actions"
    g4-columns="superList.columns"
    g4-filters="superList.filters"
    g4-params="superList.params"
    g4-update-url="superList.updateUrl"
    g4-success="superList.success"
    g4-error="superList.error"
  )
```

where `superList` is defined in your controller as a scope variable:

```coffee

  $scope.superList =
    service:
      # variants: array, promise, resource, http
      type: 'promise'

      # data can be:
      # 1. array when type is set as array
      # 2. promise returned by a service call when type is set as promise
      # 3. resource when you pass the call of a $resoure service; ex. CustomService.query
      # 4. a http call function when you make the service call with $http
      data: serviceData

      # set true if the configured service supports sorting. used with type as resource or http
      hasSorting: false
      # set true if the configured service supports pagination
      hasPagination: false
      # set true if the configured service supports filtering
      hasFiltering: false

    # optional actions object, in case it's missing the actions column will not be displayed
    actions:
      # delete action as a function
      deleteAction: (item) ->

      # delete link (id of the item will be added)
      deleteLink: '#/delete/'

      # or you can define a valid ui-route
      deleteState: 'delete',
      deleteStateParam: 'id'

      # edit action as a function
      editAction: (item) ->

      # edit link (id of the item will be added)
      editLink: '#/edit/'

      # or you can define a valid ui-route
      editState: 'edit'
      editStateParam: 'id'

      # view action as a function
      viewAction: (item) ->

      # view link (id of the item will be added)
      viewLink: '#/view/'

      # or you can define a valid ui-route
      viewState: 'view'
      viewStateParam: 'id'

    # list of columns you want to display
    columns: [
      {
        # column heading
        title: 'Title'

        # field name from items
        field: 'field'

        # optional column class (ex. narrow)
        columnClass: 'narrow'

        # optional flag to se if this column support sorting
        sorting: true

        # optional sorting field sent to the service
        sortingField: 'fieldSort'

        # optional filter name
        filter: 'number'

        # optional filter extra parameters
        filterData: 10

      }
      ...
    ]

    # optional filters which appears as a dropdown next to the search field
    filters: [
      {
        key: '_all'
        label: 'All'

        # set if is visible in the dropdown
        visible: true

        # type can be keyword, static or field
        type: 'keyword'

        # optional prefix used to pass parameter to the filtered service
        prefix: '|_magik::'
      }
      {
        key: 'field'
        label: 'Title'
        visible: true
        type: 'strict'
        prefix: '|field:like:'
      }
      ...
    ]

    # parameters used to filter and display data from service
    params:
      # pagination parameters
      pagination:
        page: 1
        pageSize: 10

      $ filter values
      filters:
        field: null
        filter_value: ''
        filter_option: '_all'

      # current sorting option
      sorting: null

      # success callback, called when the list is loaded
      success: (data) ->

      # error callback when the service call fail
      error: (response) ->

      # update url callback when the service changed the
      # parameters and url needs to be updated
      updateUrl: () ->

```

The service query is called when the directive is loaded. In some cases the directive is not reloaded when route is changed (ex. routes with reloadOnSearch set on false), then you need to trigger the reload manually. This can be done broadcasting an event:

```coffee

  $scope.$broadcast 'SuperList:reload'

```