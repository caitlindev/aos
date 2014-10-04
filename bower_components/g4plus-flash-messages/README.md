# G4 Flash Message Directive

Flash Message directive displays success and error web service messages, and auto retries failed get request with status 500

## Usage example Jade

```jade
p(flash-message, message='flash')
```

## controller example

```coffee
# this is for your error callback.
$scope.flash = FlashStorage.set(
      level: 'danger'
      status: status or 500
      message: data.message or 'Can not retrieve Types at this time'
      ws: config.url
      retry: true
      critical: false
      callback: getTypes
      view: 'list'
    )
# this is for your success callback.
FlashStorage.set(
      level: 'success'
      message: 'Dmi document'
      view: 'view'
    )
# this is used to retrieve messages set from a different controller
$scope.flash = FlashStorage.get('list')
```
`level` success for success messages, danger for error messages.
`status` web service status.
`message` message to display to user.
`ws` web service url.
`retry` true or false for auto retry.
`critical` true or false to show critical failure modal.
`callback` function to be called on successful retry.
`view` which page you want the message to be displayed.