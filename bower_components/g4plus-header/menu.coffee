"use strict"

app = angular.module "mx.menu", [
  'menu-nav.jade',
  'ngResource',
  'g4plus-clock',
  'g4plus-user'
  "g4plus-breadcrumb.directive"
  "g4plus-forbidden.directive"
  "g4-app-code"
  "ui.router.util"
]

app.factory "MenuProvider", ($http) ->
  list: (role, s, e) ->
    $http.get("/app/list/", {
      params:
        role: role
    }).success(s).error(e)

app.factory "MenuDictionary", () ->
  contractions:
    "maintenance ": "Maint. "
    "engineering": "Eng."
    " information": " Info"
    " operations": " Ops."
    "reservation ": "Res. "
    " and ": " & "
    "accounts payable ": "AP "
    "credit card" : "Card"
  replace: (text) ->
    contractions = this.contractions
    toReplace = []
    angular.forEach this.contractions, (replacement, pattern) ->
      toReplace.push pattern
    regex = new RegExp toReplace.join('|'), 'ig'
    text.replace regex, ($0) ->
      if contractions[$0.toLowerCase()]
        contractions[$0.toLowerCase()]
      else
        $0

app.factory "RecentApps", () ->
  return []

app.factory "LogApps", (RecentApps, $location) ->
  return {
  log: (appId, appName) ->
    appsList = RecentApps
    found = false
    for i in appsList
      if i.id == appId
        found = true
    if !found
      appsList.push {id:appId, name:appName, path:$location.path()}
  }

app.filter "shorten", [
  'MenuDictionary'
  (MenuDictionary) ->
    (text) ->
      MenuDictionary.replace(text)
]

app.filter "removeUnderscore", [
  () ->
    (text) ->
      text.replace /_/g, " "
]

app.controller "MenuCtrl", [
  '$scope'
  '$element'
  '$window'
  'RecentApps'
  'MenuProvider'
  'MenuDictionary'
  ($scope, $element, $window, RecentApps, MenuProvider, MenuDictionary) ->
    # close the popover menu when recent apps are clicked
    $element.find('.recent').on "click", 'a', () ->
      $(this).closest('.popover').toggle()

    $searchTrigger = $element.find('.search > a')
    $scope.recentApps = RecentApps
    $scope.breadcrumbSelector = '.apps ul.breadcrumbs'
    $scope.searchTerm = undefined

    # Find breadcrumbs
    $breadcrumbs = $element.find($scope.breadcrumbSelector)

    $scope.searchTrigger = () ->
      # Toggle the display of the sibling form
      $searchForm = $searchTrigger.siblings('form')
      $searchForm.toggleClass('hide')

      # Toggle some stuff depending on the display mode of the search form
      if $searchForm.hasClass 'hide'
        # hide crumbs
        if !!$breadcrumbs && !!$breadcrumbs.length
          $breadcrumbs.removeClass 'hide'

        $scope.searchTerm = ''
      else
        if !!$breadcrumbs && !!$breadcrumbs.length
          $breadcrumbs.addClass 'hide'

      return

]

