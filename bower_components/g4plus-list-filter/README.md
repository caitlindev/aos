About
=====

This repository hosts list filter directive.

It is shown in the upper right corner of the list page and used to filter out elements from the list.

The following two elements are available:

 1. Input filter - read input from the user
 2. Dropdown filter option selection (optional)

 This element is optional, you need to use an empty optionsList to make this element   
 dissapear.

Template
========

Include the directive in your jade list template as:

    div.col-md-6(
      g4-list-filter, 
      g4-filter-value="filter_state.value", 
      g4-filter-by="filter_state.filterBy",
      g4-filter-options="filter_state.optionList",
      g4-filter-option="filter_state.option"
    )

Description of the elements from this list.

  * g4-list-filter - **required** activates the directive for this div
  * g4-filter-by - **required**, callback that will be used whenever the input or the dropdown
  is being updated
  * g4-filter-value - **required**, initial value for the filter, passed on from the controller 
  * g4-filter-options - **optional**, an array of objects with all the filtering options available.
  Should use the following format:
        [
         {key: '_all', label: 'All'},
         {key: 'code', label: 'Code'}
        ]
  Not required if filtering is not used.
  * g4-filter-option - **optional**, initial value for the option, passed on from the controller.

  This value is not required if filtering option is not needed.

Controller
==========
Integration with controller is up to the developer. The following is a recomended
guideline for this.

