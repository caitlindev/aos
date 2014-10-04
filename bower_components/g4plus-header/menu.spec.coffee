"use strict"

describe "G4Plus Menu PopOver", () ->

  beforeEach () ->
    module "mx.menu"

  HTML = """
    <div id="menu" ng-controller="MenuCtrl">
      <a id="menu-button" title="G4Plus Menu">
        <img src="img/G4Plus_logo_small.png" width="40" height="29" alt="G4Plus"/>
        <i class="icon-reorder"></i>
      </a>
      <div id="menu-popover" ng-class="recentApps.length ? '' : 'narrow-menu'" class="popover bottom"><span class="arrow"></span>
        <div class="apps col-sm-8 pull-right">
          <div class="menu-toolbar at-the-top clearfix">
          <div class="search pull-left"><a href="javascript:void(0)" ng-click="searchTrigger()"><i class="icon-search"></i></a>
            <form class="hide">
            <input type="text" ng-model="searchTerm" class="form-control ng-override"/>
            <a href="javascript:void(0)" ng-click="searchTrigger()" class="pull-left">Cancel Search</a>
            </form>
          </div>
          <ul class="list-unstyled breadcrumbs clearfix">
            <li><a href="#" class="apps-home">Start</a></li>
          </ul>
          </div>
          <div apps-list="apps-list" trigger="#menu-button" depth="6"
            back-button=".apps-list .back" home-button=".apps-home"
            breadcrumbs="{{breadcrumbSelector}}" list-width="387"
            search-filter="{{searchTerm}}"></div>
        </div>
        <div ng-show="recentApps.length" class="recent col-sm-4">
          <h4>Recent Apps</h4>
          <ul class="list-unstyled">
          <li ng-repeat="app in recentApps"><a href="{{app.path}}"><i class="icon-caret-right"></i>{{app.name}}</a></li>
          </ul>
        </div>
      </div>
    </div>
  """
  menuHTML = angular.element HTML

  mockUser =
  {
    "user":
      "createdAt": 1393539612,
      "aisId": "23973",
      "adId": "mel.cruz",
      "email": "mel.cruz@allegiantair.com",
      "name": "mel cruz",
      "company": "20",
      "roles": [
        "dev_sudo"
      ]
  }
  tmpMockUser = mockUser

  mockMenuItems =
  [
    {
      "id": 1,
      "code": "ac_root",
      "title": "AC",
      "parentId": null,
      "sort": 10,
      "application": null,
      "children": [
        {
          "id": 3,
          "code": "ac_aircraft",
          "title": "Aircraft",
          "parentId": 1,
          "sort": 10,
          "application": null,
          "children": [
            {
              "id": 5,
              "code": "ac_rules",
              "title": "AC Rules",
              "parentId": 3,
              "sort": 10,
              "application": {
                "id": 1,
                "code": "aircraft_rules",
                "name": "Aircraft Rules",
                "url": "ac/aircraft/rules/index.html",
                "description": "",
                "displayModeId": 1,
                "menuId": 5,
                "displayMode": "window"
              },
              "children": []
            },
            {
              "id": 6,
              "code": "ac_tails",
              "title": "AC Tails",
              "parentId": 3,
              "sort": 10,
              "application": {
                "id": 2,
                "code": "aircraft_tails",
                "name": "Aircraft Tails",
                "url": "ac/aircraft/tails/index.html",
                "description": "",
                "displayModeId": 1,
                "menuId": 6,
                "displayMode": "window"
              },
              "children": []
            },
            {
              "id": 7,
              "code": "ac_types",
              "title": "AC Types",
              "parentId": 3,
              "sort": 10,
              "application": {
                "id": 3,
                "code": "aircraft_type",
                "name": "Aircraft Types",
                "url": "ac/aircraft/type/index.html",
                "description": "",
                "displayModeId": 1,
                "menuId": 7,
                "displayMode": "window"
              },
              "children": []
            }
          ]
        }
      ]
    }
  ]

  describe "MenuCtrl Controller", () ->

    # Globally disable jQuery animations
    jQuery.fx.off = true

    menuScope = undefined
    initMenuCtrl = undefined
    menuCtrlElement = undefined

    beforeEach inject ($rootScope, $controller, $window) ->

      menuScope = $rootScope.$new()

      menuCtrlElement = menuHTML

      initMenuCtrl = () ->
        $controller "MenuCtrl",
          $scope: menuScope
          $element: menuCtrlElement
          $window: $window

    it "should have some default variables", () ->
      initMenuCtrl()
      expect(menuScope.recentApps).toBeDefined()
      expect(menuScope.breadcrumbSelector).not.toBe ''
      expect(menuScope.searchTerm).not.toBeDefined()

    it "should have searchTrigger() function", () ->
      initMenuCtrl()
      expect(menuScope.searchTrigger).toBeDefined()
      expect(typeof menuScope.searchTrigger).toBe "function"

      searchTrigger = menuCtrlElement.find('.search > a')
      searchForm = searchTrigger.siblings('form')

      # Assume that we setup breadcrumbs
      breadcrumbs = menuCtrlElement.find(".apps ul.breadcrumbs")

      # Search form appears, breadcrumbs disappear
      menuScope.searchTrigger()
      expect(searchForm.attr('class')).not.toContain "hide"
      expect(breadcrumbs.attr('class')).toContain "hide"

      # The reverse: the search form disappears, the breadcrumbs reappear
      menuScope.searchTrigger()
      expect(menuScope.searchTerm).toBe ''
      expect(breadcrumbs.attr('class')).not.toContain "hide"

      # No breadcrumbs
      # @TODO: Cover the 'else' branch of 'find breadcrumbs'
      menuCtrlElement.find('.apps ul.breadcrumbs').remove()
      menuScope.breadcrumbSelector = ''
      initMenuCtrl()
      menuScope.breadcrumbSelector = ''
      menuScope.searchTrigger()
      menuScope.searchTrigger()

    it "should have toggle on 'click' if .recent is found", () ->
      initMenuCtrl()
      recentAnchor = menuCtrlElement.find('.recent')
      popover = menuCtrlElement.find('.popover')
      expect(popover.attr('style')).not.toBeDefined()
      recentAnchor.find('a:first-child').click()
      expect(popover.attr('style')).toBeDefined()

  describe "NavCtrl Controller", () ->

    initNavCtrl = undefined
    navCtrlScope = undefined
    navCtrlElement = undefined
    navCtrlWindow = undefined
    $documentBody = undefined
    $httpBackend = undefined
    expectUser = undefined
    expectMenuItems = undefined

    removeExtra = () ->
      # Clean extra html tags generated by multiple controller inits
      len = $documentBody.find('.slideWrap').length
      if len > 1
        i = len
        while i > 1
          navCtrlElement.unwrap()
          navCtrlElement.unwrap()
          i--

    beforeEach inject ($rootScope, $controller, $compile, $window, _$httpBackend_) ->

      # Reset DOM
      menuHTML = angular.element HTML

      $httpBackend = _$httpBackend_

      $documentBody = angular.element 'body'
      $documentBody.prepend(menuHTML)
      navCtrlElement = $documentBody.find('div[apps-list]')
      navCtrlScope = $rootScope.$new()
      navCtrlWindow = $window

      expectUser = (result, data) ->
        # Note that mockUser object comes from UserProvider
        # promise, but the .then function's result starts with
        # the .user object.
        result = result or mockUser
        data = data or {}
        $httpBackend.expectGET("/api/login/check").respond result, data

      expectMenuItems = (result, data, convertRole) ->
        result = result or mockMenuItems
        data = data or {}
        convertRole = convertRole or true

        if convertRole and (mockUser.user.roles[0] == 'dev_sudo')
          mainRole = "super_admin"
        else
          mainRole = mockUser.user.roles[0]

        $httpBackend.expectGET("/api/g4-auth-web/v1/api/permission/menu/?role=" + mainRole).respond result, data

      initNavCtrl = () ->
        $controller "NavCtrl",
          $scope: navCtrlScope
          $element: navCtrlElement
          $window: navCtrlWindow

    afterEach () ->
      # Reset template
      if $documentBody.find('div#menu').length
        $documentBody.find('div#menu').remove()

      menuHTML = angular.element HTML

    it "should prevent default and stop propagation on click", () ->
      initNavCtrl()
      popover = navCtrlElement.closest('.popover')

      clickEventObj = jQuery.Event "click"
      spyOn clickEventObj, "stopPropagation"
      popover.trigger clickEventObj
      expect(clickEventObj.stopPropagation).toHaveBeenCalled()

    it "should call functions to the scope.trigger element", () ->

      # Mock incoming attributes
      navCtrlScope.trigger = navCtrlElement.attr('trigger')
      initNavCtrl()
      popover = navCtrlElement.closest('.popover')

      clickEventObj = jQuery.Event "click"
      spyOn clickEventObj, "stopPropagation"

      popoverTrigger = menuHTML.find(navCtrlScope.trigger)
      popoverTrigger.trigger clickEventObj

      expect(clickEventObj.stopPropagation).toHaveBeenCalled()

    it "should attach an click event on the 'document'", () ->

      initNavCtrl()
      $document = angular.element document
      popover = navCtrlElement.closest('.popover')
      popover.css('display', 'block')
      expect(popover.css('display')).toBe "block"

      $document.click()
      expect(popover.css('display')).toBe "none"

      $document.click()
      expect(popover.css('display')).toBe "none"

    it "should have default depth and listWidth", () ->
      initNavCtrl()
      expect(navCtrlScope.depth).toBe 3
      expect(navCtrlScope.listWidth).toBe 250

      # With incoming options
      navCtrlScope.depth = navCtrlElement.attr('depth')
      navCtrlScope.listWidth = navCtrlElement.attr('list-width')
      initNavCtrl()
      expect(navCtrlScope.depth).toEqual '6'
      expect(navCtrlScope.listWidth).toEqual '387'

    it "should go up() when a back button had been clicked", () ->

      # Mock an anchor element
      anchorEl = '<a class="sample-anchor"><strong>'+ mockMenuItems[0].title+'</strong></a>'

      # Build a mocked list
      navCtrlElement.append('<ul><li>' + anchorEl + '</li></ul>')

      # Create an event
      clickEventObj = jQuery.Event "click"
      clickEventObj.currentTarget = $documentBody.find('a.sample-anchor')

      # Mock incoming breadcrumbs
      navCtrlScope.breadcrumbs = ".apps .breadcrumbs"

      initNavCtrl()
      removeExtra()

      newContainer = $documentBody.find('div.slideWrap')

      # Mock a new level first and go 'down'
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)

      # @TODO: Expect that $newContainer has a different scrollLeft value
      # @TODO: Find out why the values are always 0 and can't seem to be edited

      backButton = navCtrlElement.find('.back')
      expect(backButton.length).toBeGreaterThan 0

      # Go 'up'
      clickEventObj.currentTarget = backButton
      spyOn clickEventObj, "preventDefault"
      navCtrlScope.up(1, clickEventObj)

      expect(clickEventObj.preventDefault).toHaveBeenCalled()
      # @TODO: Expect the scrollLeft value of $newContainer

      navCtrlScope.breadcrumbs = undefined
      navCtrlScope.up(1, clickEventObj)
      # @TODO: Expect the scrollLeft value of $newContainer

      # Test a branch
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      navCtrlScope.up(0, clickEventObj)
      # @TODO: Expect the scrollLeft value of $newContainer

    it "should have a down() button when a menu item is clicked", () ->

      # Mock an anchor element
      anchorEl = '<a class="sample-anchor"><strong>'+ mockMenuItems[0].title+'</strong></a>'

      # Build a mocked list
      navCtrlElement.append('<ul><li>' + anchorEl + '</li></ul>')

      # Create an event
      clickEventObj = jQuery.Event "click"
      clickEventObj.currentTarget = $documentBody.find('a.sample-anchor')

      # Mock incoming breadcrumbs
      navCtrlScope.breadcrumbs = ".apps .breadcrumbs"

      initNavCtrl()
      removeExtra()

      # Call showSubmenu and down
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)

      # @TODO: Expect the scrollLeft value of $newContainer

      initNavCtrl()
      removeExtra()

      navCtrlScope.breadcrumbs = undefined
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      expect($documentBody.find('.slideWrap').scrollLeft()).toBe 0

    it "should have a showSubmenu() function", () ->

      # Mock an initial list with menu item
      anchorEl = '<a class="sample-anchor"><strong>'+ mockMenuItems[0].title+'</strong></a>'
      navCtrlElement.append('<ul><li>' + anchorEl + '</li></ul>')
      mockParentItem = $documentBody.find('a.sample-anchor')

      # Create an event
      clickEventObj = jQuery.Event "click"
      clickEventObj.currentTarget = mockParentItem

      initNavCtrl()
      expect(navCtrlScope.showSubmenu).toBeDefined()
      expect(typeof navCtrlScope.showSubmenu).toBe "function"

      # No sibling but with children
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      submenu = navCtrlElement.find('[submenu]')
      backButton = navCtrlElement.find('[submenu]').find('.back')
      expect(submenu.length).toBeGreaterThan 0
      expect(backButton.length).toBeGreaterThan 0
      # @TODO: Expect the scrollLeft value of $newContainer

      # Go up, the submenu is supposed to be hidden.
      clickEventObj.currentTarget = backButton
      navCtrlScope.up(1, clickEventObj)
      expect(submenu.css('display')).toBe "none"

      # With sibling already
      clickEventObj.currentTarget = mockParentItem
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      expect(submenu.css('display')).toBe "block"
      # @TODO: Expect the scrollLeft value of $newContainer

      # Let's remove the mockParentItem sibling
      # to demonstrate opening of an app
      mockParentItem.next().remove()
      tmpMenuItem = mockMenuItems[0].children[0].children[1]
      spyOn navCtrlWindow, "open"

      navCtrlScope.showSubmenu(tmpMenuItem, clickEventObj)
      expect(navCtrlWindow.open).toHaveBeenCalled()

      tmpMenuItem.application.displayModeId = 2
      navCtrlScope.showSubmenu(tmpMenuItem, clickEventObj)
      expect(navCtrlWindow.open.calls.length).toBe 1

    it "should expect a user with role(s)", () ->
      MenuProvider = undefined

      inject (_MenuProvider_) ->
        MenuProvider = _MenuProvider_

      expectUser()

      spyOn MenuProvider, "list"

      initNavCtrl()
      $httpBackend.flush()
      expect(MenuProvider.list).toHaveBeenCalled()

    it "should expect a user with role(s), roles hidden else branch", () ->
      MenuProvider = undefined
      mockUser.user.roles[0] = "another_role"

      inject (_MenuProvider_) ->
        MenuProvider = _MenuProvider_

      expectUser()

      spyOn MenuProvider, "list"

      initNavCtrl()
      $httpBackend.flush()
      expect(MenuProvider.list).toHaveBeenCalled()

      mockUser = tmpMockUser

    it "should call MenuProvider.list even if the roles is empty", () ->
      tmpMockUser =
      {
        "user":
          "createdAt": 1393539612,
          "aisId": "23973",
          "adId": "mel.cruz",
          "email": "mel.cruz@allegiantair.com",
          "name": "mel cruz",
          "company": "20",
          "roles": [
            "dev_sudo"
          ]
      }

      tmpMockUser.user.roles = []

      expectUser(tmpMockUser)
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.message).toBeDefined()
      expect(navCtrlScope.message.message).toBe "User roles are not defined"

    it "should show an 'invalid permissions' error", () ->
      expectUser(400)
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.message).toBeDefined()
      expect(navCtrlScope.message.message).toBe "Invalid permissions"

    it "should show an 'invalid permissions' error, the status 'or' branch", () ->

      UserProvider = undefined
      $controller = undefined

      inject (_UserProvider_, _$controller_) ->
        UserProvider = _UserProvider_
        $controller = _$controller_

      expectedStatus = 400

      # Mock the UserProvider to get to the error callback
      UserProvider =
        getUser: () ->
          then: (success, error) ->
            data = {}
            status = expectedStatus
            headers = null
            config = null
            error {}, status, headers, config

      $controller "NavCtrl",
        $scope: navCtrlScope
        $element: navCtrlElement
        UserProvider: UserProvider

      expect(navCtrlScope.message).toBeDefined()
      expect(navCtrlScope.message.message).toBe "Invalid permissions"
      expect(navCtrlScope.message.status).toBe expectedStatus

    it "should show the error returned by the web service", () ->
      expectUser(400, { message: "Service Error" })
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.message).toBeDefined()
      expect(navCtrlScope.message.message).toBe "Service Error"

    it "should populate $scope.items and $scope.originalData", () ->
      expectUser()
      expectMenuItems()
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.items).toEqual mockMenuItems
      expect(navCtrlScope.originalData).toEqual mockMenuItems

    it "should show an error message", () ->
      expectUser()
      message = "Something went wrong"
      expectMenuItems(400, {message: message})
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.message.message).toBe message
      expect(navCtrlScope.message.status).toBe 400

    it "should show an error if roles are valid but returns empty menu list", () ->
      expectUser()
      expectMenuItems([])
      initNavCtrl()
      $httpBackend.flush()
      expectedMessage = "User roles have empty permissions"
      expect(navCtrlScope.message.message).toBe expectedMessage
      expect(navCtrlScope.message.status).toBe 400

    it "should show an error message from the web service", () ->
      MenuProvider = undefined
      $controller = undefined

      inject (_MenuProvider_, _$controller_) ->
        MenuProvider = _MenuProvider_
        $controller = _$controller_

      MenuProvider =
        list: (role, success, error) ->
          error {message:expectedMessage}, expectedStatus, null, null

      expectedMessage = "Error from service."
      expectedStatus = 400

      $controller "NavCtrl",
        $scope: navCtrlScope
        $element: navCtrlElement
        MenuProvider: MenuProvider
      $httpBackend.resetExpectations()
      expectUser()
      $httpBackend.flush()
      expect(navCtrlScope.message.status).toBe expectedStatus
      expect(navCtrlScope.message.message).toBe expectedMessage
      $httpBackend.resetExpectations()

    it "should show a 'Could not retrieve menu' error message branches", () ->
      MenuProvider = undefined
      $controller = undefined

      inject (_MenuProvider_, _$controller_) ->
        MenuProvider = _MenuProvider_
        $controller = _$controller_

      expectedMessage = "Could not retrieve menu"
      expectedStatus = 500

      MenuProvider =
        list: (role, success, error) ->
          error {}, undefined, null, null

      $controller "NavCtrl",
        $scope: navCtrlScope
        $element: navCtrlElement
        MenuProvider: MenuProvider
      $httpBackend.resetExpectations()
      expectUser()
      $httpBackend.flush()
      expect(navCtrlScope.message.status).toBe expectedStatus
      expect(navCtrlScope.message.message).toBe expectedMessage
      $httpBackend.resetExpectations()

    it "should have a $watch on $scope.searchFilter and run menuTitleSearch()", () ->
      expectUser()
      expectMenuItems()
      initNavCtrl()
      $httpBackend.flush()
      expect(navCtrlScope.items).toEqual mockMenuItems

      navCtrlScope.searchFilter = "rules"
      navCtrlScope.$digest()
      expect(navCtrlScope.items.length).toBe 1
      expect(navCtrlScope.items[0].title).toBe "AC Rules"

      navCtrlScope.searchFilter = ''
      navCtrlScope.$digest()
      expect(navCtrlScope.items).toEqual mockMenuItems

      navCtrlScope.originalData =
        "test": "test"
      navCtrlScope.searchFilter = 'hello'
      navCtrlScope.$digest()
      expect(navCtrlScope.items).toEqual []

    it "should delegate a click event to breadcrumbs", () ->
      navCtrlScope.breadcrumbs = ".apps .breadcrumbs"

      crumbs = $documentBody.find(navCtrlScope.breadcrumbs)

      listItems = [
        '<li>&rsaquo;</li>'
        '<li><a href="#" data-depth="1">Crumb Level 1</a></li>'
      ]

      # Build mock breadcrumbs
      crumbs.append(listItems.join(''))

      initNavCtrl()

      crumb = crumbs.find('a[data-depth]').first()
      expect(crumb.length).toBe 1
      crumb.click()
      # @TODO: Expect no change to scrollleft

      clickEventObj = jQuery.Event "click"
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      crumb.click()
      # @TODO: Expect a change to scrollleft

    it "should remove breadcrumbs with removeCrumbs()", () ->
      navCtrlScope.breadcrumbs = ".apps .breadcrumbs"

      crumbs = $documentBody.find(navCtrlScope.breadcrumbs)

      listItems = [
        '<li>&rsaquo;</li>'
        '<li><a href="#" data-depth="1">Crumb Level 1</a></li>'
        '<li>&rsaquo;</li>'
        '<li><a href="#" data-depth="2">Crumb Level 2</a></li>'
      ]

      # Build mock breadcrumbs
      crumbs.append(listItems.join(''))

      clickEventObj = jQuery.Event "click"

      initNavCtrl()
      expect(crumbs.children().length).toBe 5
      navCtrlScope.up(1, clickEventObj)
      expect(crumbs.children().length).toBe 3
      navCtrlScope.up(1, clickEventObj)
      expect(crumbs.children().length).toBe 1
      navCtrlScope.up(3, clickEventObj)
      expect(crumbs.children().length).toBe 1

    it "should have hideOtherMenus() function", () ->

      # Mock an initial list with menu item
      anchorEl = '<a class="sample-anchor"><strong>'+ mockMenuItems[0].title+'</strong></a>'
      navCtrlElement.append('<ul><li>' + anchorEl + '</li></ul>')
      mockParentItem = $documentBody.find('a.sample-anchor')

      # Create an event
      clickEventObj = jQuery.Event "click"
      clickEventObj.currentTarget = mockParentItem

      # Mock a home button
      navCtrlScope.homeButton = ".apps-home"

      homeButton = $documentBody.find(navCtrlScope.homeButton)
      expect(homeButton.length).toBe 1

      initNavCtrl()
      navCtrlScope.showSubmenu(mockMenuItems[0], clickEventObj)
      subMenu = $documentBody.find('ul[data-depth]').first()
      expect(subMenu.length).toBe 1
      expect(subMenu.css('display')).toBe 'block'
      homeButton.click()
      expect(subMenu.css('display')).toBe 'none'

      subMenu.show()
      subMenu.attr('data-depth', '-1')
      homeButton.click()
      expect(subMenu.css('display')).toBe 'block'

    it "should have reset() function", () ->
      # Mock a home button
      navCtrlScope.homeButton = ".apps-home"
      homeButton = $documentBody.find(navCtrlScope.homeButton)
      expect(homeButton.length).toBe 1
      initNavCtrl()
      homeButton.click()
      # @TODO: expect $newContainer.scrollLeft to be 0

      navCtrlScope.breadcrumbs = ".apps .breadcrumbs"
      homeButton.click()

  describe "MenuProvider factory", () ->

    it "should call permission/menu", () ->
      MenuProvider = undefined
      $http = undefined
      inject (_$http_, _MenuProvider_) ->
        MenuProvider = _MenuProvider_
        $http = _$http_

      spyOn($http, "get").andCallThrough()

      expect(MenuProvider.list).toBeDefined()
      expect(typeof MenuProvider.list).toBe 'function'

      MenuProvider.list(null, 'super_admin', (() ->), (() ->))
      expect($http.get).toHaveBeenCalled()

  describe "MenuDictionary factory", () ->

    it "should shorten certain words", () ->
      MenuDictionary = undefined
      inject (_MenuDictionary_) ->
        MenuDictionary = _MenuDictionary_

      expect(MenuDictionary.replace("Maintenance ")).toEqual 'Maint. '
      expect(MenuDictionary.replace("NotInLibrary")).toEqual 'NotInLibrary'

      # Else branch
      testString =
        replace: (pattern, callback) ->
          callback('MismatchedIndex')

      expect(MenuDictionary.replace(testString)).toBe 'MismatchedIndex'

  describe "LogApps factory", () ->

    it "should add items to RecentApps factory", () ->
      LogApps = undefined
      RecentApps = undefined
      inject (_LogApps_, _RecentApps_) ->
        LogApps = _LogApps_
        RecentApps = _RecentApps_

      expect(RecentApps.length).toBe 0
      LogApps.log(1, "App 1")
      expect(RecentApps.length).toBe 1
      expect(RecentApps[0].name).toEqual 'App 1'

      LogApps.log(2, "App 2")
      expect(RecentApps.length).toBe 2

      spyOn(RecentApps, "push").andCallThrough()
      LogApps.log(1, "App 1")
      expect(RecentApps.push).not.toHaveBeenCalled()

  describe "shorten filter", () ->

    it "should run a replace", () ->
      shortenFilter = undefined
      inject ($filter) ->
        shortenFilter = $filter('shorten')
      expect(shortenFilter('NotInLibrary')).toBe 'NotInLibrary'

  describe "removeUnderscore filter", () ->

    it "should replace underscores with spaces", () ->
      removeUnderscoreFilter = undefined
      inject ($filter) ->
        removeUnderscoreFilter = $filter('removeUnderscore')
      expect(removeUnderscoreFilter('Remove_the_underscores.')).toBe 'Remove the underscores.'

  describe "Submenu Directive", () ->

    someScope = undefined
    submenuScope = undefined
    directive = undefined

    beforeEach inject ($rootScope, $compile) ->
      someScope = $rootScope.$new()
      someScope.itemList = mockMenuItems[0].children[0].children
      someScope.goUp = () ->
        () -> return
      someScope.goShowSubmenu = () ->
        () -> return

      directive = angular.element '<div submenu item-list="itemList" go-up="goUp" go-show-submenu="goShowSubmenu"></div>'

      $compile(directive)(someScope)
      someScope.$digest()

    it "should inherit the itemList", () ->
      # It should produce (itemList.length - 1)
      expect(directive.find('li').length-1).toBe someScope.itemList.length

    it "should call the parent scope's goUp() function", () ->
      spyOn someScope, "goUp"
      backButton = directive.find('.back')
      expect(backButton.length).toBe 1
      backButton.click()
      expect(someScope.goUp).toHaveBeenCalled()

    it "should call the parent scope's goShowSubmenu() function", () ->
      spyOn someScope, "goShowSubmenu"
      expect(directive.find('li').length).toBeGreaterThan 1
      listItemAnchor = directive.find('li:gt(0)').first().children('a')
      expect(listItemAnchor.length).toBe 1
      listItemAnchor.click()
      expect(someScope.goShowSubmenu).toHaveBeenCalled()

  describe "appsList Directive", () ->
    scope = undefined
    tags = menuHTML.find('div[apps-list]')[0]

    it "should", () ->
      inject ($rootScope, $compile, UserProvider) ->
        # Not sure why the 'assign read property error'
        # is showing up when UserProvider is being invoked
        # so we're mocking it
        UserProvider.getUser = () ->
          then: (success, error) ->
            return
        scope = $rootScope.$new()
        scope.breadcrumbSelector = null
        scope.searchTerm = null
        $compile(tags)(scope)
        scope.$digest()
