"use strict"

# `g4plus-clock`
# ========================
# Module that controls the clock timezone dropdown. It allows you to
# select a timezone and save it in a cookie.
clock = angular.module 'g4plus-clock', ['ngCookies', 'ui.bootstrap']

# `Cookies`
# ------------------------
# Cookies factory for creating, reading and deleting cookies.
# These are functions created by Peter-Paul Koch of [quirksmode]
# See: http://www.quirksmode.org/js/cookies.html
#
# @returns {Object}
clock.factory "Cookies", () ->
  # ### `createCookie`
  # Generates a cookie based on name, value and days to live.
  #
  # @param {string} name Name of the cookie.
  # @param {string} value Data contained by the cookie.
  # @param {integer} days Number of days to live. Using a negative number
  #   will delete the cookie immediately while a zero will allow the cookie
  #   to live until the browser app is terminated.
  createCookie: (name, value, days) ->
    if days
      date = new Date()
      date.setTime date.getTime() + (days * 24 * 60 * 60 * 1000)
      expires = "; expires=" + date.toGMTString()
    else
      expires = ""
    document.cookie = name + "=" + value + expires + "; path=/"

  # ### `readCookie`
  # Reads a cookie's name.
  #
  # @param {string} name Name of the cookie.
  readCookie: (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0
    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null

  # ### `eraseCookie`
  # Creates a cookie with a negative number which in turn deletes it.
  #
  # @param {string} name Name of the cookie.
  eraseCookie: (name) ->
    @createCookie name, "", -1

# `ClockCtrl`
# ------------------------
# Controller than handles the clock and saving of the timezone.
#
clock.controller('ClockCtrl', [
    '$scope',
    '$element',
    'Cookies'
    ($scope, $element, Cookies) ->
      $scope.timezones =
        GMT: {offset: 0, dst: false, selected: true}
        EST: {offset: -5, dst: 'EDT', selected: false}
        CST: {offset: -6, dst: 'CDT', selected: false}
        MST: {offset: -7, dst: 'MDT', selected: false}
        PST: {offset: -8, dst: 'PDT', selected: false}
        HAST: {offset: -10, dst: false, selected: false}

      # Extending Nate's clock
      # Store selected zone in a cookie
      saveTimeZone = (selectedTimeZone) ->
        if $scope.timezones[selectedTimeZone.zoneKey]
          setSelectedZone selectedTimeZone.zoneKey
          Cookies.createCookie 'savedTimeZoneKey', selectedTimeZone.zoneKey, 365

      # Set 'selected' to false for everything that's different from what's been selected
      setSelectedZone = (selectedZoneKey) ->
        angular.forEach $scope.timezones, (val, key) ->
          $scope.timezones[key].selected = (key == selectedZoneKey) ? true : false

        update()

      updateTime = () ->
        $first = $element.find 'span'
        item = $scope.selectedClockItem
        if item?.zone
          item.time = moment.utc().zone(-1*item.offset).format('HH:mm:ss')
          angular.element($first[0]).html ' ' + item.time + ' ' + item.zone + ' ' if $first?[0]

        $links = $element.find 'a'
        angular.forEach $links, (link, key) ->
          if $scope.clockItems?[key]
            item = $scope.clockItems[key]
            item.time = moment.utc().zone(-1*item.offset).format('HH:mm:ss')
            angular.element(link).html ' ' + item.time + ' ' + item.zone + ' '

      update = () ->
        # momentjs is required, add as dependency
        isDst = moment().isDST()

        $scope.clockItems = []
        $scope.selectedClockItem = {}

        angular.forEach $scope.timezones, (value, key) ->
          item =
            offset: value.offset
            zone: key
            zoneKey: key

          if value.dst and isDst
            item.offset = item.offset + 1
            item.zone = value.dst

          if value.selected
            $scope.selectedClockItem = item
          else
            $scope.clockItems.push(item)
          return

        updateTime()
        return

      # Read saved time zone cookie
      savedTimeZoneKey = Cookies.readCookie 'savedTimeZoneKey'

      # Set the timezone if key from cookie is present
      if savedTimeZoneKey
        setSelectedZone(savedTimeZoneKey)
      else
        update()

      # Fixed memory issue
      setInterval updateTime, 1000

      # Make saveTimeZone click event available to scope
      $scope.saveTimeZone = saveTimeZone;

  ])