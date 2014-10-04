Author: Taylor Kaplan
Contact: taylor.kaplan@allegiantair.com

# g4plus-retry-call Module

## **** IMPORTANT NOTE ABOUT KNOWN BUGS ****
Please remind me that there is a memory leak with managing failure and successful requests.
This is not a serious issue, but I will work on this issue in the next and upcoming week.
Do not deploy this code into production until I fix this issue, which should be soon. This code
should be good for testing and apps in development.
## *****************************************

## Importing the module

The module is registered to Angular as:

g4plus.retry-call

## Working with RetryCall interceptor
The interceptor adds options to the config object to better handle $http() requests.
The following options added to config are as follows:

// Type(integer)
automaticAttempts: Tells the interceptor the number of http request retries that are
                   allowed if the response fails, before it is considered a failed request.
// Type(function)
retrySuccess: A callback function that is automatically called when a request is successful.

// Type(function)
retryError: A callback function that can be called when a request ultimately fails. Currently
            this callback does not fire automatically because of business requirements to work
            with retry-call directive. This gives the developer the option to retry failed
            requests.

### Example Uses:

```
var config = {
    method: 'GET',
    url: '/some-url',
    automaticAttempts: 5,
    retrySuccess: function() {
        console.log('success');
    },
    retryError: function() {
        console.log('failed');
    }
};

$http(config);
```

On a side note, do not use .success() or .error() callback:

```

/////////////////////////////////////////
// WRONG
// Callbacks will not be handled properly
/////////////////////////////////////////
var config = {
    method: 'GET',
    url: '/some-url'
};

$http(config).success(successCallback).error(errorCallback);

--------------------------------------------------------------

/////////////////////////////////////
// RIGHT
// Callbacks will be handled properly
/////////////////////////////////////
var config = {
    method: 'GET',
    url: '/some-url',
    retrySuccess: successCallback,
    retryError: errorCallback
};

$http(config);

Example for calling error callbacks:

var config = {
    method: 'GET',
    url: '/some-url',
    retrySuccess: successCallback,
    retryError: errorCallback
};

// $http doesn't have a callback for .done() or .final()
// so we have to make our own.
var sync = function(config) {
    $http(config)
    this.done = function(errorCallback) {
        errorCallback();
    }
};

syncErrorCallback = new sync(config);
syncErrorCallback.done(config.retryError);
```

## Using retry-call directive
The retry-call directive is simply an area in your html document that displays
the status of your ajax calls. This is the same as flash-storage, except it
utilizes the RetryCall interceptor. To display status messages simply call
the directive anywhere in your html. Example:

```
<div retry-call></div>
        or
<retry-call></div>
```

### Available options for retry-call

#### successMessage and errorMessage
You can now display a custom success and error message per http request. All you need to do is set it in the
config object of your http request. Example:

```
$http({
    url: '/test-url',
    method: 'GET',
    successMessage: 'Saved person's record was successful!',
    errorMessage: 'Saved person's record was a complete and utter failure :P'
});
```

#### critical
You can now display a module alert box that will disable the user if a given server call is critical. This option
is applied to the $http() config option itself. The option takes a boolean value, on True: Alert box is shown
 and disables the user from performing any further action until the service call is resolved. False: Alert box is
 not shown any error will displayed normally. An example is shown bellow:

```
$http({
    url: '/test-url',
    method: 'GET',
    critical: true
});
```

#### retry-id
retry-call can now be configured to show only certain errors or success messages depending on the requests.
By default, retry-call will display all error and success messages, however if you only want certain messages
to be displayed for a particular retry-call component, you can specify the retry-id and link an http request
to that id. Example:

```
// html
<!-- Will show both http request messages -->
<div retry-call></div>

<!-- Will only show messages tagged with retryId='show_me' in $http config object -->
<div retry-call retry-id='show_me'></div>

// This message will be displayed in both retry-call implementations
$http({
    url: '/some-url',
    method: 'GET',
    retryId: 'show_me'
});

// The corresponding message for this request will only be shown for untagged retry-call
// implementations. This will only show in the first directive.
$http({
    url: '/another-url',
    method: 'GET',
});
```

