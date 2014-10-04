G4Plus Breadcrumb Directive
===========================

## Installation

* Included inside `g4plus-header`



Custom State example(only with ui-router)

```CoffeeScript
  $stateProvider.state "custom", {
          url: "/custom"
          template: '''
            <p>Custom view</p>
          '''
          data:
            pageTitle: "custom page"
            breadcrumbs:
              urlPrefix: "view"
              urlSuffix: "/summary"
              custom: true
              includeList: true
              listIndex: 0
              routes: [
                {title: "foo", url:"/foo"},
                {title: "bar", url: "/bar"},
                {title: "Custom", url:"/custom"}
              ]
        }
  }
```
