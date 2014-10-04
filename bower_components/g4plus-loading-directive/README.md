# G4 Loading Directive

The Loading directive provides an opaque overlay with a spinner and a Loading... message

## Usage example

The easiest way is to add `g4plus-loading.directive` as a module in your `app.coffee`.

In your template file where you want to use:

```html
<div g4plus-loading=""></div>
```

You need to add `tracker: 'loading'` parameter on your services which you want to trigger the loading overlay.

```coffeescript
module.factory 'WebService', [
  '$resource'

  ($resource) ->
    return $resource '/api/api-url-goes-here/:id', {}, {
      get: { method: 'GET', tracker: 'loading'}
      query: { method: 'GET', isArray: true , tracker: 'loading'}
      post: { method: 'POST'}
      update: { method: 'PUT'}
    }
]
```