#### filter-status
filter-status is an option that allows you to filter types of failed requests to show. If a requests fails ( status code > 399 )
you can choose which status codes to display by specifying an array of status codes as such.

```
// html
<!-- This will show all failed requests -->
<div retry-call></div>

<!-- This will only show failed requests for codes, 400, 404, and 500 -->
<div retry-call filter-status='[400,404,500]'></div>

<!-- This will show only failed requests for code 400. This must be an array! -->
<div retry-call filter-status='[400]'></div>
``` 

#### show-url
show-url takes a boolean. True: show url of http request. False: hide url of http request. Default is false

```
<div retry-call show-url='false'></div>
```

#### clear-errors-on-view-change
clear-errors-on-view-change takes a boolean value. This will clear all error messages for corresponding view change.

#### clear-success-on-view-change
clear-success-on-view-change takes a boolean value. This will clear all success messages for corresponding view change.

#### show-successful-requests
show-successful-requests takes a boolean value. True: http success messages will be shown in retry-call. False:
 http success messages will not be shown. Default is true.

#### show-failed-requests
show-failed-requests takes a boolean value. True: http failed messages will be shown in retry-call. False: http failed
messages will be hidden. Default is is true.

#### tagline-for-error
tagline-for-error takes a string input. Example:

```
<div retry-call tagline-for-error="Error!"></div>
```

#### tagline-for-success
tagline-for-success takes a string input. Example:

```
<div retry-call tagline-for-success="Successful!"></div>
```

#### default-error-message
default-error-message takes a string and sets the default message if no error message was set on http config object.

```
<div retry-call default-error-message="Your action was not successful :( "></div>
```

#### default-success-message
default-success-message takes a string and sets the default message if no success message was set on http config object.

```
<div retry-call default-success-message="Your action was successful :) "></div>
```

## Available factories

### RetryCall
RetryCall is a factory that is automatically added as an http interceptor when
registering g4plus.retry-call module. It provides a rich set of accessor methods
that allows one to interact with intercepted requests and response objects. It is
advised to not access these factory methods unless building a service or directive
that needs it. If accessing this factory's methods, it is possible create angular
stopping errors when working with $http, if the internal objects are not handled
correctly.

The interceptor keeps an internal hash of the follow objects:

#### Requests:
All original incoming requests are thrown into the request hash until, the
corresponding response is successful or they use up their automatic attempts.
Automatic attempts, tells the interceptor how many retries a request can get
until it should be counted as a failed response. The accessor methods for
request are:

```
// Appends a failed request object to the request hash
appendRequest(request)

// Returns request object
getRequest(requestId)

// Returns requests hash
getRequests()

// Deletes request in request hash
deleteFailedRequest(requestId)

// Returns true if request obj exists. False if not.
hasFailedRequest(requestId)
```

#### Failed Request:
A failed request is any request that has used up it's automatic attempts
and has yet to merit a successful response. When a request fails, it is
taken out of the request hash and the corresponding failed response object
is placed into a failed request hash. The accessor methods for failed
request are:

```
// Appends a failed response object to the failed request hash <br/>
appendFailedRequest(responseObject)

// Returns failed response object
getFailedRequest(requestId)

// Returns failed requests hash
getFailedRequests()

// Deletes failed response object in failed request hash
deleteFailedRequest(requestId)

// Returns true if failed response obj exists. False if not.
hasFailedRequest(requestId)
```

#### Successful Request:
A successful request is any request that returns with a response object
of status < 300. All successful requests will have their responses appended
to the successful request hash, unless the request used 'GET'. The accessor
methods for successful requests are:

```
// Appends a successful response object to the successful request hash
appendSuccessfulRequest(responseObject)

// Returns successful response object
getSuccessfulRequest(requestId)

// Returns successful requests hash
getSuccessfulRequests()

// Deletes successful response object in successful request hash
deleteSuccessfulRequest(requestId)

// Returns true if successful response obj exists. False if not.
hasSuccessfulRequest(requestId)
```