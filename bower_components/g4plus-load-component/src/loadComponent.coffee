loadComponent = angular.module 'g4plus.load-component', ['g4plus.retry-call']

loadComponent.directive 'loadComponent', [
  'RetryCall'
  '$compile'
  '$rootScope'
  (RetryCall, $compile, $rootScope) ->
    restrict: 'EA'
    priority: 0,
    terminal: true,
    replace: false,
    transclude: false,
    link: (scope, element, attrs, ctrl) ->
      # Create a clean new scope that will be injected into compiled
      # dom.
      newScope = $rootScope.$new()
      newScope.loadId = element.attr('load-id')
      newScope.loadType = element.attr('load-type')
      newScope.loadDelay = element.attr('load-delay')
      newScope.replaceSpinner = element.attr('replace-spinner')

      # We don't want to immediately initialize scope settings
      # for our directive.
      init = () ->

        scope.requests = RetryCall.getRequests()
        scope.loading = false
        scope.startTime = null
        scope.timelock = true

        if scope.loadDelay is undefined then scope.loadDelay = -1

        requestsHandler = (current) ->
          if scope.startTime is null or (current - scope.startTime >= scope.loadDelay)
            scope.loading = false
            scope.startTime = null

          for key, request of scope.requests
            if request.loadId is scope.loadId
              if scope.startTime is null then scope.startTime = current
              scope.loading = true
              break
          return

        scope.$on 'RetryCall:requests', () ->
          current = (new Date()).getTime()
          if scope.startTime isnt null and scope.loadDelay > -1
            if scope.timelock
              scope.timelock = false
              setTimeout () ->
                current = (new Date()).getTime()
                scope.timelock = true
                requestsHandler(current)
                scope.$apply()
              , scope.loadDelay - (current - scope.startTime)

          requestsHandler(current)

      if newScope.loadType is undefined
        init()
        return

      # Gets skipped of load type is defined
      switch(newScope.loadType.toLowerCase())
        when 'spinner'
        # Build and compile our spinner gif
          container = angular.element '<div></div>'
          spinnerGif = angular.element '<img load-component ng-show="loading" src="data:image/gif;base64,R0lGODlhEAAQAPIAAP///wAAAMLCwkJCQgAAAGJiYoKCgpKSkiH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAEAAQAAADMwi63P4wyklrE2MIOggZnAdOmGYJRbExwroUmcG2LmDEwnHQLVsYOd2mBzkYDAdKa+dIAAAh+QQJCgAAACwAAAAAEAAQAAADNAi63P5OjCEgG4QMu7DmikRxQlFUYDEZIGBMRVsaqHwctXXf7WEYB4Ag1xjihkMZsiUkKhIAIfkECQoAAAAsAAAAABAAEAAAAzYIujIjK8pByJDMlFYvBoVjHA70GU7xSUJhmKtwHPAKzLO9HMaoKwJZ7Rf8AYPDDzKpZBqfvwQAIfkECQoAAAAsAAAAABAAEAAAAzMIumIlK8oyhpHsnFZfhYumCYUhDAQxRIdhHBGqRoKw0R8DYlJd8z0fMDgsGo/IpHI5TAAAIfkECQoAAAAsAAAAABAAEAAAAzIIunInK0rnZBTwGPNMgQwmdsNgXGJUlIWEuR5oWUIpz8pAEAMe6TwfwyYsGo/IpFKSAAAh+QQJCgAAACwAAAAAEAAQAAADMwi6IMKQORfjdOe82p4wGccc4CEuQradylesojEMBgsUc2G7sDX3lQGBMLAJibufbSlKAAAh+QQJCgAAACwAAAAAEAAQAAADMgi63P7wCRHZnFVdmgHu2nFwlWCI3WGc3TSWhUFGxTAUkGCbtgENBMJAEJsxgMLWzpEAACH5BAkKAAAALAAAAAAQABAAAAMyCLrc/jDKSatlQtScKdceCAjDII7HcQ4EMTCpyrCuUBjCYRgHVtqlAiB1YhiCnlsRkAAAOwAAAAAAAAAAAA==" alt="Loading..."/>'
          $compile(spinnerGif)(newScope)

          # Clean up our element before cloning
          element.removeAttr 'load-component'
          element.removeAttr 'load-id'
          element.removeAttr 'load-type'
          eleClone = element.clone()
          $compile(eleClone)(scope)

          if newScope.replaceSpinner? and newScope.replaceSpinner
            containClone = angular.element '<div load-component ng-show="!loading"></div>'
            $compile(containClone) newScope
            containClone.append eleClone
            container.append spinnerGif
            container.append containClone
          else
            container.append spinnerGif
            container.append eleClone

          # Append our content and clean up our element
          contents = container.contents()
          element.after contents
          element.remove()
          break
        when 'progress'
          container = angular.element '''
                  <div load-component ng-show="!loading"></div>
                '''
          # Compile before adding extra content
          $compile(container)(newScope)

          progressBar = angular.element '''
                  <div load-component ng-show="loading" class="progress progress-striped active">
                    <div class="progress-bar" role="progressbar" style="width: 100%">
                      <span>Loading ...</span>
                    </div>
                  </div>
                '''
          # Compile progress bar to have correct scope
          $compile(progressBar)(newScope)

          # Through the content that needs to be hidden on load
          # into our div.
          content = element.contents()
          $compile(content)(scope)
          container.append(content)

          # Clean up our element
          element.empty()
          element.removeAttr('load-component')
          element.removeAttr('load-id')
          element.removeAttr('load-type')

          # Append the orginal content to be hidden on load
          # as well as the progress bar that will shown when
          # loading.
          element.append(container)
          element.append(progressBar)
          break
        when 'splash'
          backdrop = angular.element '<div load-component ng-show="loading" style="z-index:10000;display:inline-block;position:fixed;left:0;top:0;height:100%;width:100%;opacity:.9;background:black"></div>'
          modal = angular.element '''
                  <div ng-show="loading" style="width:200px;position:fixed;top:50%;left:50%;margin-left:-100px;" class="progress progress-striped active">
                    <div class="progress-bar" role="progressbar" style="width: 100%">
                      <span>Loading ...</span>
                    </div>
                  </div>
                '''
          backdrop.append modal
          element.after backdrop
          $compile(backdrop)(newScope)
          element.remove()
          break
      return
]