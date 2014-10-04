# G4 Pagination Directive

This repository hosts pagination components used by the CRUD List actions.
The following components are hosted here:

 * Page Size Selection
 * Pagination message
 * Pagination navigation

## Usage example

The easiest way is to add `g4plus.pagination` as a module in your `app.coffee`.

In your template file where you want to use:

```jade
div(g4-pagination-pagesize, page-size="pageSize", page-size-change="pageSizeChange")

div(g4-pagination-message, current-page="currentPage", page-size="pageSize", total-items="totalItems")

div(g4-pagination-navigation, current-page="currentPage", total-pages="totalPages", page-change="pageChange")

```

Where `pageChange` and `pageSizeChange` are functions in your scope that informs the controller that the page and page size were changed.