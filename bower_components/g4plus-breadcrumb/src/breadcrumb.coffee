'use strict'

breadcrumb = angular.module 'g4plus-breadcrumb.directive', [
  'ui.router'
  'ngRoute'
]
breadcrumb.service "SetUrlRoutes", () ->
  crumbRoutes = {
    view:"/view/"
    edit:"/edit/"
    add:"/add"
  }
  set: (states) ->
    for state in states
      if _.contains(state.url, "add")
        url = state.url.replace(/:.+/g, "")
        crumbRoutes.add = url
      if _.contains(state.url, "create")
        url = state.url.replace(/:.+/g, "")
        crumbRoutes.add = url
      if _.contains(state.url, "view")
        url = state.url.replace(/:.+/g, "")
        crumbRoutes.view = url
      if _.contains(state.url, "detail")
        url = state.url.replace(/:.+/g, "")
        crumbRoutes.view = url
      if _.contains(state.url, "edit")
        url = state.url.replace(/:.+/g, "")
        crumbRoutes.edit = url

  get: () ->
    crumbRoutes

breadcrumb.service "Breadcrumbs", ($rootScope, $location, SetUrlRoutes, $state, $timeout) ->
  crumbs = []
  listUrl = "/list"
  setRootParams = () ->
    $rootScope.$on("$locationChangeSuccess", () ->
      if $location.path().match "list"
        listUrl = $location.url()
    )
  getRootParams = () ->
    listUrl
  set = (state, params, custom) ->
    paramId = _.values(params)

    routes = SetUrlRoutes.get()
    crumbs = []
    if $location.path().match "list"
      if state.data?.breadcrumbs?.custom? != true
        setRootParams()
        crumb = {title: "List",url: listUrl}
        crumbs.push(crumb)
    if $location.path().match routes.view
      if state.data?.breadcrumbs?.custom? != true
        getRootParams()
        crumb = [
          {title: "List",url: listUrl}
          {title: "View",url: "#{state.url}#{paramId}"}]
        crumbs = crumb
    if $location.path().match routes.edit
      if state.data?.breadcrumbs?.custom? != true
        getRootParams()
        crumb = [
          {title: "List",url: listUrl},
          {title: "View",url: "#{routes.view}#{paramId}"},
          {title: "Edit",url: "#{state.url}#{paramId}"}
        ]
        crumbs = crumb
    if $location.path().match routes.add
      if state.data?.breadcrumbs?.custom? != true
        getRootParams()
        crumb = [
          {title: "List",url: listUrl},
          {title: "Add",url: "/"}
        ]
        crumbs = crumb
    else
      if custom?
        for state in custom
          prefix = state.data?.breadcrumbs?.urlPrefix or ""
          suffix = state.data?.breadcrumbs?.urlSuffix or ""
          url = prefix + state.url + suffix
          if state.data?.breadcrumbs?.custom? == true
            if $location.path().match(url)
              if state?.data?.breadcrumbs?.routes?
                crumbs = state.data.breadcrumbs.routes
                if state?.data?.breadcrumbs?.includeList == true
                  index = state.data?.breadcrumbs?.listIndex or 0
                  getRootParams()
                  crumbs = _.uniq(state.data.breadcrumbs.routes, "title")
                  crumbs.splice(index,0,{title: "List",url: listUrl})
  @get = () ->
    return crumbs
  $rootScope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
    $timeout(() ->
      set(toState, toParams, $state.get())
    , 0)

  $rootScope.$on "$routeChangeSuccess", (event, toRoute, zfromRoute) ->
    $timeout(() ->
      toRoute.url = toRoute.$$route.originalPath
      set(toRoute, toRoute.params, [])
    , 0)
  return


# Directive
breadcrumb.directive 'g4plusBreadcrumb', [
  '$route'
  '$state',
  "Breadcrumbs",
  "SetUrlRoutes"
  ($route, $state, Breadcrumbs, SetUrlRoutes) ->
    restrict: 'A'
    replace: true
    templateUrl: 'g4plus-breadcrumb-template.html'
    link: (scope, element, attribute) ->
      SetUrlRoutes.set($state.get())
      scope.breadcrumbs = ()->
        Breadcrumbs.get()

]

# Service

# Template
breadcrumb.run ['$templateCache', ($templateCache) ->
  return $templateCache.put 'g4plus-breadcrumb-template.html', '''
    <div ng-show="breadcrumbs().length">
      <ol class="breadcrumb">
          <li ng-repeat="state in breadcrumbs()">
              <a ng-if="!$last" href="{{ '#' + state.url }}">{{ state.title }}</a>
              <span ng-if="$last">{{ state.title }}</span>
          </li>
      </ol>
    </div>
  '''
]