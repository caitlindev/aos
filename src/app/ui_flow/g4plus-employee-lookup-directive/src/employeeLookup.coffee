employeeLookup = angular.module 'g4plus.employee-lookup', [
  'services.employeeDirectory'
]


employeeLookup.factory("EmployeeLookupService", ->
  _subscribers = []
  selectedEmployees = []

  return {
    subscribe: (cb) ->
      _subscribers.push(cb)

    setCode: (code) ->
      selectedEmployees = code
      angular.forEach _subscribers, (cb) ->
        cb(selectedEmployees)
  }
)




employeeLookup.directive "g4employeeLookup", [
  '$modal'
  'EmployeeDirectoryService'
  'EmployeeLookupService'
  ($modal, EmployeeDirectoryService, EmployeeLookupService) ->
    restrict: "A"
    scope: {
      model:"="
      linkText:"@"
    }
    transclude: true
    template:  """
    <a ng-click="openEmployeesLookup()">{{linkText}}</a>
    """
    link: (scope, element, attrs) ->
      scope.$watch 'model', () ->
        model = scope.model
        if model?.length > 0 && model?.length != undefined && model[0].employee.id!=null
          for code in model
            scope.selectedEmployees = model
        else
          console.log 'no'
          scope.selectedEmployees = []

      EmployeeLookupService.subscribe (code) ->
        inArray = false
        i=0

        if scope.selectedEmployees
          while i < scope.selectedEmployees.length
            if scope.selectedEmployees[i].employee.id == code.employee.id
              inArray = true
              break
            i++

        if inArray != true
          scope.selectedEmployees.push(code)
          scope.model = scope.selectedEmployees




      # Employee Lookup Modal
      scope.openEmployeesLookup = () ->
        modalInstance = $modal.open(
          controller: "EmployeeLookupModalCtrl"
          template: """
            <div class="employee-lookup-modal">
              <div class="modal-content">
                <div class="modal-body">
                  <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close profile-close-button">
                    ×
                  </button>
                  <h1>Employees</h1>
                <div ng-if="parentCodes.length == 1">
                  <table class="table-lined table-condensed">
                    <thead>
                      <tr class="header_bar">
                        <th class="narrow">ID</th>
                        <th class="medium">Name</th>
                      </tr>
                    </thead>
                    <tbody
 ng-repeat="employee in employees | orderBy:lastName | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize"
 ng-animate="{move: 'move-animation'}">
                      <tr>
                        <td class="medium">{{employee.id}}</td>
                        <td class="medium"><a ng-click="getChildCodes(employee)">{{employee.lastName}}, {{employee.firstName}}</a></td>
                      </tr>
                    </tbody>
                  </table>
                </div>

                <div g4-pagination-message="" current-page="pagination.page" page-size="pagination.totalPage"
 total-items="parentEmployees.length" class="col-md-4"></div>
                <div g4-pagination-navigation="" current-page="pagination.page" total-pages="pagination.totalPage"
 page-change="pagination.pageChange" class="col-md-8 no-right-padding"></div>
                <div class="clearfix"></div>
              </div>
            </div>
          """
        )

      scope.cancel = () ->
        $modalInstance.close()



  ]






# EmployeeLookupModalCtrl - Controller for the Employee Lookup Modal
employeeLookup.controller "EmployeeLookupModalCtrl", [
  '$scope'
  '$modalInstance'
  'EmployeeDirectoryService'
  'EmployeeLookupService'
  ($scope, $modalInstance, EmployeeDirectoryService, EmployeeLookupService) ->

    $scope.cancel = () ->
      $modalInstance.close()


    # pagination:
    $scope.pagination =
      totalItems: 0
      totalPages: 0
      pageSize: 10
      page: 1

      pageSizeChange: (pageSize) ->
        $scope.pagination.page = 1
        $scope.pagination.pageSize = pageSize

      pageChange: (page) ->
        $scope.pagination.page = page

    $scope.updatePagination = (total) ->
      $scope.pagination.totalItems = total
      $scope.pagination.totalPages = Math.ceil total / $scope.pagination.pageSize


    $scope.selectedEmployees = []
    EmployeeLookupService.subscribe (code) ->
      $scope.selectedEmployees.push(code)


    _this = this

    _this.getEmployeeDirectoryWS = {
      employeeWS: (service) ->
        # WS call. Ex: mockWs.rootCauseWs(rootCauseWs.success, rootCauseWs.error)
        service.getEmployees(_this.getEmployeeDirectoryWS.success, _this.getEmployeeDirectoryWS.error)

      success: (data, status, headers, config) ->
        # success callback
        $scope.employees = data
        $scope.parentCodes.push({children: data})
        $scope.updatePagination(data.length)

      error: (data, status, headers, config) ->
        # error callback
    }




    # Get employee data
    _this.getEmployeeDirectoryWS.employeeWS(EmployeeDirectoryService)





    $scope.parentCodes = []
    $scope.currentParentCode = {}

    $scope.getChildCodes = (code) ->
      $scope.parentCodes.push(code)
      $scope.currentParentCode = code
#      no children so passing param only to get 0 length
#      $scope.changeATAcodesList(code.children)
      $scope.changeEmployeeLookupList(code)

    $scope.loadParentCodes = () ->
      if $scope.parentCodes.length > 0

        if $scope.parentCodes.length > 1
          $scope.parentCodes.pop()

        parent = $scope.parentCodes[$scope.parentCodes.length-1]
        $scope.currentParentCode = parent
        $scope.changeEmployeeLookupList(parent.children)

      else
        $scope.changeEmployeeLookupList(parent)





    $scope.addToSelectedEmployees = (code) ->
      EmployeeLookupService.setCode(code)

    $scope.changeEmployeeLookupList = (data) ->
      $scope.addToSelectedEmployees({
        "employee": {
          "firstName":data.firstName,
          "lastName":data.lastName,
          "id":data.id,
          "contact":data.email,
          "base":data.base,
          "DOB":data.dob,
          "gender":data.gender
        },
        "travelInfo": {}
      })

      $scope.cancel()


]



employeeLookup.filter "startFrom", ->
  (input, start) ->
    if input!=undefined
      start = +start #parse to int
      input.slice start
