# * @fileoverview Ths file contains the list_state service
# * @author       Eric Storch (eric.storch@allegiantair.com)
# * @module       services.list_state
module = angular.module 'services.list_state', []

# ListState Factory
# ==========
# Handles the setting and getting of the list view's state parameters
module.factory 'ListState', () ->
  # Parameters object
  params =
    pagination:
      page: 1
      pageSize: 10
    filters:
      programGroupId: ''
      filter_value: ''
      filter_option: '_all'

    sorting: 'code'

  # Parameter getter
  # --------
  # Returns stored parameters object
  # * @return {object}
  getParams: () ->
    params

  # Parameter setter
  # --------
  # Recieves a parameters object and stores it
  # * @param {object} prms
  setParams: (prms) ->
    params.filters.filter_value = if (prms.filter_value) then prms.filter_value else ''
    params.filters.filter_option = if (prms.filter_option) then prms.filter_option else '_all'
    params.filters.programGroupId = if (prms.programGroupId) then prms.programGroupId else ''
    params.pagination.pageSize = if (prms.pageSize) then prms.pageSize else 10
    params.pagination.page = if (prms.page) then prms.page else 1
    params.sorting  = if (prms.sort) then prms.sort else 'code'

  # URL generator
  # --------
  # Generates a url based off of the current parameters object
  # * @return {string}    A URL string desribing the current view
  getListStateUrl: () ->
    if not params.filters.programGroupId
      params.filters.programGroupId = ''

    "/list?programGroupId=" + params.filters.programGroupId +
    "&filter_option=" + params.filters.filter_option +
    "&filter_value=" + params.filters.filter_value +
    "&pageSize=" + params.pagination.pageSize +
    "&page=" + params.pagination.page +
    "&sort=" + params.sorting