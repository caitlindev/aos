ataSelect = angular.module 'g4plus.ata-select', [
  'services.ataCodes'
]


ataSelect.factory("ATAselectedCodeService", ->
  _subscribers = []
  selectedCodes = ''

  return {
    subscribe: (cb) ->
      _subscribers.push(cb)

    setCode: (code) ->
      selectedCodes = code
      angular.forEach _subscribers, (cb) ->
        cb(selectedCodes)
  }
)


# Directive used to display a list of ata codes
ataSelect.directive "g4ataDisplay", [
  () ->
    restrict: "A"
    scope: {
      ataCodes: "=model"
    }
    template: """
    <div ng-if="ataCodes" class="ata-code-display">
      <span ng-repeat="code in ataCodes" class="ata-code-entry">
        {{code.chapter}}{{code.section}}<span ng-if="!$last">,</span>
      </span>
    </div>
    """
    link: (scope, element, attrs) ->

]

# Implement validation for ata codes by watching model changes
ataSelect.directive "requiredMin", [
  () ->
    restrict: "A"
    require: "ngModel"
    link: (scope, element, attrs, ctrl) ->
      min = parseInt attrs.requiredMin, 10

      # Watch for errors only if needed
      if min > 0

        scope.$watch (() -> ctrl.$modelValue), (new_value, old_value) ->

          # Making the input $dirty
          if angular.isArray(new_value) and angular.isArray(old_value) and new_value.length != old_value.length
            ctrl.$setViewValue ctrl.$modelValue

          if new_value?.length >= min
            ctrl.$setValidity 'required', true
          else
            ctrl.$setValidity 'required', false
        , true
]

