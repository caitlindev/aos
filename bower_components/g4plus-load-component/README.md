# Load Component Module and Component

To include load component add to bower.json file:

```js
"g4plus-load-component": "ssh://git@git.allegiantair.com:7999/BC/g4plus-load-component.git#development"
```

To include the module into your app do:

```js
    angular.module('your_module', ['g4plus.load-component']);
```

## Load component directive

Load component directive can be used as an attribute or element such as:

```html
    <load-component></load-component>
        or
    <div load-component></div>
```

To use this directive, you must include:


##load-id

In your application, you may have several components which can depend on loading different resources. For instance
you might have a section of your html web page to depend on an http get request to fetch a list of users while a
different section of the page may depend on loading cities. Load Id is used with in $http() config as well as the
load-component directive to pair pending $http requests with html page components. load-id can be used to signal that
many components need to show a loading state when working with a remote resource. An example for how to use it is
shown bellow:

```html
    // html file
    <div id="citiesDiv" load-component load-id="cities" load-type="progress">
        ... Misc html stuff ...
    </div>

    <!-- This will go into a loading state with the citiesDiv ( the div above ), because they share the same load-id -->
    <input id="citiesInput" load-component load-id="cities" load-type="spinner"></input>
    .
    .
    .
    <!-- This will load independently from citiesDiv and citiesInput -->
    <div load-component load-id="people" load-type="progress">
            ... Misc html stuff ...
    </div>

    <!-- This will never go into a loading state because it is missing load-id -->
    <div load-component load-type="progress></div>

    // js file

    // Get cities
    $http({
        url: '/cities',
        method: 'GET',
        // The key used to match the http request to the
        // component being loaded is always 'loadId'
        loadId: 'cities'
    });

    // Get people
    $http({
        url: '/people',
        method: 'GET',
        // The key used to match the http request to the
        // component being loaded is always 'loadId'
        loadId: 'people'
    });
```
##load-type:

Load type tells the directive which kind of loading should be done. The different types of loading are such.

###spinner:
This adds an inline spinner to the right of the component that will show when loading. The spinner
most suitable for input typing like search bars.

###progress:
This replaces the content inside the component with a progress bar when loading

###splash:
Splash should not be used on an element with content inside it. It deletes the original element and
creates it's own div. Splash simply displays a giant splash screen with a progress bar modal.

###Examples:
```html
    <input type="text" load-component load-id="cities" load-type="spinner"></input>
    <div id="load_cities" load-component load-id="cities" load-type="progress">
        <ul>
            <li ng-repeat="city in cities">
                {{ city.name }}
                <a ng-click="loadInCityPeople()"> Find People </a>
            </li>
        </ul
    </div>

    <div load-component load-id="people" load-type="splash"></div>

    <!-- This component will never go into a loading state because it doesn't have a load-type -->
    <div load-component load-id="people"></div>
```

##load-delay (optional)

Load delay is the minimum amount of time to show the load state when a request goes it. For instance it only takes 10 ms
for a request to go out and be responded but you want to show the progress bar for at least 2 seconds for testing reasons.
You can then assign a value in milliseconds to load-delay. Example:

```html
    <!-- Shows progress bar for a minimum of 5 seconds -->
    <div load-component load-id='test' load-type='progress' load-delay='5000'></div>
```

##replace-spinner (optional)

Replace spinner replaces the entire content of element that has load-type='spinner'. The option can either be true or
false. If true: Replace content on load. If false: Show spinner to left of content on load. If this option is undefined,
then the default option is false.

Example:

```html
    <!-- Shows progress bar for a minimum of 5 seconds -->
    <div load-component load-id='test' load-type='spinner' replace-spinner='true'></div>
```
