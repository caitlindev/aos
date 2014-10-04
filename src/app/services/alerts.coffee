# * @fileoverview This file contains the Alerts service factory
# * @author       Eric Storch (eric.storch@allegiantair.com)
# * @module       services.alerts
module = angular.module 'services.alerts', []

# Fec Webservice
# ==========
# This is the interface to the /mx-admin/admin/fec web service
# * @param $http  Http module for http communication
module.factory 'Alerts', () ->
  message = ""

  # set
  # --------
  # Stores the passed message string
  # * @param {string} mes  String value to store
  set: (mes) ->
    message = mes

  # get
  # --------
  # Returns the stored message string and clears it from storage
  # * @return {string}
  get: () ->
    message