app.controller "NavCtrl", [
  '$scope'
  '$element'
  '$resource'
  '$compile'
  '$location'
  '$window'
  '$filter'
  'MenuProvider'
  'MenuDictionary'
  'UserProvider'
  ($scope, $element, $resource, $compile, $location, $window, $filter,
   MenuProvider, MenuDictionary, UserProvider) ->

    # get the popover
    $popover = $element.closest('.popover')
    $popover.click (ev)->
      prevent(ev)

    # set the apps list menu trigger
    $($scope.trigger).click (ev) ->
      $popover.toggle()

      # if $popover.css('display') == 'block'
      #  sw = $('div.slideWrap')

      prevent(ev)

    # close menu popover when something else is clicked
    $(document).click (ev) ->

      # Detect if IE
      # IE bug, when the popover closes, the scrollLeft position reverts to 0.
      # sw = $('div.slideWrap')
      #if !!navigator.userAgent and (navigator.userAgent.match /trident/ig) and !!sw.attr('data-scrollleft')
      #  sw.scrollLeft(sw.attr('data-scrollleft'))

      if $popover.css('display') == 'block'
        $popover.hide()

    # set defaults
    $scope.depth = $scope.depth || 3
    $scope.listWidth = $scope.listWidth || 250
    # default val doesn't really mean anything

    # set some vars
    $startList = $element
    animationSpeed = 100
    currentDepth = 0
    origWidth = $scope.listWidth
    #origHeight = $startList.height()

    # encompass list in some wrapper divs
    $startList.wrap('<div class="slideWrap"><div class="sliding"></div></div>')
    $startList.css
      width:origWidth

    # style the new container wrapper
    $newContainer = $('div.slideWrap')
    $newContainer.css
      "position": "relative"
      "width": "100%"
      "overflow-x": "hidden"
      "overflow-y": "scroll"
    $newContainer.attr('data-scrollleft', 0)
    $newContainer.scrollLeft(0)

    # container that extends to accomodate panels
    $slidingContainer = $('div.sliding')
    $slidingContainer.css
      "width": (origWidth * $scope.depth)

    reset = () ->
      currentDepth = 0
      $newContainer
        .animate({scrollLeft: 0}, animationSpeed)
        .attr('data-scrollleft', 0)

      hideOtherMenus(currentDepth)

      # Wipe all breadcrumbs except 'home'
      if $scope.breadcrumbs
        $($scope.breadcrumbs + ' li:gt(0)').remove()

    up = (levels) ->
      levels = levels || 1

      if currentDepth > 0
        currentDepth = Math.abs(currentDepth-levels)

      newScrollLeft = (origWidth*currentDepth)

      $newContainer
        .animate({scrollLeft: (if ((newScrollLeft) > 0) then newScrollLeft else 0)}, animationSpeed)
        .attr('data-scrollleft', newScrollLeft)

      hideOtherMenus(currentDepth)

      # Remove crumbs
      if($scope.breadcrumbs)
        removeCrumbs(levels)

      return

    down = (crumbText) ->
      currentDepth++
      scrollLeft = origWidth*currentDepth

      # Move the viewable pane to the subMenu
      $newContainer
        .animate({scrollLeft: scrollLeft}, animationSpeed)
        #.attr('data-scrollleft', scrollLeft)

      if $scope.breadcrumbs
        $($scope.breadcrumbs).append('<li>&rsaquo;</li><li><a href="#" data-depth="'+currentDepth+'">'+ crumbText + '</a></li>')

      return

    removeCrumbs = (crumbCount) ->
      keep = $($scope.breadcrumbs).children().length - (2*Math.abs(crumbCount))

      keep = if ((keep-1) < 0) then 0 else (keep-1)

      # Note: :gt(index) starts at 0
      $($scope.breadcrumbs + ' li:gt('+(keep)+')').remove()

      return

    hideOtherMenus = (depth) ->
      # Hide Child Submenus
      $("ul[data-depth]").each () ->
        $this = $(this)
        if $this.attr('data-depth') > depth
          $this.hide()

    prevent = (ev) ->
      ev.preventDefault()
      ev.stopPropagation()

    menuTitleSearch = (needle, haystack) ->
      matches = []
      pattern = new RegExp needle, 'i'

      menuSearch = (needle, haystack) ->
        if angular.isArray haystack
          for i of haystack
            if haystack[i].name.match pattern
              matches.push haystack[i]

            if haystack[i].children.length
              menuSearch needle, haystack[i].children

      menuSearch needle, haystack

      return matches

    if $scope.homeButton
      # Go back to start
      $($scope.homeButton).click (ev) ->
        prevent(ev)
        reset()

    if $scope.breadcrumbs
      $($scope.breadcrumbs).on 'click', 'a', (ev) ->
        ev.preventDefault()
        crumbDepth = parseInt($(this).attr('data-depth'))
        if crumbDepth && (crumbDepth < currentDepth)
          levels = currentDepth-crumbDepth
          up(levels)

    $scope.up = (levels, $event) ->
      prevent($event)
      up(levels)

    $scope.showSubmenu = (menuItem, $event) ->

      # Scroll the panel to the top
      $newContainer.scrollTop 0

      # Clicked anchor
      clickedAnchor = angular.element $event.currentTarget

      # Sibling Menu
      siblingMenu = clickedAnchor.next()

      # Submenu already exists so just scroll
      if siblingMenu.length
        siblingMenu.show()

        # Scroll
        down(clickedAnchor.find('strong').text())

      else if menuItem.children.length
        $scope.tempMenuItemChildren = menuItem.children

        subMenu = angular.element '<div submenu></div>'
        subMenu.attr "item-list", "tempMenuItemChildren"
        subMenu.attr "data-depth", (currentDepth+1)
        subMenu.attr "go-up", "up"
        subMenu.attr "go-show-submenu", "showSubmenu"

        subMenuHTML = $compile(subMenu)($scope)

        clickedAnchor.parent().append(subMenuHTML)

        subMenuHTML.css(
          width: origWidth
          position: "absolute"
          left:parseInt(origWidth)
          top: 0
        ).show()

        # Scroll
        down(clickedAnchor.find('strong').text())

      # Has no children so check the application stuff
      else

        if !!menuItem.url && !menuItem.url.match /^\/.+/
          menuItem.url = '/' + menuItem.url

      return

    $scope.items = undefined
    $scope.originalData = undefined
    $scope.message = null

    $scope.$watch "searchFilter", (newVal) ->
      if !!newVal and !!$scope.originalData
        $scope.items = menuTitleSearch newVal, $scope.originalData
        reset()
      else
        $scope.items = $scope.originalData

    callbacks =
      roleSuccess: (user) ->
        userRole = null
        if !!user.roles and user.roles.length
          userRole = user.roles.join(',')
          MenuProvider.list userRole, callbacks.listSuccess, callbacks.listError
        else
          callbacks.roleError { message: "User roles are not defined" }, 400, null, null

      roleError: (data, status, headers, config) ->
        message = if !!data.message then data.message else "Invalid permissions"

        $scope.message =
          level: "danger"
          message: message
          tagline: "Error"
          icon: "remove"
          action: ''
          status: status or 500

      listSuccess: (menuItems) ->
        if menuItems.length
          $scope.items = menuItems
          $scope.originalData = menuItems
        else
          callbacks.listError { message: "User roles have empty permissions" }, 400, null, null

      listError: (data, status, headers, config) ->
        $scope.message =
          level: "danger"
          message: data.message or "Could not retrieve menu"
          tagline: "Error"
          icon: "remove"
          action: ''
          status: status or 500

    # Query top level menu items, pass them via attribute to the directive
    UserProvider.getUser().then callbacks.roleSuccess, callbacks.roleError

]

