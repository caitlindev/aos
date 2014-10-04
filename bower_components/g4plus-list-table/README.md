G4Plus List Table Directive
===========================

## Installation

The easiest way is to add `g4plus-list-table.directive` as a module in your `app.coffee`.

## Configuration

In your template file where you want to use:

```html
<div g4plus-list-table="tableOptions"></div>
```

where `tableOptions` is defined in your controller as a scope variable:

```js
$scope.tableOptions = {
    // list of items you want to display
    items: [
        {
            'field' : 'value',
            ...
        },
        ...
    ],

    // an optional message when there are no items
    noItemsFoundMessage: 'There are no entries that matched the filter.',

    // Optional: reset filter function to be called when there are no items
    resetFilter: $scope.filter_state.resetFilter,
    
    // optional table class
    tableClass: 'table-lined rounded',

    // optional actions object, in case it's missing the actions column will not be displayed
    actions: {

        // delete action as a function
        deleteAction: function(item) {},

        // delete link (id of the item will be added)
        deleteLink: '#/delete/',

        // or you can define a valid ui-route
        deleteState: 'delete',
        deleteStateParam: 'id',

        // edit action as a function
        editAction: function(item) {},

        // edit link (id of the item will be added)
        editLink: '#/edit/',

        // or you can define a valid ui-route
        editState: 'edit',
        editStateParam: 'id',

        // view action as a function
        viewAction: function(item) {},

        // view link (id of the item will be added)
        viewLink: '#/view/',

        // or you can define a valid ui-route
        viewState: 'view',
        viewStateParam: 'id'
    },

    // list of columns you want to display
    columns: [
        {
            // column heading
            title: 'Title',

            // field name from items
            field: 'field',

            // optional column class (ex. narrow)
            columnClass: 'narrow',

            // optional flag to se if this column support sorting
            sorting: true,
            
            // optional filter name
            filter: 'number',

            // optional filter extra parameters
            filterData: 10
        }
        ...
    ],

    // optional sort column
    sortColumn: 'field',

    // optional sort direction ( '' / '-')
    sortDirection: '',

    // optional callback when sorting is changed
    onSortColumn: function(column, direction) {}
}
```