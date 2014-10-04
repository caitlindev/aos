About
=====

This repository hosts date directive used in forms and display of dates. 

The following components are hosted here:

 * Date directive
 * Date display filters

The following code snipets shows how these can be used in the code:

Directive
=========
The input directive is used to add extra functionality to the input field for
date elements.

      input.form-control(
        name="item_date",
        id='item-date',
        type='text',
        ng-model='item.date',
        ng-disabled="isView",
        ng-blur="item.date = dateFilter(item.date)",
        g4plus-date
        g4plus-date-model-format="YYYY-MM-DD"
        g4plus-date-view-format="MM/DD/YYYY"
        g4plus-date-min="12/30/2014"
        g4plus-date-max="12/30/2015")

Optional parameters:
  * g4plusDateModelFormat - the format used when storing the data, the default is YYYY-MM-DD
  * g4plusDateViewFormat - the format used when showing data, and the default is MM/DD/YYYY
  * g4plusDateMin - inferior limit for date input
  * g4plusDateMax - superior limit for date input

Format is a string parameter usable with moment.js.

Filters
=======

  * **maintenanceDate(input, format)**
    * input should be any of year/month/day, month/day/year (year with 2 and 4 digits)
    * - default is month/day/year, format is optional
  * **unixDate(input, format)**
    * Input should be a unix timestamp (int 32 value).
    * default format is month/day/year, format is optional