app.directive "appsList", () ->
  restrict: 'A'
  scope:
    depth: '@'
    backButton: '@'
    homeButton: '@'
    breadcrumbs: '@'
    listWidth: '@'
    trigger: '@'
    searchFilter: '@'
  templateUrl: "template/menu-nav.jade"
  controller: "NavCtrl"

app.directive "submenu", () ->
  restrict: 'A'
  replace: true
  scope:
    itemList: '='
    goUp: '&'
    goShowSubmenu: '&'
  template: """
    <ul class="list-unstyled">
      <li>
        <a class="back" ng-click="up(1, $event)">
          <i class="icon-circle-arrow-left"></i>
          <strong>Back</strong>
        </a>
      </li>
      <li ng-repeat="item in items">
        <a href="javascript:void(0);" ng-click="showSubmenu(item, $event)">
          <i class="g4_icon {{item.code}}"></i>
          <strong>{{item.name}}</strong>
        </a>
      </li>
    </ul>
  """
  controller: [
    '$scope'
    '$element'
    '$attrs'
    ($scope, $element, $attrs) ->
      $scope.up = (levels, ev) ->
        $scope.goUp().call this, levels, ev

      $scope.showSubmenu = (menuItem, ev) ->
        $scope.goShowSubmenu().call this, menuItem, ev

      $scope.items = $scope.itemList

      return
  ]

tpl = angular.module "menu-nav.jade", []

tpl.run [
  '$templateCache',
  ($templateCache) ->
    $templateCache.put 'template/menu-nav.jade', [
      '',
      '<p ng-show="message.message" class="alert alert-{{message.level}} margin-left margin-right margin-top" style="width: 357px;">',
      '  <i ng-if="message.level == \'success\'" class="icon-ok-circle"></i>',
      '  <i ng-if="message.level == \'danger\'" class="icon-remove"></i>',
      '  <strong ng-if="message.level == \'success\'">Success: </strong>',
      '  <strong ng-if="message.level == \'danger\'">Error: </strong>',
      '  <span> {{message.message}}.</span>',
      '  <span ng-if="message.status">(Status: {{ message.status }})</span>',
      '</p>',
      '<ul ng-show="items" class="list-unstyled apps-list clearfix">',
      '  <li ng-repeat="item in items" ng-show="!item.parentCode">',
      '    <a href="javascript:void(0);" ng-click="showSubmenu(item, $event)">',
      '     <i class="g4_icon {{item.code}}"></i>'
      '     <strong>{{item.name}}</strong>',
      '    </a>',
      '  </li>',
      '</ul>',''
    ].join "\n"
]