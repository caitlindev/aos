# List Filter Module
# ==================
# Make sure you include this module if you want to use the directive
listFilter = angular.module 'g4plus.list-filter', [
  'g4plus.autofocus'
  'ngCookies'
]

listFilter.directive "g4ListFilter", [
  "$filter"
  "$cookieStore"

  ($filter, $cookieStore) ->
    restrict: "A"
    replace: false
    scope:
      options:  "=g4FilterOptions"
      filterBy: "=g4FilterBy"
      filter_value: "=g4FilterValue"
      filter_option: "=g4FilterOption"
    template:  """

      <section class="row padding-bottom-large input-group search-input">
        <input type="text"
        placeholder="Search query"
        class="pull-left"
        ng-model="filter_value"
        id="g4-list-filter-input"
        ng-keyup="filterByValue($event)"
        g4-autofocus
        />
        <btn class="btn btn-primary btn-rght-rounded btn-search pull-left">
          <i class="icon-search" ng-click="filterByValue($event)"> </i>
        </btn>
      </section>

      <div class="col-md-12 margin-top">
        <section class="border-top border-bottom padding-top-large filter_box">
          <div class="col-sm-8">
            <p>Filter by:<strong>&nbsp;Stations</strong></p>

            <div class="col-sm-4">
              <div class="row">
                <div ng-repeat="value in inputs.station | limitTo:5">
                  <div>
                    <label>
                      {{value}}
                      <input type="checkbox" ng-model="outputs['station'][value]" ng-checked="outputs['station'][value]"
 value="value" ng-click="checkboxFilterByValue()"/>
                      <span></span>
                    </label>
                    <div style="clear:both;"></div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="row">
                <div ng-repeat="value in inputs.station">
                  <div ng-show="$index >= 5 && $index < 10">
                    <label>
                      {{value}}
                      <input type="checkbox" ng-model="outputs['station'][value]" ng-checked="outputs['station'][value]"
 value="value" ng-click="checkboxFilterByValue()"/>
                      <span></span>
                    </label>
                    <div style="clear:both;"></div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="row">
                <div ng-repeat="value in inputs.station">
                  <div ng-show="$index >= 10 && $index < 15">
                    <label>
                      {{value}}
                      <input type="checkbox" ng-model="outputs['station'][value]" ng-checked="outputs['station'][value]"
 value="value" ng-click="checkboxFilterByValue()"/>
                      <span></span>
                    </label>
                    <div style="clear:both;"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-2 border-right border-left">
            <p><strong>Event Code</strong></p>
            <div class="col-sm-12">
              <div class="row">
                <div ng-repeat="value in inputs.eventCode | limitTo:5">
                  <div>
                    <label>
                      {{value}}
                      <input type="checkbox" ng-model="outputs['station'][value]" ng-checked="outputs['station'][value]"
 value="value" ng-click="checkboxFilterByValue()"/>
                      <span></span>
                    </label>
                    <div style="clear:both;"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-2">
            <p><strong>Date</strong></p>
            <form>
              <div class="row input-group col-sm-12 datetimepicker">
                <input type="text"
                show-button-bar="false"
                show-weeks="false"
                datepicker-popup="{{format}}"
                ng-model="dt"
                is-open="openDate"
                min-date="minDate"
                max-date="'2015-06-22'"
                datepicker-options="dateOptions"
                date-disabled="disabled(date, mode)"
                close-text="Close"
                placeholder="MM/DD/YYYY"
                class="form-control"
                />
                <span class="input-group-addon", ng-click="openDatepicker($event)"><i class="fa fa-calendar"></i></span>
              </div>
              <div class="clearfix padding-bottom-medium margin-top col-sm-12">
                <a ng-click="selectDatRange=true">Select a Date Range</a>
              </div>
              <div class="row input-group col-sm-12 datetimepicker" ng-show="selectDatRange">
                <input type="text"
                show-button-bar="false"
                show-weeks="false"
                datepicker-popup="{{format}}"
                ng-model="dt2"
                is-open="openDate2"
                min-date="minDate"
                max-date="'2015-06-22'"
                datepicker-options="dateOptions"
                date-disabled="disabled(date, mode)"
                close-text="Close"
                placeholder="MM/DD/YYYY"
                class="form-control"
                />
                <span class="input-group-addon", ng-click="openDatepicker2($event)"><i class="fa fa-calendar"></i></span>
              </div>
            </form>
          </div>
          <div class="clearfix"></div>
        </section>
      </div>


      <div class="clearfix">
        <section class="col-md-9">
          <!-- span.pull-right(g4-pagination-navigation, current-page="currentPage", total-pages="pageCount", page-change="total")-->
          <!-- span.pull-right.margin-right.pagination-message(g4-pagination-message,
               current-page="currentPage",
               page-size="pageCount",
               total-items="total")-->
          <div class="clearfix"></div>
        </section>
      </div>
    """
    link: (scope, element, attrs) ->

      scope.filter_timeframe = ''
      scope.changeTimeFilter = (val) ->
        if val.toLowerCase()=='all'
          scope.filter_timeframe = ''
        else
          scope.filter_timeframe = val

      scope.mytime = new Date()
      scope.hstep = 1
      scope.mstep = 15
      scope.options =
        hstep: [
          1
          2
          3
          4
          5
          6
          7
          8
          9
          10
          11
          12
        ]
        mstep: [
          1
          5
          10
          15
          25
          30
        ]

      scope.ismeridian = true
      scope.toggleMode = () ->
        scope.ismeridian = not scope.ismeridian

      scope.update = () ->
        d = new Date()
        d.setHours 14
        d.setMinutes 0
        scope.mytime = d

      scope.clear = () ->
        scope.mytime = null






      scope.optionToLabel = (searched_key) ->
        for option in scope.options
          if option.key == searched_key
            return option.label.toUpperCase()
        return ''

      scope.filterByOption = (new_option) ->
        scope.filterBy?(scope.filter_value, new_option)

      scope.filterByValue = (ev) ->
        console.log(ev)
        if ev.which == 13 || ev.which == 1
          scope.filterBy?(scope.filter_value, scope.filter_option)



      scope.outputs = {
        station:{}
        eventCode:{}
      }

      if $cookieStore.get('checkbox_values') != undefined
        scope.outputs = $cookieStore.get('checkbox_values')


      scope.inputs =
        station: [
          'NON'
          'EAST'
          'WEST'
          'HVY'
          'SFB'
          'PIE'
          'FLL'
          'PGD'
          'LAS'
          'LAX'
          'ENV'
          'AZA'
          'HNL'
          'BLI'
        ]
        eventCode: [
          "AOS"
          "SOS"
          "HPR"
        ]


      scope.checkboxFilterByValue = () ->
        scope.filterBy(scope.filter_value, scope.filter_option)

      scope.openDatepicker = (event) ->
        event.preventDefault()
        event.stopPropagation()
        scope.openDate = true

      scope.openDatepicker2 = (event) ->
        event.preventDefault()
        event.stopPropagation()
        scope.openDate2 = true



      scope.$watch "outputs", () ->
        $cookieStore.put('checkbox_values', scope.outputs)
      ,true

]

  #    scope.getCheckboxValues = (value, option) ->
  #      scope.$watch "chkbxs", ((n, o) ->
  #        trues = $filter("filter")(n,
  #          val: true
  #        )
  #        scope.flag = trues.length
  #        return
  #      ), true
  #
  #      checkboxes = $('.filter_box input[type="checkbox"]').is("checked")
  #      i = 0
  #
  #      while i < checkboxes.length
  #        checkbox = $(checkboxes).eq(i)
  #        checkboxVal = checkbox.val()
  #        console.log(checkboxVal)
  #        i++
  #
  #      scope.filterBy?(['bli', 'sos'], 'station')
  #
  #    scope.getCheckboxValues(null, null)


  # This will reset filter in case the length becomes 0
  #      else if scope.filter_value.length == 0
  #        scope.executeFilterBy('', scope.filter_option)



