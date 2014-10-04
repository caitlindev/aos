# Autofocus Directive
# ===================
# Make sure you include this module if you want to use the directive
autofocus = angular.module 'g4plus.autofocus', [ ]

autofocus.directive 'g4Autofocus', [
  '$timeout'
  ($timeout) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      # Focus on the element where this directive is defined.
      #
      # Timeout is needed when opening the boostrap window modal dialog
      focusElement = () ->
        $timeout(() ->
          # IE8_HACK: Moving cursor caret to end of text
          str = element.val()
          element.val('')
          element[0].focus()
          element.val(str)
        100
        )
  
      # TODO: Decide if we keep this functionality in the future
      if attrs.g4Autofocus is 'regain-focus'
        # Regain focus after bootstrap modal window closes
        #
        # We are doing this by watching the <body> for class="modal-open" being 
        # defined.
        scope.$watch(
          () ->
            # Watch the output of this function which checks the presence of
            # body.modal-open class
            angular.element('body').hasClass('modal-open')
          (new_value, old_value) ->
            # when <body> looses it's modal-open class focus the filter element
            if !new_value and old_value
              focusElement()
        )

      # The default element focus
      focusElement()
]