ataSelect.directive "g4ataSelect", [
  '$modal'
  'ATAService'
  'ATAselectedCodeService'
  ($modal, ATAService, ATAselectedCodeService) ->
    restrict: "A"
    scope: {
      model:"="
      display:"="
    }
    transclude: true
    template:  """
    <div id="selectedAtaCodes" ng-if="selectedCodes.length && newDisplay">
      <section ng-repeat="code in selectedCodes">
        <div class="padding margin-bottom"><a ng-click="removeSelectedCode(code)"><i class="pull-left fa fa-times-circle"></i></a>
          <h3 class="margin-left">{{code.chapter}}{{code.section}}</h3>
        </div>
      </section>
    </div>
    <button id="btn-ataCodes" type="button" ng-click="openATA()" class="btn btn-action btn-solid btn-default">&nbsp;&nbsp;&nbsp;&nbsp;Find&nbsp;&nbsp;&nbsp;&nbsp;</button>
    <input type="hidden" name="ataCodes" ng-model="selectedCodes" required-min="1" class="form-control hiddenATAfield"/>
    """
    link: (scope, element, attrs) ->
      if scope.display!=undefined
        scope.newDisplay = scope.display
      else
        scope.newDisplay = true

      scope.$watch 'model.length', () ->

        model = scope.model
        if model?.length > 0 && model?.length != undefined
          for code in model
            if code.chapter && code.section
              scope.selectedCodes = model
        else
          scope.selectedCodes = []

      ATAselectedCodeService.subscribe (code) ->
        inArray = false
        i=0
        while i < scope.selectedCodes.length
          if scope.selectedCodes[i].chapter == code.chapter && scope.selectedCodes[i].section == code.section
            inArray = true
            break
          i++

        if inArray != true
          scope.selectedCodes.push(code)
          scope.model = scope.selectedCodes


      scope.removeSelectedCode = (code) ->

        i = 0

        while i < scope.selectedCodes.length
          if scope.selectedCodes[i].chapter == code.chapter && scope.selectedCodes[i].section == code.section
            scope.selectedCodes.splice(i, 1)
          i++



      # ATA Modal
      scope.openATA = () ->
        modalInstance = $modal.open(
          controller: "ATAModalCtrl"
          template: """
            <div class="ata-modal">
              <div class="modal-content">
                <div class="modal-body">
                  <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close profile-close-button"> ×</button>
                  <h1>ATA Codes</h1>
                  <progressbar class="progress" value="100" type="info" ng-hide="ataCodes.length"></progressbar>

                <div class="select-boxes">
                  <div id="select_make" class="col-sm-4">
                    <select ng-model="make", ng-options="v.description for (k, v) in aircraftMakes track by v.code" ng-change="setMake(make)">
                      <option value="">Select Make...</option>
                    </select>
                  </div>

                  <div id="select_family" class="col-sm-4">
                    <select ng-model="family", ng-options="v.description for (k, v) in aircraftFamilies track by v.code" ng-change="setFamily(family)">
                      <option value="">Select Family...</option>
                    </select>
                  </div>

                  <div id="select_model" class="col-sm-4">
                    <select ng-model="model", ng-options="v.description for (k, v) in aircraftModels track by v.code" ng-change="setModel(model)">
                      <option value="">Select Model...</option>
                    </select>
                  </div>
                  <div class="clearfix"></div>
                </div>

                <div class="clearfix"></div>

                <div ng-if="parentCodes.length == 1">
                  <table class="table-lined table-condensed">
                    <thead>
                      <tr class="header_bar">
                        <th class="narrow">Chapter</th>
                        <th class="medium">Title</th>
                        <th class="narrow"></th>
                      </tr>
                    </thead>
                    <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: 'move-animation'}">
                      <tr>
                        <td class="narrow">{{code.code}}</td>
                        <td class="medium">{{code.title}}</td>
                        <td class="narrow text-right"><a ng-click="getChildCodes(code, true)">Select</a></td>
                      </tr>
                    </tbody>
                  </table>
                </div>

                <div ng-if="parentCodes.length > 1">
                  <div>
                    <div class="padding-bottom margin-bottom">
                      <button ng-click="loadParentCodes()" class="btn btn-action btn-solid btn-default pull-left"><i class="fa fa-angle-left"></i> Back</button>
                      <div class="title" class="pull-left margin-left">
                        <span ng-repeat="code in parentCodes" ng-if="$index > 0">
                          <strong>Chapter {{code.code}}</strong>: {{code.title}}
                          <span class="light" ng-if="$index == (parentCodes.length-2)">&nbsp;|&nbsp;</span>
                        </span>
                      </div>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                  <table class="margin-top table-lined">
                    <thead>
                      <tr class="header_bar">
                        <th class="narrow">Section</th>
                        <th class="medium">Title</th>
                      </tr>
                    </thead>
                    <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: 'move-animation'}">
                      <tr>
                        <td class="narrow">{{code.code}}</td>
                        <td class="medium text-left"><a ng-click="getChildCodes(code, false)">{{code.title}}</a></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div g4-pagination-message="" id="ata-pagination-message" current-page="pagination.page" page-size="pagination.pageSize" total-items="pagination.totalItems" class="col-md-6"></div>
                <div g4-pagination-navigation="" current-page="pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange" class="col-md-6 no-right-padding"></div>
                <div class="clearfix"></div>
              </div>
            </div>
          """
        )

      scope.cancel = () ->
        $modalInstance.close()



  ]






