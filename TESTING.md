Workflow
========

Unit tests are started with the `test.sh` script that is found in each module's repository
under `scripts/test.sh`. However you might want to fiddle with some settings found in
`test/karma.conf.js` to adapt the way tests are run to your workflow. Among the interesting
settings, to consider:

  * `singleRun` can be set to **false**, as to have imediat feedback while you write your tests.
  * `coverageReporter/type`, while the Jenkins server will run the tests with the `junit` output
type, you might consider using the `text` type which will output in the terminal windows your coverage
report. And when you want to squeeze coverage upwards and onwards 85% it gets easier to switch to the
`html` type which will generate a navigable report page with highlighted areas; this generated file
is normally found at `test/coverage/PhantomJS (some identifier)/index.html`

**NOTE**: the coverage report is generated for the compiled program, as such you will see in your
tests report the file \_public/app.js 


Testing skeleton and sample module
==================================

Each test has a specific form, generally there are three types of sections; which will be denoted
inside ++SECTION++ for easy referencing. The overall structure is the following:

```coffee
"use strict"

describe "List controller", () ->
    beforeEach () -> module "app.list"

    controller = undefined
    scope      = undefined
    ++VARIABLES++

    createController = () ->
        controller "ListCtrl",
            $scope: scope
            ++INJECTED MOCKS++

    beforeEach inject ($controller, $rootScope, ++INJECTION DEPENDENCIES++) ->
        controller = $controller
        scope      = $rootScope.$new()
        ++MOCKING++

    it "should work", () ->
        createController()
        ++TEST CASES++
```

This basic skeleton (minus the ++SECTIONS++) will have enough configuration necessary to bootstrap
a controller and have a shared `scope` in order to reference variables set inside the controller upon
initialization run.

For future examples, and compatibility with the test skeleton, consider the following sample controller:

```coffee
app = angular.module "app.list", []

app.controller "ListCtrl", [
  '$scope'
  'ListService'
  ($scope, ListService) ->
    $scope.items = []

    ListService.query()
      .$promise
      .then (items) ->
        $scope.items = items
```


Asserting scope changes and service mocks
=========================================

With the given sample test and module, we can change the ++TEST CASES++ to

```coffee
expect(scope.items).toEqual([])
```

Consider that this call is after the `createController` invocation, meaning that evaluation of local
variables will take place. The coverage report will look something like (+ used for covered code, and -
for code left out).

```text
+app = angular.module "app.list", []

+app.controller "ListCtrl", [
+  '$scope'
+  'ListService'
+  ($scope, ListService) ->
+    $scope.items = []

+    ListService.query()
-      .$promise
-      .then (items) ->
-        $scope.items = items
```

For the remainder of the code, we are required to mock the `ListService`. In order to do that, we must
make three distinctive changes.

 1. Change the ++VARIABLES++ section with `ListServiceMock = {}`
 2. In order to inject the mock in the controller, change the ++INJECTED MOCKS++ section with
`ListService: ListServiceMock`
 3. Create a promise like interface to the query method, and a jasmine spy so that we know that the
service has been called. Replace ++MOCKING++ with the following

```coffee
ListServiceMock.query = jasmine.createSpy "query"
ListServiceMock.query.andReturn
  $promise:
    then: (thenFunction) ->
      thenFunction([1,2,3])
```

Then the ++TEST CASES++ section will be the following

```coffee
expect(ListServiceMock.query).toHaveBeenCalled()
expect(scope.items).toEqual([1,2,3])
```


Testing conditionals
====================

Suppose that in the original example module listed, we also have the following code block:

```coffee
$scope.open = () ->
  $scope.status = window.confirm "Confirm open dialog"
```

Since we want to have both `window.confirm` to return true and false, we would create two
different test cases, with the following mocking strategy.

```coffee
it "should set status TRUE on confirmation", () ->
  spyOn(window, 'confirm').andReturn true
  createController()
  scope.open()
  expect(window.confirm).toHaveBeenCalled()
  expect(scope.status).toEqual true

it "should set status FALSE on confirmation", () ->
  spyOn(window, 'confirm').andReturn false
  createController()
  scope.open()
  expect(window.confirm).toHaveBeenCalled()
  expect(scope.status).toEqual false
```

Notice that for this scenario we started mocking the `window.confirm` call inside the test case
(due to the fact that it has two states). The `scope.open()` call should be self explanatory,
since that is the way we can execute the code block we are about to test.

