# G4Plus Comments Directive

The functionality of the comments directive is detailed in the files found in the `requirements` folder where you can find BRD, Wireframe and UI comps.

# Installation

### 1. bower.json
Enable in bower.json the directive:

      "g4plus-comments": "ssh://git@git.allegiantair.com:7999/bc/g4plus-comments-directive.git",

You may need the additional tweaking for upload directive:

          "blueimp-file-upload": "~9.5.7",
      },
      "overrides": {
        "blueimp-file-upload": {
          "main": [
          "css/jquery.fileupload.css",
          "css/jquery.fileupload-ui.css",
          "js/vendor/jquery.ui.widget.js",
          "js/jquery.fileupload.js",
          "js/jquery.fileupload-angular.js",
          "js/jquery.fileupload-process.js",
          "js/jquery.fileupload-validate.js",
          "js/jquery.iframe-transport.js",
          "js/cors/jquery.postmessage-transport.js",
          "js/cors/jquery.xdr-transport.js"
        ],
        "dependencies": {
          "jquery": "*"
        }
        }
      }

### 2. Initialize

Initialize project to download and setup the required dependencies:

    scripts/init.sh


### 3. Api mocks

The services used by the directive can be found in `bower_components/g4plus-comments-directive/mocks`. These need to be copied over to your `/mocks` directory.

# Configuration
After the initialization you need to configure the component in your controller and template.

### Module

Enable module `g4plus-comments` in `app.coffee` or where you want it to be used.

### Controller

        # namespace, context paths
        namespace = 'avluser'
        hasContext = true
        context = 'AU2'
        namespacePath = "namespaces/" + namespace + '/'
        contextPath = ''
        if hasContext
          contextPath = "contexts/" + context + '/'

        # logged user
        $scope.user =
          loginId: "michael.freeman"
          empId: "00015"
          fullName: "Michael Freeman"

        # common part for the endpoint
        url = "/api/mx-comments/v1/api/"
        mainEntity = "comments"

        # directive config
        $scope.commentConfig =
          mainEndpoint: url                                        # common part for the endpoint
          mainEntity: mainEntity
          user:
            loginId: $scope.user.loginId
            empId: $scope.user.empId
            fullName: $scope.user.fullName
          namespace: namespace                                     # current app namespace
          context: context                                         # context in current app, element is not mandatory
          path: url + namespacePath + contextPath + 'comments'     # defines the server endpoint for GET comments
          show:
            close: true                                            # if true shows title and close button
            attachments: true                                      # if true you can add attachments to the comment or reply
            visible: false                                         # if true comments are displayed
            isVisible: () ->
              @visible
            toggle: () ->
              @visible  = !@visible
              @visible


### Template
The following variables are available to configure the comments directive:
* config - this is the object setup in the controller that has all the information needed for template configuration
* template-dir - the version of the template to load, from the directive templates directory

1. Default template: folder v1

        div(
          g4-comments
          config="commentConfig"
        )

2. If you want the templates to be loaded from another folder (the folder must be in the directive)

        div(
          g4-comments
          config="commentConfig"
          template-dir="v2"
        ) Comments