# ATAModalCtrl - Controller for the ATA Modal
ataSelect.controller "ATAModalCtrl", [
  '$scope'
  '$modalInstance'
  'ATAService'
  'ATAselectedCodeService'
  ($scope, $modalInstance, ATAService, ATAselectedCodeService) ->

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
      $scope.pagination.page = 1


    $scope.selectedCodes = []
    ATAselectedCodeService.subscribe (code) ->
      $scope.selectedCodes.push(code)


    _this = this

    _this.getATAchaptersWs = {
      ataChaptersWs: (service) ->
        # WS call. Ex: mockWs.rootCauseWs(rootCauseWs.success, rootCauseWs.error)
        service.getATAchapters(_this.getATAchaptersWs.success, _this.getATAchaptersWs.error)

      success: (data, status, headers, config) ->
        $scope.masterChapters = data.items
        $scope.parentATAcodes = data.items
        $scope.ataCodes = data.items

        $scope.parentCodes.push({children: data.items})
        $scope.updatePagination(data.items.length)

      error: (data, status) ->
        # error callback
    }

    _this.getATAchaptersWs.ataChaptersWs(ATAService)







    $scope.doubleDigits = (data) ->
      for singleCode in data
        if singleCode.code.length==1
          singleCode.code = "0" + singleCode.code

      return data





    $scope.aircraftMakes = []
    $scope.selectedMake = ''
    $scope.setMake = (make) ->
      $scope.selectedMake = make

      if make.code=='airbus'
        $scope.familyWs(ATAService, make.code)
        $scope.aircraftModels = []
      else
        $scope.aircraftFamilies = []
        $scope.modelWs(ATAService, "make", make.code)


    $scope.aircraftModels = []
    $scope.selectedModel = ''
    $scope.setModel = (model) ->
      $scope.selectedModel = model

      if $scope.aircraftFamilies.length > 0
        $scope.chapterByAircraftWs(ATAService, "FAMILY", model.id)
      else
        $scope.chapterByAircraftWs(ATAService, "MODEL", model.id)

    $scope.aircraftFamilies = []
    $scope.selectedFamily = ''
    $scope.setFamily = (family) ->
      $scope.selectedFamily = family
      $scope.modelWs(ATAService, "family", family.code)




    _this.getAircraftMake = {
      makeWs: (service, limit, currentPage) ->
        service.getMakes(limit, currentPage, (data, status, headers, config) ->

          for item in data.items
            $scope.aircraftMakes.push {
              id:item.id
              code:item.code
              description:item.description
            }

        , (data, status) ->
          console.log 'error'
        )
        return
    }

    _this.getAircraftMake.makeWs(ATAService, 100, 1)



    $scope.modelWs = (service, makeOrFamily, makeOrFamilyVal) ->
      service.getModels(makeOrFamily, makeOrFamilyVal, (data, status, headers, config) ->
        console.log 'model service'
        $scope.aircraftModels = data.items
      , (data, status) ->
        console.log 'error'
      )

    $scope.familyWs = (service, make) ->
      service.getFamilies(make, (data, status, headers, config) ->
        console.log 'family service'
        $scope.aircraftFamilies = data.items
      , (data, status) ->
        console.log 'error'
      )

    $scope.chapterByAircraftWs = (service, makeOrFamily, makeOrFamilyVal) ->
      service.getATAchaptersByAircraft(makeOrFamily.toUpperCase(), makeOrFamilyVal, (data, status, headers, config) ->
        console.log 'master chapter IDs per aircraft'
        $scope.chapterIds = data.items
        $scope.checkChaptersForAircraft($scope.masterChapters, data.items)

      , (data, status) ->
        console.log 'error'
      )

    $scope.checkChaptersForAircraft = (masterChapters, chapters) ->
      newChapters = []
      for mc in masterChapters
        for c in chapters
          if mc.id == c.masterChapterId
            newChapters.push(mc)

      $scope.parentCodes = []
      $scope.parentCodes.push({children: newChapters})
      $scope.ataCodes = newChapters
      $scope.updatePagination(newChapters.length)











    $scope.parentCodes = []
    $scope.currentParentCode = {}

    $scope.getChildCodes = (code, getSections) ->
      $scope.parentCodes.push(code)
      $scope.currentParentCode = code

      if getSections==true
        ATAService.getATAsections(code.id, (data, status, headers, config) ->
          $scope.changeATAcodesList(data.items)
          code.children = data.items
        , (data, status) ->
          console.log 'error'
        )
      else
        code.children = null
        $scope.changeATAcodesList(code.children)

    $scope.loadParentCodes = () ->
      if $scope.parentCodes.length > 0

        if $scope.parentCodes.length > 1
          $scope.parentCodes.pop()

        parent = $scope.parentCodes[$scope.parentCodes.length-1]
        $scope.currentParentCode = parent
        $scope.changeATAcodesList(parent.children)

      else
        $scope.changeATAcodesList(parent)




    $scope.changeATAcodesList = (data) ->
      $scope.parentATAcodes = data
      if data!=null
        $scope.ataCodes = data
        $scope.updatePagination(data.length)
      else
        $scope.finalSelection(data)


    $scope.finalSelection = (data) ->
      i=1
      cap = $scope.parentCodes.length - 1
      parents = ''
      while i < cap
        parents += $scope.parentCodes[i].code
        i++

      lastCode = $scope.parentCodes[$scope.parentCodes.length-1]
      if cap==1
        parents = lastCode.code
        lastCode.code = "00"

      $scope.addToSelectedCodes({
        chapter: parents
        aircraft: lastCode.aircraft
        section: lastCode.code
      })
      $scope.cancel()


    $scope.addToSelectedCodes = (code) ->
      ATAselectedCodeService.setCode(code)

]



ataSelect.filter "startFrom", ->
  (input, start) ->
    if input!=undefined
      start = +start #parse to int
      input.slice start
