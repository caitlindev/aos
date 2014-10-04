G4Plus Sort Button
====

This module provides two directives that create a sort button that updates depending on the current sort column provided by the two-way binding attribute `currentSortCol`.

The directives `currentSortCol` and `sortBy` work hand in hand to update the sort button and add the appropriate class to the element when current (or active).

G4Plus Sort Button works for both server-side and client-side sorting as long as you follow the AngularJS / G4Plus web service convention of sorting wherein 'name' is ascending and '-name' is descending.

**NOTE: This directive does NOT sort the data for you. Sorting is either done through the web service or using AngularJS `orderBy` filter.**

Sample JADE usage:
    
    h1 Task Cards
    table.table-lined
      thead
        tr(current-sort-col="params.sort")
          th(sort-by="cardNumber") Card Number
          th(sort-by="title") Title        
    
currentSortCol
----
This directive provides its child directive `sortBy` access to the current active sort column by way of exposing a controller.

Sample Usage:

    tr(current-sort-col="myCurrentSort")

### Attributes
- `current-sort-col` (required) is two-way binding attribute (=) that indicates the current active sort column to be passed to the directive. The `sortBy` directive will  

sortBy
----
This directive appends a sorting button that updates depending on what the assigned current active sort column. Clicking the button sets the current to the sortBy column value. This needs the parent `current-sort-col` to work.

Sample JADE Usage:

    th(sort-by="name")

### Attributes
- `sortBy` (required) is a text isolate scope attribute (@) for the column name value.