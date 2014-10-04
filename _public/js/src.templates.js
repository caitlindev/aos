(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/home/home.jade',
    '\n' +
    '<header class="page-header">\n' +
    '  <h1>{{pageTitle}}</h1>\n' +
    '</header>\n' +
    '<section ng-controller="HomeCtrl">\n' +
    '  <p>This app will serve as your starting point for new applicaton development. If you already know what your doing, do the following to start your new project:</p>\n' +
    '  <ul>\n' +
    '    <li>Clone this project from its repo. blue red apple</li>\n' +
    '    <li>Delete the src/app/home, src/app/examples, and src/app/ui_flow modules by deleting their respective directories</li>\n' +
    '    <li>Update src/index.jade and src/app/app.coffee to remove references to the deleted modules</li>\n' +
    '    <li>Start coding!</li>\n' +
    '  </ul>\n' +
    '  <p>If you do not know what you are doing (yet), examing this app to see how to do things.</p>\n' +
    '  <h2>Project Breakdown</h2>\n' +
    '  <ul>\n' +
    '    <li>Home: This description page.</li>\n' +
    '    <li>Examples: Various examples</li>\n' +
    '    <li>UI Flow: An end-to-end example of UI flow in a typical app. Styling and layout here is the standard and all projects should be modeled after this.\n' +
    '      <p>As of 01-15, most of the functionality and flow has been correctly implemented here. Updates will be made as issues pop up.</p>\n' +
    '    </li>\n' +
    '  </ul>\n' +
    '</section>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/add/add.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"><a ng-click="goToPath($event, \'/dashboard\')" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>Dashboard</span></a></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Add AOS</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right">\n' +
    '      <div id="search_box" class="pull-right margin-right">\n' +
    '        <div class="margin-left input-group"><a ng-click="ng-click" class="input-group-addon"><i class="fa fa-search"></i></a>\n' +
    '          <input type="text" placeholder="Search Event History" ng-model="filter_value" id="g4-list-filter-input" ng-keyup="goToPath($event, \'/list\', filter_value)" class="form-control ng-pristine"/>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="add_info" class="margin-top-large">\n' +
    '    <form name="aosForm" ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <fieldset>\n' +
    '        <!--div.row-->\n' +
    '        <!--  section.col-sm-3.text-right-->\n' +
    '        <!--    p Event Type:-->\n' +
    '        <!---->\n' +
    '        <!--  section.col-sm-6-->\n' +
    '        <!--    div.col-sm-4-->\n' +
    '        <!--      label.left AOS-->\n' +
    '        <!--        input(type=\'radio\', name=\'eventType\', value=\'aos\', ng-model="newEvent.type")-->\n' +
    '        <!--        span-->\n' +
    '        <!---->\n' +
    '        <!--    div.col-sm-4-->\n' +
    '        <!--      label.left MC Order-->\n' +
    '        <!--        input(type=\'radio\', name=\'eventType\', value=\'mco\', ng-model="newEvent.type")-->\n' +
    '        <!--        span-->\n' +
    '        <!---->\n' +
    '        <!--    div.col-sm-4-->\n' +
    '        <!--      label.left Scheduled-->\n' +
    '        <!--        input(type=\'radio\', name=\'eventType\', value=\'sos\', ng-model="newEvent.type")-->\n' +
    '        <!--        span-->\n' +
    '        <!---->\n' +
    '        <!---->\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom">\n' +
    '            <p>Time Stamp:</p>\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-12"><span>\n' +
    '                {{currentTime}}\n' +
    '                UTC</span></div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Tail Number:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_tailNbr" name="tailNumber" ng-required="true" ui-select2="ui-select2" ng-model="newEvent.tailNbr" data-placeholder="Select a Tail #..." style="min-width:100%;">\n' +
    '                <option value="">\n' +
    '                  <option ng-repeat="tailNbr in tailNbrList" value="{{tailNbr.tailNbr}}">{{tailNbr.tailNbr.toUpperCase()}}</option>\n' +
    '                </option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.tailNumber.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.tailNumber.$error.required" class="small no-bottom-margin text-danger tailNumber-required">Tail Number is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Station\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_station" name="station" ng-required="true" ui-select2="ui-select2" ng-model="newEvent.station" data-placeholder="Select a Station..." style="min-width:100%;">\n' +
    '                <option value="">\n' +
    '                  <option ng-repeat="station in stationsList" value="{{station.name}}">{{station.name.toUpperCase()}}</option>\n' +
    '                </option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.station.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.station.$error.required" class="small no-bottom-margin text-danger station-required">Station is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Location:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <input name="location" ng-required="true" type="text" ng-model="newEvent.location" id="stations" maxlength="8" class="form-control"/>\n' +
    '              <div ng-show="aosForm.location.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.location.$error.required" class="small no-bottom-margin text-danger location-required">Location is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Description\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-9">\n' +
    '              <textarea name="description" ng-required="true" ng-model="newEvent.description" maxlength="100" class="form-control"></textarea>\n' +
    '              <div ng-show="aosForm.description.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.description.$error.required" class="small no-bottom-margin text-danger description-required">Description is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <section class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Event Code:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_eventCode" ng-options="v.description for (k, v) in eventCodeList track by v.code" name="eventCode" ng-required="true" ng-model="newEvent.eventCode" data-placeholder="Select an Event Code..." style="min-width:100%;" ng-change="changeRootCauseList(newEvent.eventCode)">\n' +
    '                <option value="">Select Event Code...</option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.eventCode.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.eventCode.$error.required" class="small no-bottom-margin text-danger eventCode-required">Event Code is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <!--div.row(ng-repeat="eventCode in eventCodeList")-->\n' +
    '        <!--  section.col-sm-3.text-right-->\n' +
    '        <!--    section(ng-if="$index==0")-->\n' +
    '        <!--      span.required.text-danger *-->\n' +
    '        <!--      = \' Event Code:\'-->\n' +
    '        <!---->\n' +
    '        <!--  section.col-sm-9-->\n' +
    '        <!--    label.left {{eventCode.code}} - {{eventCode.description}}-->\n' +
    '        <!--      input(name=\'eventCode\', ng-required="true", type=\'radio\', value=\'{{eventCode.code}}\', ng-model="newEvent.eventCode", ng-change="changeRootCauseList(eventCode)")-->\n' +
    '        <!--      span-->\n' +
    '        <!--      div(ng-show="aosForm.eventCode.$dirty && !noModify")-->\n' +
    '        <!--        p.small.no-bottom-margin.text-danger.eventCode-required(ng-show="aosForm.eventCode.$error.required") Event Code is required.-->\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Root Cause:\n' +
    '            <!--select(ng-disabled="rootCauseCodeList.length==1", ng-model="newEvent.rootCause", ng-options="rootCauseCode.code as rootCauseCode.description for rootCauseCode in rootCauseCodeList")-->\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_rootCause" ng-options="v.description for (k, v) in rootCauseCodeList track by v.code" name="rootCause" ng-required="true" ng-disabled="rootCauseCodeList.length==1" ng-model="newEvent.rootCause" data-placeholder="Select a Root Cause Code..." style="min-width:100%;">\n' +
    '                <option value="">Select Root Cause Code...</option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.rootCause.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.rootCause.$error.required" class="small no-bottom-margin text-danger rootCause-required">Root Cause is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <fieldset>\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right">\n' +
    '            <p>ATA Code:</p>\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2">\n' +
    '              <div g4ata-select="g4ata-select" model="selectedCodes" display="true"></div>\n' +
    '            </div>\n' +
    '            <!--div.clearfix-->\n' +
    '            <!--div.margin-left.margin-top(ng-if=\'selectedCodes.length\')-->\n' +
    '            <!--  section(ng-repeat=\'code in selectedCodes\')-->\n' +
    '            <!--    .padding.margin-bottom-->\n' +
    '            <!--      a(ng-click=\'removeSelectedCode(code)\')-->\n' +
    '            <!--        i.pull-left.fa.fa-times-circle-->\n' +
    '            <!--      h3.margin-left {{code.chapter}}{{code.section}}-->\n' +
    '            <!--div#selectedAtaCodes(ng-repeat="code in selectedCodes")-->\n' +
    '            <!--  section.margin-top-->\n' +
    '            <!--    div.padding.margin-top-->\n' +
    '            <!--      a(ng-click="removeSelectedCode()")-->\n' +
    '            <!--        i.pull-left.fa.fa-times-circle-->\n' +
    '            <!--      h3.margin-left {{code.title}}-->\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Status Code:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9 input-group">\n' +
    '            <label class="left">ADV (Advise... Pending ETR)\n' +
    '              <input ng-required="true" type="radio" name="statusCode" value="adv" ng-model="newEvent.status"/><span></span>\n' +
    '              <div ng-show="aosForm.statusCode.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.statusCode.$error.required" class="small no-bottom-margin text-danger statusCode-required">Status Code is required.</p>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"></section>\n' +
    '          <section class="col-sm-9 input-group">\n' +
    '            <label class="left">ETR (Estimated Time to Repair)\n' +
    '              <input type="radio" name="statusCode" value="etr" ng-model="newEvent.status"/><span></span>\n' +
    '            </label>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <!--div.row-->\n' +
    '        <!--  section.col-sm-3.text-right-->\n' +
    '        <!---->\n' +
    '        <!--  section.col-sm-9.input-group-->\n' +
    '        <!--    label.left RDY (Ready to Service)-->\n' +
    '        <!--      input(type=\'radio\', name=\'statusCode\', value=\'rdy\', ng-model="newEvent.status")-->\n' +
    '        <!--      span-->\n' +
    '      </fieldset>\n' +
    '      <section ng-show="newEvent.status" class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset ng-show="newEvent.status.toUpperCase()==\'ADV\'">\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> UTC Advisory Date:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-5 datetimepicker">\n' +
    '              <div class="input-group margin-bottom">\n' +
    '                <input name="utcAdvisoryDate" ng-required="true" type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event)" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '              <div ng-show="aosForm.utcAdvisoryDate.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcAdvisoryDate.$error.required" class="small no-bottom-margin text-danger utcAdvisoryDate-required">UTC Advisory Date is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> UTC Advisory Time:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2 datetimepicker timepicker">\n' +
    '              <timepicker name="utcAdvisoryTime" ng-required="true" ng-model="mytime" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '              <div ng-show="aosForm.utcAdvisoryTime.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcAdvisoryTime.$error.required" class="small no-bottom-margin text-danger utcAdvisoryTime-required">UTC Advisory Time is required.</p>\n' +
    '              </div>\n' +
    '              <!--input.form-control(type="text", placeholder="HH:mm")-->\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <fieldset ng-show="newEvent.status.toUpperCase()==\'ETR\'">\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> UTC ETR Date:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-5 datetimepicker">\n' +
    '              <div class="input-group margin-bottom">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event)" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> UTC ETR Time:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2 datetimepicker timepicker">\n' +
    '              <timepicker name="utcEtrTime" ng-required="true" ng-model="mytime" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '              <div ng-show="aosForm.utcEtrTime.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcEtrTime.$error.required" class="small no-bottom-margin text-danger utcEtrTime-required">UTC ETR Time is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <section class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset class="padding-top-large padding-bottom-large text-center">\n' +
    '        <button ng-click="goToPath($event, \'/dashboard\')" class="btn btn-larger btn-translucent margin-right-large">Cancel</button>\n' +
    '        <button type="submit" id="submit" class="btn btn-larger btn-solid">Create</button>\n' +
    '      </fieldset>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/dashboard/dashboard.jade',
    '\n' +
    '<div class="row">\n' +
    '  <div class="action_btns stations-dropdown pull-right"><span>Station:</span><span class="dropdown margin-left">\n' +
    '      <button type="button" data-toggle="dropdown" ng-if="filter_station==\'\'" class="btn btn-default dropdown-toggle">ALL &nbsp;<i class="fa fa-angle-down"></i></button>\n' +
    '      <button type="button" data-toggle="dropdown" ng-if="filter_station!=\'\'" class="btn btn-default dropdown-toggle">{{filter_station}} &nbsp;<i class="fa fa-angle-down"></i></button>\n' +
    '      <ul class="dropdown-menu">\n' +
    '        <li><a ng-click="changeStationFilter(\'all\')">ALL</a></li>\n' +
    '        <li><a ng-click="changeStationFilter(\'non\')">NON</a></li>\n' +
    '        <li><a ng-click="changeStationFilter(\'east\')">EAST</a></li>\n' +
    '        <li><a ng-click="changeStationFilter(\'west\')">WEST</a></li>\n' +
    '        <li><a ng-click="changeStationFilter(\'hvy\')">HVY</a></li>\n' +
    '        <li><a ng-click="changeStationFilter(\'base\')">BASE</a></li>\n' +
    '        <li ng-repeat="station in stationList"><a ng-click="changeStationFilter(station)">{{station.toUpperCase()}}</a></li>\n' +
    '      </ul></span></div>\n' +
    '  <tabset>\n' +
    '    <tab active="tab[0].active" class="tab-bar-chart">\n' +
    '      <tab-heading>Dashboard<a ng-init="isCollapsed = false" ng-click="isCollapsed = !isCollapsed" class="pull-left margin-right"><i class="fa fa-angle-right {{collapsedIcon(isCollapsed)}}"></i></a></tab-heading>\n' +
    '      <section id="dashboard" class="widget col-md-12">\n' +
    '        <section class="widget-body">\n' +
    '          <div collapse="isCollapsed" class="{{isCollapsed}}">\n' +
    '            <div id="dashboard_chart" class="margin-top">\n' +
    '              <dashboard-chart chart-data="filter_station">\n' +
    '                <div ng-hide="(eventList | filter:{&quot;eventCode&quot;:&quot;aos&quot;} | filterStations:filter_stationList).length">\n' +
    '                  <h1 id="empty-chart" class="text-center">No AOS Events for this station.</h1>\n' +
    '                </div>\n' +
    '              </dashboard-chart>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </section>\n' +
    '      </section>\n' +
    '    </tab>\n' +
    '    <li class="divider">|</li>\n' +
    '    <tab active="tab[1].active" ng-click="refreshMap=!refreshMap" class="tab-level-up">\n' +
    '      <tab-heading>Routing</tab-heading>\n' +
    '      <div g4-mapbox="g4-mapbox" ng-init="refreshMap=false" map-filters="mapFilters" refresh-map="refreshMap" station-routes="stationRoutes" flight-data="flightList" tail-numbers="tailNumbers" map-host="\'http://localhost:3333\'" class="g4-mapbox-wrap"></div>\n' +
    '    </tab>\n' +
    '  </tabset>\n' +
    '</div>\n' +
    '<div class="row">\n' +
    '  <section id="aos_activity" class="widget col-md-12 with-header">\n' +
    '    <section class="widget-body">\n' +
    '      <div class="action_btns">\n' +
    '        <!--span Station:-->\n' +
    '        <!--span.dropdown.margin-left-->\n' +
    '        <!--  button.btn.btn-default.dropdown-toggle(type="button", data-toggle="dropdown", ng-if="filter_station==\'\'") ALL &nbsp;-->\n' +
    '        <!--    i.fa.fa-angle-down-->\n' +
    '        <!--  button.btn.btn-default.dropdown-toggle(type="button", data-toggle="dropdown", ng-if="filter_station!=\'\'") {{filter_station}} &nbsp;-->\n' +
    '        <!--    i.fa.fa-angle-down-->\n' +
    '        <!---->\n' +
    '        <!--  ul.dropdown-menu-->\n' +
    '        <!--    li(ng-repeat="station in stationList")-->\n' +
    '        <!--      a(ng-click="changeStationFilter(station.name)") {{station.name.toUpperCase()}}-->\n' +
    '        <div class="pull-right"></div>\n' +
    '        <div class="btn-group pull-right">\n' +
    '          <button ng-click="goToPath($event, \'/add\')" class="btn btn-action btn-solid btn-default">+ New Event</button>\n' +
    '        </div>\n' +
    '        <div id="search_box" class="pull-right margin-right">\n' +
    '          <div class="margin-left input-group"><a ng-click="ng-click" class="input-group-addon"><i class="fa fa-search"></i></a>\n' +
    '            <input type="text" placeholder="Search Event History" ng-model="filter_value" id="g4-list-filter-input" ng-keyup="goToPath($event, \'/list\', filter_value)" class="form-control ng-pristine"/>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <ul ng-show="(eventList | filterStations:filter_stationList).length" class="table-lined margin-top rounded">\n' +
    '        <li>\n' +
    '          <div class="eventTitle">\n' +
    '            <div class="tr">\n' +
    '              <div class="col-sm-1"></div>\n' +
    '              <div class="col-sm-11">\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Tail</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Station</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Status</strong></div>\n' +
    '                <div class="col-sm-2"><strong class="dashboard-tlb-title">Description</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">ATA</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title text-center">Event Code</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title text-center">Root Cause</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Adv Time</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">ETR</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Flight Info</strong></div>\n' +
    '                <div class="col-sm-1"><strong class="dashboard-tlb-title">Elapsed Time</strong></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </li>\n' +
    '      </ul>\n' +
    '      <div ng-show="(eventList | filterStations:filter_stationList).length" class="eventSection aos"><a ng-click="isAOSCollapsed=!isAOSCollapsed"><span class="pull-right">{{collapsedSectionIcon(isAOSCollapsed).text}} AOS events &nbsp;<i class="fa {{collapsedSectionIcon(isAOSCollapsed).class}}"></i></span>\n' +
    '          <div class="clearfix"></div></a></div>\n' +
    '      <ul collapse="isAOSCollapsed" class="margin-none {{isAOSCollapsed}}">\n' +
    '        <li ng-repeat="event in eventList | orderBy:&quot;createdUnixTimestamp&quot; | filter:{&quot;eventCode&quot;:&quot;aos&quot;, &quot;state&quot;:&quot;open&quot;} | filterStations:filter_stationList" class="events">\n' +
    '          <div class="eventList">\n' +
    '            <div ng-class="event.eventCode.toLowerCase()" class="tr">\n' +
    '              <div class="col-sm-1 padding-none">\n' +
    '                <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicators indicator-container"></div>\n' +
    '              </div>\n' +
    '              <div class="col-sm-11"><a ng-click="goToPath($event, \'/view/\' + event.id)">\n' +
    '                  <p class="col-sm-1">{{ event.tailNbr }}</p></a>\n' +
    '                <p class="col-sm-1">{{ event.station.toUpperCase() }} <br/><span class="gate">{{ event.location }}</span></p>\n' +
    '                <p class="col-sm-1">{{ event.status.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-2">{{ event.description }}</p>\n' +
    '                <p class="col-sm-1"><span ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</span></p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.eventCode.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.rootCause.toUpperCase() }}</p>\n' +
    '                <p ng-if="event.advisoryUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" class="col-sm-1 dashboard_adv_time"></p>\n' +
    '                <p ng-if="!event.advisoryUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p ng-if="event.etrUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" class="col-sm-1"></p>\n' +
    '                <p ng-if="!event.etrUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p class="col-sm-1 dashboard_flight_info"><span>{{ event.flightInfo.routes[0].currentInfo.flightNbr }} <br/></span><span g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" class="timestamp"></span></p>\n' +
    '                <p g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="duration" timestamp="event.elapsedTime" ng-init="setElapsedTime(event)" class="col-sm-1 dashboard_elapsed_time"></p><a ng-init="isCollapsed=true" ng-click="changeRouting(isCollapsed=!isCollapsed, event.tailNbr)"><i class="fa {{collapsedIcon(isCollapsed)}}"></i></a>\n' +
    '              </div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <div collapse="isCollapsed" class="tr {{isCollapsed}}">\n' +
    '              <div g4-routing="g4-routing" list-data="event"></div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </li>\n' +
    '      </ul>\n' +
    '      <div ng-show="(eventList | filterStations:filter_stationList).length" class="eventSection sos"><a ng-click="isSOSCollapsed=!isSOSCollapsed"><span class="pull-right">{{collapsedSectionIcon(isSOSCollapsed).text}} SOS events &nbsp;<i class="fa {{collapsedSectionIcon(isSOSCollapsed).class}}"></i></span>\n' +
    '          <div class="clearfix"></div></a></div>\n' +
    '      <ul collapse="isSOSCollapsed" class="margin-none {{isSOSCollapsed}}">\n' +
    '        <li ng-repeat="event in eventList | orderBy:&quot;createdUnixTimestamp&quot; | filter:{&quot;eventCode&quot;:&quot;sos&quot;, &quot;state&quot;:&quot;open&quot;} | filterStations:filter_stationList" ng-class="{active:$first}" class="events">\n' +
    '          <div class="eventList">\n' +
    '            <div ng-class="event.eventCode.toLowerCase()" class="tr">\n' +
    '              <div class="col-sm-1 padding-none">\n' +
    '                <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicators indicator-container"></div>\n' +
    '              </div>\n' +
    '              <div class="col-sm-11"><a ng-click="goToPath($event, \'/view/\' + event.id)">\n' +
    '                  <p class="col-sm-1">{{ event.tailNbr }}</p></a>\n' +
    '                <p class="col-sm-1">{{ event.station.toUpperCase() }} <br/><span class="gate">{{ event.location }}</span></p>\n' +
    '                <p class="col-sm-1">{{ event.status.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-2">{{ event.description }}</p>\n' +
    '                <p class="col-sm-1"><span ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</span></p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.eventCode.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.rootCause.toUpperCase() }}</p>\n' +
    '                <p ng-if="event.advisoryUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" class="col-sm-1 dashboard_adv_time"></p>\n' +
    '                <p ng-if="!event.advisoryUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p ng-if="event.etrUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" class="col-sm-1"></p>\n' +
    '                <p ng-if="!event.etrUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p class="col-sm-1 dashboard_flight_info"><span>{{ event.flightInfo.routes[0].currentInfo.flightNbr }} <br/></span><span g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" class="timestamp"></span></p>\n' +
    '                <p g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="duration" timestamp="event.elapsedTime" ng-init="setElapsedTime(event)" class="col-sm-1 dashboard_elapsed_time"></p><a ng-init="isCollapsed=true" ng-click="changeRouting(isCollapsed=!isCollapsed, event.tailNbr)"><i class="fa {{collapsedIcon(isCollapsed)}}"></i></a>\n' +
    '              </div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <div collapse="isCollapsed" class="tr {{isCollapsed}}">\n' +
    '              <div g4-routing="g4-routing" list-data="event"></div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </li>\n' +
    '      </ul>\n' +
    '      <div ng-show="(eventList | filterStations:filter_stationList).length" class="eventSection hpr"><a ng-click="isHPRCollapsed=!isHPRCollapsed"><span class="pull-right">{{collapsedSectionIcon(isHPRCollapsed).text}} HPR events &nbsp;<i class="fa {{collapsedSectionIcon(isHPRCollapsed).class}}"></i></span>\n' +
    '          <div class="clearfix"></div></a></div>\n' +
    '      <ul collapse="isHPRCollapsed" class="margin-none {{isHPRCollapsed}}">\n' +
    '        <li ng-repeat="event in eventList | orderBy:&quot;createdUnixTimestamp&quot; | filter:{&quot;eventCode&quot;:&quot;hpr&quot;, &quot;state&quot;:&quot;open&quot;} | filterStations:filter_stationList" ng-class="{active:$first}" class="events">\n' +
    '          <div class="eventList">\n' +
    '            <div ng-class="event.eventCode.toLowerCase()" class="tr">\n' +
    '              <div class="col-sm-1 padding-none">\n' +
    '                <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicators indicator-container"></div>\n' +
    '              </div>\n' +
    '              <div class="col-sm-11"><a ng-click="goToPath($event, \'/view/\' + event.id)">\n' +
    '                  <p class="col-sm-1">{{ event.tailNbr }}</p></a>\n' +
    '                <p class="col-sm-1">{{ event.station.toUpperCase() }} <br/><span class="gate">{{ event.location }}</span></p>\n' +
    '                <p class="col-sm-1">{{ event.status.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-2">{{ event.description }}</p>\n' +
    '                <p class="col-sm-1"><span ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</span></p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.eventCode.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.rootCause.toUpperCase() }}</p>\n' +
    '                <p ng-if="event.advisoryUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" class="col-sm-1 dashboard_adv_time"></p>\n' +
    '                <p ng-if="!event.advisoryUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p ng-if="event.etrUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" class="col-sm-1"></p>\n' +
    '                <p ng-if="!event.etrUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p class="col-sm-1 dashboard_flight_info"><span>{{ event.flightInfo.routes[0].currentInfo.flightNbr }} <br/></span><span g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" class="timestamp"></span></p>\n' +
    '                <p g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="duration" timestamp="event.elapsedTime" ng-init="setElapsedTime(event)" class="col-sm-1 dashboard_elapsed_time"></p><a ng-init="isCollapsed=true" ng-click="changeRouting(isCollapsed=!isCollapsed, event.tailNbr)"><i class="fa {{collapsedIcon(isCollapsed)}}"></i></a>\n' +
    '              </div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <div collapse="isCollapsed" class="tr {{isCollapsed}}">\n' +
    '              <div g4-routing="g4-routing" list-data="event"></div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </li>\n' +
    '      </ul>\n' +
    '      <div ng-show="(eventList | filterStations:filter_stationList).length" class="eventSection spr"><a ng-click="isSPRCollapsed=!isSPRCollapsed"><span class="pull-right">{{collapsedSectionIcon(isSPRCollapsed).text}} SPR events &nbsp;<i class="fa {{collapsedSectionIcon(isSPRCollapsed).class}}"></i></span>\n' +
    '          <div class="clearfix"></div></a></div>\n' +
    '      <ul collapse="isSPRCollapsed" class="margin-none {{isSPRCollapsed}}">\n' +
    '        <li ng-repeat="event in eventList | orderBy:&quot;createdUnixTimestamp&quot; | filter:{&quot;eventCode&quot;:&quot;spr&quot;} | keepSPRinDashboard | filterStations:filter_stationList" ng-class="{active:$first}" class="events">\n' +
    '          <div class="eventList">\n' +
    '            <div ng-class="event.eventCode.toLowerCase()" class="tr">\n' +
    '              <div class="col-sm-1 padding-none">\n' +
    '                <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicators indicator-container"></div>\n' +
    '              </div>\n' +
    '              <div class="col-sm-11"><a ng-click="goToPath($event, \'/view/\' + event.id)">\n' +
    '                  <p class="col-sm-1">{{ event.tailNbr }}</p></a>\n' +
    '                <p class="col-sm-1">{{ event.station.toUpperCase() }} <br/><span class="gate">{{ event.location }}</span></p>\n' +
    '                <p class="col-sm-1">{{ event.status.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-2">{{ event.description }}</p>\n' +
    '                <p class="col-sm-1"><span ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</span></p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.eventCode.toUpperCase() }}</p>\n' +
    '                <p class="col-sm-1 text-center">{{ event.rootCause.toUpperCase() }}</p>\n' +
    '                <p ng-if="event.advisoryUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" class="col-sm-1 dashboard_adv_time"></p>\n' +
    '                <p ng-if="!event.advisoryUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p ng-if="event.etrUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" class="col-sm-1"></p>\n' +
    '                <p ng-if="!event.etrUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '                <p class="col-sm-1 dashboard_flight_info"><span>{{ event.flightInfo.routes[0].currentInfo.flightNbr }} <br/></span><span g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" class="timestamp"></span></p>\n' +
    '                <p g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="duration" timestamp="event.elapsedTime" ng-init="setElapsedTime(event)" class="col-sm-1 dashboard_elapsed_time"></p><a ng-init="isCollapsed=true" ng-click="changeRouting(isCollapsed=!isCollapsed, event.tailNbr)"><i class="fa {{collapsedIcon(isCollapsed)}}"></i></a>\n' +
    '              </div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <div collapse="isCollapsed" class="tr {{isCollapsed}}">\n' +
    '              <div g4-routing="g4-routing" list-data="event"></div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </li>\n' +
    '      </ul>\n' +
    '      <div ng-hide="(eventList | filterStations:filter_stationList).length" class="margin-top-large margin-bottom-large">\n' +
    '        <h1 class="text-center">No events match your search.</h1>\n' +
    '      </div>\n' +
    '    </section>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/delete/modal.jade',
    '\n' +
    '<div class="modal-content">\n' +
    '  <div class="modal-body">\n' +
    '    <p flash-message="flash-message" message="flashMessage"></p>\n' +
    '    <h2 class="text-center">Are you sure you wish to close this Event?</h2>\n' +
    '    <div class="form-actions">\n' +
    '      <button type="button" ng-click="cancel()" class="btn btn-translucent margin-right">Cancel</button>\n' +
    '      <button type="button" ng-click="deleteEvent()" class="btn btn-negative create-inspection-checkset">Close Event</button>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/delete/rt-modal.jade',
    '\n' +
    '<div class="modal-content">\n' +
    '  <div class="modal-body">\n' +
    '    <p flash-message="flash-message" message="flashMessage"></p>\n' +
    '    <h2 class="text-center">Are you sure you wish to close this Road Trip?</h2>\n' +
    '    <div class="form-actions">\n' +
    '      <button type="button" ng-click="cancel()" class="btn btn-translucent margin-right">Cancel</button>\n' +
    '      <button type="button" ng-click="deleteRT()" class="btn btn-negative create-inspection-checkset">Close Road Trip</button>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/delete/rt-warning-modal.jade',
    '\n' +
    '<div class="modal-content">\n' +
    '  <div class="modal-body">\n' +
    '    <p flash-message="flash-message" message="flashMessage"></p>\n' +
    '    <h2 class="text-center">Please close Road Trip first.</h2>\n' +
    '    <div class="form-actions">\n' +
    '      <button type="button" ng-click="cancel()" class="btn btn-negative margin-right padding-left-large padding-right-large">OK</button>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/edit/edit.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"><a ng-click="goToPath($event, \'/dashboard\')" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>Dashboard</span></a></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Edit AOS</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right">\n' +
    '      <div id="search_box" class="pull-right margin-right">\n' +
    '        <div class="margin-left input-group"><a ng-click="ng-click" class="input-group-addon"><i class="fa fa-search"></i></a>\n' +
    '          <input type="text" placeholder="Search Event History" ng-model="filter_value" id="g4-list-filter-input" ng-keyup="goToPath($event, \'/list\', filter_value)" class="form-control ng-pristine"/>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="add_info" class="margin-top-large">\n' +
    '    <form name="aosForm" ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <fieldset>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom">\n' +
    '            <p>Time Stamp:</p>\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-12"><span>\n' +
    '                {{currentTime}}\n' +
    '                UTC</span></div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Tail Number:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_tailNbr" name="tailNumber" ng-required="true" ui-select2="ui-select2" ng-model="event.tailNbr" data-placeholder="Select a Tail #..." style="min-width:100%;">\n' +
    '                <option value="">\n' +
    '                  <option ng-repeat="tailNbr in tailNbrList" value="{{tailNbr.tailNbr}}">{{tailNbr.tailNbr.toUpperCase()}}</option>\n' +
    '                </option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.tailNumber.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.tailNumber.$error.required" class="small no-bottom-margin text-danger tailNumber-required">Tail Number is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Station:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_station" name="station" ng-required="true" ui-select2="ui-select2" ng-model="event.station" data-placeholder="Select a Station..." style="min-width:100%;" required="true">\n' +
    '                <option value="">\n' +
    '                  <option ng-repeat="station in stationsList" value="{{station.name}}">{{station.name.toUpperCase()}}</option>\n' +
    '                </option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.station.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.station.$error.required" class="small no-bottom-margin text-danger station-required">Station is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Location:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <input name="location" ng-required="true" type="text" ng-model="event.location" id="location" required="true" maxlength="25" class="form-control"/>\n' +
    '              <div ng-show="aosForm.location.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.location.$error.required" class="small no-bottom-margin text-danger location-required">Location is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row pad-top">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Description:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-9">\n' +
    '              <textarea name="description" ng-required="true" ng-model="event.description" maxlength="100" class="form-control"></textarea>\n' +
    '              <div ng-show="aosForm.description.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.description.$error.required" class="small no-bottom-margin text-danger description-required">Description is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <section class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> Event Code:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_eventCode" ng-options="v.description for (k, v) in eventCodeList track by v.code" name="eventCode" ng-required="true" ng-model="event.eventCode" data-placeholder="Select an Event Code..." style="min-width:100%;" ng-change="changeRootCauseList(event.eventCode)">\n' +
    '                <option value="">Select Event Code...</option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.eventCode.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.eventCode.$error.required" class="small no-bottom-margin text-danger eventCode-required">Event Code is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Root Cause:\n' +
    '            <!--select(ng-disabled="rootCauseCodeList.length==1", ng-model="event.rootCause", ng-options="rootCauseCode.code as rootCauseCode.description for rootCauseCode in rootCauseCodeList")-->\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-3">\n' +
    '              <select id="select_rootCause" ng-options="v.description for (k, v) in rootCauseCodeList track by v.code" name="rootCause" ng-required="true" ng-model="event.rootCause" data-placeholder="Select a Root Cause Code..." style="min-width:100%;">\n' +
    '                <option value="">Select Root Cause Code...</option>\n' +
    '              </select>\n' +
    '              <div ng-show="aosForm.rootCause.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.rootCause.$error.required" class="small no-bottom-margin text-danger rootCause-required">Root Cause is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <fieldset>\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right">\n' +
    '            <p>ATA Code:</p>\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2">\n' +
    '              <div g4ata-select="g4ata-select" model="selectedCodes" display="true"></div>\n' +
    '            </div>\n' +
    '            <div class="clearfix"></div>\n' +
    '            <div ng-if="selectedCodes.length" class="margin-left margin-top">\n' +
    '              <section ng-repeat="code in selectedCodes">\n' +
    '                <div class="padding margin-bottom"><a ng-click="removeSelectedCode(code)"><i class="pull-left fa fa-times-circle"></i></a>\n' +
    '                  <h3 class="margin-left">{{code.chapter}}{{code.section}}</h3>\n' +
    '                </div>\n' +
    '              </section>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row margin-top-large">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> Status Code:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9 input-group">\n' +
    '            <label class="left">ADV (Advise... Pending ETR)\n' +
    '              <input ng-required="true" type="radio" name="statusCode" value="adv" ng-model="event.status"/><span></span>\n' +
    '              <div ng-show="aosForm.statusCode.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.statusCode.$error.required" class="small no-bottom-margin text-danger statusCode-required">Status Code is required.</p>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"></section>\n' +
    '          <section class="col-sm-9 input-group">\n' +
    '            <label class="left">ETR (Estimated Time to Repair)\n' +
    '              <input type="radio" name="statusCode" value="etr" ng-model="event.status"/><span></span>\n' +
    '            </label>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <section ng-show="event.status" class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset ng-show="event.status.toUpperCase()==\'ADV\'">\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> UTC Advisory Date:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-5 datetimepicker">\n' +
    '              <div class="input-group margin-bottom">\n' +
    '                <input name="utcAdvisoryDate" ng-required="true" type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event)" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '              <div ng-show="aosForm.utcAdvisoryDate.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcAdvisoryDate.$error.required" class="small no-bottom-margin text-danger utcAdvisoryDate-required">UTC Advisory Date is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> UTC Advisory Time:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2 datetimepicker timepicker">\n' +
    '              <timepicker name="utcAdvisoryTime" ng-required="true" ng-model="mytime" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '              <div ng-show="aosForm.utcAdvisoryTime.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcAdvisoryTime.$error.required" class="small no-bottom-margin text-danger utcAdvisoryTime-required">UTC Advisory Time is required.</p>\n' +
    '              </div>\n' +
    '              <!--input.form-control(type="text", placeholder="HH:mm")-->\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <fieldset ng-show="event.status.toUpperCase()==\'ETR\'">\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right"><span class="required text-danger">*</span> UTC ETR Date:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-5 datetimepicker">\n' +
    '              <div class="input-group margin-bottom">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event)" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '        <div class="row">\n' +
    '          <section class="col-sm-3 text-right margin-bottom"><span class="required text-danger">*</span> UTC ETR Time:\n' +
    '          </section>\n' +
    '          <section class="col-sm-9">\n' +
    '            <div class="col-sm-2 datetimepicker timepicker">\n' +
    '              <timepicker name="utcEtrTime" ng-required="true" ng-model="mytime" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '              <div ng-show="aosForm.utcEtrTime.$dirty &amp;&amp; !noModify">\n' +
    '                <p ng-show="aosForm.utcEtrTime.$error.required" class="small no-bottom-margin text-danger utcEtrTime-required">UTC ETR Time is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </section>\n' +
    '        </div>\n' +
    '      </fieldset>\n' +
    '      <section class="container border-bottom margin-top-large margin-bottom-large clearfix"></section>\n' +
    '      <fieldset class="padding-top-large padding-bottom-large text-center">\n' +
    '        <button ng-click="goToPath($event, \'/view\'+ event.id)" class="btn btn-translucent btn-larger margin-right-large">Cancel</button>\n' +
    '        <button type="submit" id="submit" ng-disabled="aosForm.$invalid || noModify" class="btn btn-solid btn-larger">Save</button>\n' +
    '      </fieldset>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/list/list.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-3 text-left"><a ng-click="goToPath(\'/dashboard\')" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>Dashboard</span></a></div>\n' +
    '    <div class="row col-sm-6">\n' +
    '      <h1>Search Results</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-3 pull-right">\n' +
    '      <div class="btn-group pull-right">\n' +
    '        <button ng-click="goToPath(\'/add\')" class="btn btn-action btn-translucent btn-default">+ New Event</button>\n' +
    '      </div>\n' +
    '      <!--div#search_box.pull-right.margin-right-->\n' +
    '      <!--  div.margin-left.input-group-->\n' +
    '      <!--    a(ng-click).input-group-addon-->\n' +
    '      <!--      i.fa.fa-search-->\n' +
    '      <!--    input.form-control.ng-pristine(type="text", placeholder="Search Event History", ng-model="filter_value", value="", id="g4-list-filter-input", ng-keyup="goToSearch(filter_value)", g4-autofocus)-->\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <!--section.row.padding-top-large-->\n' +
    '  <!--include ../partials/search.jade-->\n' +
    '  <!---->\n' +
    '  <!--div.col-md-12.margin-top-->\n' +
    '  <!--  section.border-top.border-bottom.padding-top-large.filter_box-->\n' +
    '  <!--    include ../partials/list-filter.applicability.jade-->\n' +
    '  <div id="search_list" class="col-md-12 padding-top-large">\n' +
    '    <div g4plus-super-list="g4plus-super-list" g4-service="superList.service" g4-actions="superList.actions" g4-columns="superList.columns" g4-filters="superList.filters" g4-params="superList.params" g4-update-url="superList.updateUrl" g4-success="superList.success" g4-error="superList.error"></div>\n' +
    '  </div>\n' +
    '  <!--  table-->\n' +
    '  <!--    tr.header_bar.border-->\n' +
    '  <!--      th.col-sm-1 Tail-->\n' +
    '  <!--      th.col-sm-1 Station-->\n' +
    '  <!--      th.col-sm-1 Status-->\n' +
    '  <!--      th.col-sm-3 Event-->\n' +
    '  <!--      th.col-sm-1 Event Code-->\n' +
    '  <!--      th.col-sm-1 ATA-->\n' +
    '  <!--      th.col-sm-1 Root Cause-->\n' +
    '  <!--      th.col-sm-1 Adv Time-->\n' +
    '  <!--      //th.col-sm-1 Flight Info-->\n' +
    '  <!--      th.col-sm-1 Elapsed Time-->\n' +
    '  <!--      th.col-sm-1 Reporter-->\n' +
    '  <!--    tr.bottom-border.border(ng-repeat=\'event in eventList.events | filter:filter_value\')-->\n' +
    '  <!--      td.col-sm-1 {{event.tailNbr}}-->\n' +
    '  <!--      td.col-sm-1 {{event.station.toUpperCase()}} <br/> {{event.location}}-->\n' +
    '  <!--      td.col-sm-1 {{event.status.toUpperCase()}}-->\n' +
    '  <!--      td.col-sm-3 {{event.description}}-->\n' +
    '  <!--      td.col-sm-1 {{event.eventCode}}-->\n' +
    '  <!--      td.col-sm-1 {{event.ataCode}}-->\n' +
    '  <!--      td.col-sm-1 {{event.rootCause}}-->\n' +
    '  <!--      td.col-sm-1 {{event.advisoryUnixTimestamp}}-->\n' +
    '  <!--      //td.col-sm-1 {{event.flightInfo}}-->\n' +
    '  <!--      td.col-sm-1 {{event.createdBy.elapsedTime}}-->\n' +
    '  <!--      td.col-sm-1 {{event.createdBy.fullName}}-->\n' +
    '  <!---->\n' +
    '  <!--section.col-md-9.pull-right.margin-top-large-->\n' +
    '  <!--  span.pull-right(g4-pagination-navigation, current-page="currentPage", total-pages="pageCount", page-change="total")-->\n' +
    '  <!--  span.pull-right.margin-right.pagination-message(g4-pagination-message="", current-page="currentPage", page-size="pageCount", total-items="total")-->\n' +
    '  <!---->\n' +
    '  <!---->\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/ata.modal.jade',
    '\n' +
    '<div class="modal-header">\n' +
    '  <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close"><i class="fa fa-times-circle"></i></button>\n' +
    '  <h1 class="alg-blue">Select ATA Code</h1>\n' +
    '</div>\n' +
    '<div class="modal-body">\n' +
    '  <div ng-if="parentCodes.length == 0">\n' +
    '    <table class="table-lined table-condensed">\n' +
    '      <thead>\n' +
    '        <tr class="header_bar">\n' +
    '          <th class="narrow">Chapter</th>\n' +
    '          <th class="medium">Title</th>\n' +
    '          <th class="narrow"></th>\n' +
    '        </tr>\n' +
    '      </thead>\n' +
    '      <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: \'move-animation\'}">\n' +
    '        <tr>\n' +
    '          <td class="narrow">{{code.id}}</td>\n' +
    '          <td class="medium">{{code.title}}</td>\n' +
    '          <td class="narrow text-right"><a ng-click="getChildCodes(code)">Select</a></td>\n' +
    '        </tr>\n' +
    '      </tbody>\n' +
    '    </table>\n' +
    '  </div>\n' +
    '  <div ng-if="parentCodes.length &gt; 0">\n' +
    '    <div class="btn-group pull-right">\n' +
    '      <button ng-click="getParentCodes()" class="btn btn-action btn-solid btn-default">< Back</button>\n' +
    '    </div>\n' +
    '    <table class="table-lined">\n' +
    '      <thead>\n' +
    '        <tr class="header_bar">\n' +
    '          <th class="narrow">Chapter</th>\n' +
    '          <th class="narrow">Title</th>\n' +
    '          <th class="medium"></th>\n' +
    '        </tr>\n' +
    '      </thead>\n' +
    '      <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: \'move-animation\'}">\n' +
    '        <tr>\n' +
    '          <td class="narrow">{{code.id}}</td>\n' +
    '          <td class="narrow">{{code.aircraftTypeText}}</td>\n' +
    '          <td class="medium text-left"><a ng-click="getChildCodes(code)">{{code.title}}</a></td>\n' +
    '        </tr>\n' +
    '      </tbody>\n' +
    '    </table>\n' +
    '  </div>\n' +
    '  <div g4-pagination-message="" current-page="pagination.page" page-size="10" total-items="parentATAcodes.length" class="col-md-4"></div>\n' +
    '  <div g4-pagination-navigation="" current-page="pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange" class="col-md-8 no-right-padding"></div>\n' +
    '</div>\n' +
    '<div class="modal-footer no-top-margin white-footer">\n' +
    '  <button ng-click="cancel()" class="btn btn-default pull-right modal-cancel-button">Cancel</button>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/eventList.jade',
    '\n' +
    '<div class="eventList">\n' +
    '  <div ng-class="event.eventCode.toLowerCase()" class="tr">\n' +
    '    <div class="col-sm-1 padding-none">\n' +
    '      <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicators indicator-container"></div>\n' +
    '    </div>\n' +
    '    <div class="col-sm-11"><a ng-click="goToPath($event, \'/view/\' + event.id)">\n' +
    '        <p class="col-sm-1">{{ event.tailNbr }}</p></a>\n' +
    '      <p class="col-sm-1">{{ event.station.toUpperCase() }} <br/><span class="gate">{{ event.location }}</span></p>\n' +
    '      <p class="col-sm-1">{{ event.status.toUpperCase() }}</p>\n' +
    '      <p class="col-sm-2">{{ event.description }}</p>\n' +
    '      <p class="col-sm-1"><span ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</span></p>\n' +
    '      <p class="col-sm-1 text-center">{{ event.eventCode.toUpperCase() }}</p>\n' +
    '      <p class="col-sm-1 text-center">{{ event.rootCause.toUpperCase() }}</p>\n' +
    '      <p ng-if="event.advisoryUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" class="col-sm-1 dashboard_adv_time"></p>\n' +
    '      <p ng-if="!event.advisoryUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '      <p ng-if="event.etrUnixTimestamp" g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" class="col-sm-1"></p>\n' +
    '      <p ng-if="!event.etrUnixTimestamp" class="col-sm-1">&nbsp;</p>\n' +
    '      <p class="col-sm-1 dashboard_flight_info"><span>{{ event.flightInfo.routes[0].currentInfo.flightNbr }} <br/></span><span g4-unix-timestamp-converter="" formatting="MM/DD HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" class="timestamp"></span></p>\n' +
    '      <p g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="duration" timestamp="event.elapsedTime" ng-init="setElapsedTime(event)" class="col-sm-1 dashboard_elapsed_time"></p><a ng-init="isCollapsed=true" ng-click="changeRouting(isCollapsed=!isCollapsed, event.tailNbr)"><i class="fa {{collapsedIcon(isCollapsed)}}"></i></a>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '  </div>\n' +
    '  <div collapse="isCollapsed" class="tr {{isCollapsed}}">\n' +
    '    <div g4-routing="g4-routing" list-data="event"></div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/information.jade',
    '\n' +
    '<fieldset>\n' +
    '  <div class="form-group">\n' +
    '    <label for="aircraft-program-list" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Aircraft Program:\n' +
    '    </label>\n' +
    '    <div class="col-sm-2">\n' +
    '      <select name="aircraft_program_list" id="aircraft-program-list" ng-required="true" required="required" ng-model="code.programGroupId" ng-disabled="noModify" ng-options="key as value for (key, value) in group" g4-autofocus="g4-autofocus" class="form-control">\n' +
    '        <option value="">-- Select a Program --</option>\n' +
    '      </select>\n' +
    '      <p ng-show="FecForm.aircraft_program_list.$error.required &amp;&amp; FecForm.aircraft_program_list.$dirty" class="small no-bottom-margin text-danger">Aircraft Program is required.</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="form-group">\n' +
    '    <label for="fec-code" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Code:\n' +
    '    </label>\n' +
    '    <div class="col-sm-2">\n' +
    '      <input name="fec_code" id="fec-code" type="text" ng-model="code.code" ng-required="true" required="required" ng-minlength="1" ng-maxlength="10" ng-disabled="noModify" class="form-control"/>\n' +
    '      <p ng-show="FecForm.fec_code.$error.required &amp;&amp; FecForm.fec_code.$dirty" class="small no-bottom-margin text-danger">Code is required.</p>\n' +
    '      <p ng-show="FecForm.fec_code.$error.maxlength" class="small no-bottom-margin text-danger">Code is only up to 10 characters.</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="form-group">\n' +
    '    <label for="fec-title" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Title:\n' +
    '    </label>\n' +
    '    <div class="col-sm-5">\n' +
    '      <input name="fec_title" id="fec-title" type="text" ng-model="code.title" ng-required="true" required="required" ng-minlength="1" ng-maxlength="50" ng-disabled="noModify" class="form-control"/>\n' +
    '      <p ng-show="FecForm.fec_title.$error.required &amp;&amp; FecForm.fec_title.$dirty" class="small no-bottom-margin text-danger">Title is required.</p>\n' +
    '      <p ng-show="FecForm.fec_title.$error.maxlength" class="small no-bottom-margin text-danger">Title is only up to 45 characters.</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="form-group">\n' +
    '    <label for="fec-effective-date" class="col-sm-2 text-right">Effective Date:</label>\n' +
    '    <div class="col-sm-2 input-group"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>\n' +
    '      <input name="fec_effective_date" id="fec-effective-date" type="text" ng-model="code.effectiveDate" ng-disabled="noModify" g4plus-date="code.effectiveDate" class="form-control ng-isolate-scope ng-dirty ng-valid-date ng-valid ng-valid-required"/>\n' +
    '    </div>\n' +
    '    <p ng-show="FecForm.fec_effective_date.$invalid" class="small no-bottom-margin text-danger">Effective Date must be formatted properly.</p>\n' +
    '  </div>\n' +
    '  <div class="form-group">\n' +
    '    <label for="fec-discontinue-date" class="col-sm-2 text-right">Discontinue Date:</label>\n' +
    '    <div class="col-sm-2 input-group"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>\n' +
    '      <input name="fec_discontinue_date" id="fec-discontinue-date" type="text" ng-model="code.discontinueDate" ng-disabled="noModify" g4plus-date="code.discontinueDate" class="form-control"/>\n' +
    '    </div>\n' +
    '    <p ng-show="FecForm.fec_discontinue_date.$dirty &amp;&amp; FecForm.fec_discontinue_date.$invalid" class="small no-bottom-margin text-danger">Discontinue Date must be formatted properly.</p>\n' +
    '  </div>\n' +
    '</fieldset>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/list-filter.applicability.jade',
    '\n' +
    '<div class="col-sm-6">\n' +
    '  <p>Filter by:<strong>&nbsp;Stations</strong></p>\n' +
    '  <div class="col-sm-4">\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;ALL&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;EAST&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;WEST&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;HVY&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;SFB&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="col-sm-4">\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;PIE&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;FLL&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;PGD&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;LAS&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;LAX&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="col-sm-4">\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;ENV&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;AZA&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;HNL&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;BLI&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;NON&nbsp;<span class="count">(2)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>\n' +
    '<div class="col-sm-2 border-right border-left">\n' +
    '  <p><strong>Event Code</strong></p>\n' +
    '  <div class="col-sm-12">\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;AOS&nbsp;<span class="count">(52)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;SOS&nbsp;<span class="count">(24)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '    <div class="row">\n' +
    '      <label>\n' +
    '        <input type="checkbox"/>&nbsp;HPR&nbsp;<span class="count">(37)</span>\n' +
    '      </label>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>\n' +
    '<div class="col-sm-2 border-right">\n' +
    '  <p><strong>Date</strong></p>\n' +
    '  <form>\n' +
    '    <div class="row input-group col-sm-12">\n' +
    '      <input type="text" placeholder="MM/DD/YYYY" class="form-control"/><span class="input-group-addon"><i class="fa fa-calendar"></i></span>\n' +
    '    </div>\n' +
    '    <div class="clearfix padding-bottom-medium"></div><a ng-click="ng-click">Select a Date Range</a>\n' +
    '  </form>\n' +
    '</div>\n' +
    '<div class="col-sm-2">\n' +
    '  <p><strong>Time</strong></p>\n' +
    '  <div class="col-sm-5 text-right"><span>Within&nbsp;</span></div>\n' +
    '  <div class="col-sm-5"><span class="dropdown">\n' +
    '      <button type="button" data-toggle="dropdown" class="btn btn-default dropdown-toggle">Today &nbsp;<i class="fa fa-angle-down"></i></button>\n' +
    '      <ul class="dropdown-menu">\n' +
    '        <li><a>test1</a></li>\n' +
    '        <li><a>test2</a></li>\n' +
    '        <li><a>test3</a></li>\n' +
    '      </ul></span></div>\n' +
    '  <div class="clearfix margin-bottom"></div>\n' +
    '  <div class="col-sm-5 text-right"><span>of&nbsp;</span></div>\n' +
    '  <div class="col-sm-5 time_field">\n' +
    '    <input type="text" placeholder="MM:HH" class="form-control"/>\n' +
    '  </div>\n' +
    '</div>\n' +
    '<div class="clearfix"></div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/messages.jade',
    '\n' +
    '<p flash-message="flash-message" message="flashMessage"></p>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/modal.information.jade',
    '\n' +
    '<div class="modal-dialog">\n' +
    '  <div class="modal-content">\n' +
    '    <div class="modal-header">\n' +
    '      <button type="button" data-dismiss="modal" aria-hidden="true" class="close">&times;</button>\n' +
    '      <h4 class="modal-title">Aircraft Information</h4>\n' +
    '    </div>\n' +
    '    <div class="modal-body">\n' +
    '      <form name="aircraftAdd">\n' +
    '        <fieldset>\n' +
    '          <div class="form-group">\n' +
    '            <label for="aircraft-program-list" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Aircraft Program:\n' +
    '            </label>\n' +
    '            <div class="col-sm-2">\n' +
    '              <select name="aircraft_program_list" id="aircraft-program-list" ng-required="true" required="required" ng-model="code.programGroupId" ng-disabled="noModify" ng-options="key as value for (key, value) in group" g4-autofocus="g4-autofocus" class="form-control">\n' +
    '                <option value="">-- Select a Program --</option>\n' +
    '              </select>\n' +
    '              <p ng-show="FecForm.aircraft_program_list.$error.required &amp;&amp; FecForm.aircraft_program_list.$dirty" class="small no-bottom-margin text-danger">Aircraft Program is required.</p>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '          <div class="form-group">\n' +
    '            <label for="fec-code" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Code:\n' +
    '            </label>\n' +
    '            <div class="col-sm-2">\n' +
    '              <input name="fec_code" id="fec-code" type="text" ng-model="code.code" ng-required="true" required="required" ng-minlength="1" ng-maxlength="10" ng-disabled="noModify" class="form-control"/>\n' +
    '              <p ng-show="FecForm.fec_code.$error.required &amp;&amp; FecForm.fec_code.$dirty" class="small no-bottom-margin text-danger">Code is required.</p>\n' +
    '              <p ng-show="FecForm.fec_code.$error.maxlength" class="small no-bottom-margin text-danger">Code is only up to 10 characters.</p>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '          <div class="form-group">\n' +
    '            <label for="fec-title" class="col-sm-2 text-right"><span class="required text-danger">*&nbsp;</span>Title:\n' +
    '            </label>\n' +
    '            <div class="col-sm-5">\n' +
    '              <input name="fec_title" id="fec-title" type="text" ng-model="code.title" ng-required="true" required="required" ng-minlength="1" ng-maxlength="50" ng-disabled="noModify" class="form-control"/>\n' +
    '              <p ng-show="FecForm.fec_title.$error.required &amp;&amp; FecForm.fec_title.$dirty" class="small no-bottom-margin text-danger">Title is required.</p>\n' +
    '              <p ng-show="FecForm.fec_title.$error.maxlength" class="small no-bottom-margin text-danger">Title is only up to 45 characters.</p>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '          <div class="form-group">\n' +
    '            <label for="fec-effective-date" class="col-sm-2 text-right">Effective Date:</label>\n' +
    '            <div class="col-sm-2 input-group"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>\n' +
    '              <input name="fec_effective_date" id="fec-effective-date" type="text" ng-model="code.effectiveDate" ng-disabled="noModify" g4plus-date="code.effectiveDate" class="form-control ng-isolate-scope ng-dirty ng-valid-date ng-valid ng-valid-required"/>\n' +
    '            </div>\n' +
    '            <p ng-show="FecForm.fec_effective_date.$invalid" class="small no-bottom-margin text-danger">Effective Date must be formatted properly.</p>\n' +
    '          </div>\n' +
    '          <div class="form-group">\n' +
    '            <label for="fec-discontinue-date" class="col-sm-2 text-right">Discontinue Date:</label>\n' +
    '            <div class="col-sm-2 input-group"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>\n' +
    '              <input name="fec_discontinue_date" id="fec-discontinue-date" type="text" ng-model="code.discontinueDate" ng-disabled="noModify" g4plus-date="code.discontinueDate" class="form-control"/>\n' +
    '            </div>\n' +
    '            <p ng-show="FecForm.fec_discontinue_date.$dirty &amp;&amp; FecForm.fec_discontinue_date.$invalid" class="small no-bottom-margin text-danger">Discontinue Date must be formatted properly.</p>\n' +
    '          </div>\n' +
    '        </fieldset>\n' +
    '      </form>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/parts.modal.jade',
    '\n' +
    '<div class="modal-header">\n' +
    '  <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close">&times;</button>\n' +
    '  <h1 class="alg-blue">Select Parts</h1>\n' +
    '</div>\n' +
    '<div class="modal-body">\n' +
    '  <div>\n' +
    '    <table class="table-lined">\n' +
    '      <thead>\n' +
    '        <tr class="header_bar">\n' +
    '          <th class="narrow">Part</th>\n' +
    '          <th class="medium">Description</th>\n' +
    '          <th class="narrow"></th>\n' +
    '        </tr>\n' +
    '      </thead>\n' +
    '      <tbody ng-repeat="part in parts | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize">\n' +
    '        <tr>\n' +
    '          <td class="narrow">{{part.part}}</td>\n' +
    '          <td class="medium">{{part.description}}</td>\n' +
    '          <td class="narrow text-right"><a ng-click="addToPartsList(part)">Select</a></td>\n' +
    '        </tr>\n' +
    '      </tbody>\n' +
    '    </table>\n' +
    '  </div>\n' +
    '  <div g4-pagination-message="" current-page="pagination.page" page-size="10" total-items="parts.length" class="col-md-4"></div>\n' +
    '  <div g4-pagination-navigation="" current-page="pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange" class="col-md-8"></div>\n' +
    '</div>\n' +
    '<div class="modal-footer no-top-margin">\n' +
    '  <button ng-click="cancel()" class="btn btn-default pull-right">Cancel</button>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/partials/search.jade',
    '\n' +
    '<input type="text" name="search_query" placeholder="Search query" ng-model="filter_value" g4-autofocus="g4-autofocus" class="search-input pull-left"/>\n' +
    '<btn class="btn btn-primary btn-rght-rounded btn-search pull-left"><i class="icon-search"></i></btn>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/roadtrip/add.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"><a ng-click="goToPath($event, \'/view/\' + event.id)" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>AOS Event</span></a></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Road Trip to AOS {{event.flightInfo.currentInfo.flightNbr}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right"></div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="roadtrip_info">\n' +
    '    <form name="roadTripForm" ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>AOS Tracking Details</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_tracking_details" class="collapse-section">\n' +
    '        <div class="col-sm-3"><span>Tail No.:</span>\n' +
    '          <h3>{{event.tailNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-4"><span>AOS Date:</span>\n' +
    '          <h3 g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="event.createdUnixTimestamp" event="event"></h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-3"><span>Flight No.:</span>\n' +
    '          <h3>{{event.flightInfo.routes[2].currentInfo.flightNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-2"><span>Station:</span>\n' +
    '          <h3>{{event.station.toUpperCase()}}</h3>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top-large margin-bottom-large"><span>Reason:</span>\n' +
    '          <p ng-show="event.description!=\'\'">{{event.description}}</p>\n' +
    '          <p ng-show="event.description==\'\'">No description has been added to this event.</p>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top-large margin-bottom"></div>\n' +
    '        <div class="col-sm-3"><span>ATA Code:</span><span><strong ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</strong></span></div>\n' +
    '        <div class="col-sm-5"><span>Description:</span><span><strong>Air Conditioning and Pressurization</strong></span></div>\n' +
    '        <div class="col-sm-4"><span class="required text-danger">*</span> Inspector Required:\n' +
    '          <label>Yes\n' +
    '            <input type="radio" ng-model="newRoadTrip.inspectionRequired" value="Y" name="inspectionReq" required="required"/><span></span>\n' +
    '          </label>\n' +
    '          <label>No\n' +
    '            <input type="radio" ng-model="newRoadTrip.inspectionRequired" value="N" name="inspectionReq" required="required"/><span></span>\n' +
    '          </label>\n' +
    '          <div ng-show="roadTripForm.inspectionReq.$dirty">\n' +
    '            <p ng-show="roadTripForm.inspectionReq.$error.required" class="small no-bottom-margin text-danger inspectionReq-required">Inspector Required is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top-large"></div>\n' +
    '        <div class="col-sm-12 margin-top"><span class="required text-danger">*</span> Special Equipment Requirements:\n' +
    '          <textarea name="specialEquipReq" ng-required="true" rows="5" ng-model="newRoadTrip.specialEquipmentReqs" maxlength="250" class="form-control"></textarea>\n' +
    '          <div ng-show="roadTripForm.specialEquipReq.$dirty">\n' +
    '            <p ng-show="roadTripForm.specialEquipReq.$error.required" class="small no-bottom-margin text-danger specialEquipReq-required">Special Equipment Requirements is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Parts<strong>&nbsp;({{parts.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_parts" class="collapse-section">\n' +
    '        <div ng-show="parts.length &gt; 0">\n' +
    '          <section class="col-sm-3">\n' +
    '            <label>Part #</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-1">\n' +
    '            <label>Qty</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-6">\n' +
    '            <label>Description</label>\n' +
    '          </section>\n' +
    '          <div ng-repeat="part in parts" class="row margin-top">\n' +
    '            <section class="col-sm-3">\n' +
    '              <input type="text" ng-model="part.partNbr" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section class="col-sm-1">\n' +
    '              <input type="text" ng-model="part.qty" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="part.partNbr==null" class="col-sm-8">\n' +
    '              <input type="text" ng-model="part.description" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="part.partNbr!=null" class="col-sm-8">\n' +
    '              <div class="col-sm-11">\n' +
    '                <input type="text" ng-model="part.description" class="form-control"/>\n' +
    '              </div>\n' +
    '              <div class="col-sm-1"><i ng-click="deleteItem(parts, $index)" class="pull-left fa fa-times-circle"></i></div>\n' +
    '            </section>\n' +
    '          </div>\n' +
    '          <div class="col-sm-12 margin-top"><a ng-click="addPartFields()">+ Add Part</a></div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6 margin-top-large">\n' +
    '          <h2>Tooling<strong>&nbsp;({{tooling.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div ng-show="tooling.length &gt; 0">\n' +
    '          <section class="col-sm-3">\n' +
    '            <label>Tooling #</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-1">\n' +
    '            <label>Qty</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-6">\n' +
    '            <label>Description</label>\n' +
    '          </section>\n' +
    '          <div ng-repeat="tool in tooling" class="row margin-top">\n' +
    '            <section class="col-sm-3">\n' +
    '              <input type="text" ng-model="tool.toolNbr" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section class="col-sm-1">\n' +
    '              <input type="text" ng-model="tool.qty" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="tool.toolNbr==null" class="col-sm-8">\n' +
    '              <input type="text" ng-model="tool.description" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="tool.toolNbr!=null" class="col-sm-8">\n' +
    '              <div class="col-sm-11">\n' +
    '                <input type="text" ng-model="tool.description" class="form-control"/>\n' +
    '              </div>\n' +
    '              <div class="col-sm-1"><i ng-click="deleteItem(tooling, $index)" class="pull-left fa fa-times-circle"></i></div>\n' +
    '            </section>\n' +
    '          </div>\n' +
    '          <div class="col-sm-12 margin-top"><a ng-click="addToolingFields()">+ Add Tool</a></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2><span class="required text-danger">*</span> Prescribed Repair Scheme\n' +
    '          </h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_repair_scheme" class="collapse-section">\n' +
    '        <div class="col-sm-12">\n' +
    '          <textarea name="prescribedRepairScheme" ng-required="true" rows="5" ng-model="newRoadTrip.repairScheme" maxlength="250" class="form-control">{{newRoadTrip.repairScheme}}</textarea>\n' +
    '          <div ng-show="roadTripForm.prescribedRepairScheme.$dirty">\n' +
    '            <p ng-show="roadTripForm.prescribedRepairScheme.$error.required" class="small no-bottom-margin text-danger prescribedRepairScheme-required">Prescribed Repair Scheme is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Traveler Information<strong>&nbsp;({{travelers.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="traveler_info" collapse="isCollapsed_traveler_info" class="collapse-section">\n' +
    '        <div class="col-sm-12 pull-right margin-bottom">\n' +
    '          <div class="text-left"><i class="fa fa-mail-reply">&nbsp;&nbsp;</i>\n' +
    '            <!--a Employee Lookup--><span g4employee-lookup="g4employee-lookup" model="employeeDirectory" link-text="Employee Directory"></span>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div ng-repeat="person in travelers" class="person">\n' +
    '          <label class="col-sm-2">First Name\n' +
    '            <input type="text" ng-model="person.employee.firstName" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Last Name\n' +
    '            <input type="text" ng-model="person.employee.lastName" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">ID\n' +
    '            <input type="number" ng-model="person.employee.id" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">D.O.B.\n' +
    '            <input type="text" ng-model="person.employee.DOB" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">Base\n' +
    '            <input type="text" ng-model="person.employee.base" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="person.employee.phone" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">Gender\n' +
    '            <select ng-model="person.employee.gender" ng-options="gender as gender for gender in genders" disabled="disabled"></select>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div ng-hide="person.travelInfo.hotels.length || person.travelInfo.airlines.length || person.travelInfo.cars.length || !person.employee.id" class="col-sm-12"><i ng-click="deleteItem(travelers, $index)" class="pull-left fa fa-times-circle"></i><small>&nbsp;&nbsp;|&nbsp;&nbsp;</small><a ng-click="add(event.id, $index)">Add Travel Arrangements</a></div>\n' +
    '          <div ng-init="isCollapsed_travel_arrangements=true" class="clearfix"></div>\n' +
    '          <div ng-show="person.travelInfo.hotels.length || person.travelInfo.airlines.length || person.travelInfo.cars.length" class="col-sm-12 margin-bottom"><i ng-click="deleteItem(travelers, $index)" class="pull-left fa fa-times-circle"></i><small>&nbsp;&nbsp;|&nbsp;&nbsp;</small><a ng-show="!isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements">Travel Arrangements -</a><a ng-show="isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements">Travel Arrangements ></a></div>\n' +
    '          <di class="clearfix"></di>\n' +
    '          <div collapse="isCollapsed_travel_arrangements">\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.hotels.length">\n' +
    '                <div ng-repeat="hotel in person.travelInfo.hotels">\n' +
    '                  <div class="col-sm-3 text-left"><span>Hotel:</span><span>{{hotel.name}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span></span><span>{{hotel.address}} {{hotel.city}}, {{hotel.state}} {{hotel.zip}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span>Phone:</span><span>{{hotel.phone}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{hotel.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'hotel\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.hotels.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Hotel:</span><a ng-click="edit(event.id, \'hotel\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.airlines.length">\n' +
    '                <div ng-repeat="airline in person.travelInfo.airlines">\n' +
    '                  <div class="col-sm-3 text-left"><span><strong>Airline:</strong></span><span>{{airline.name}}</span></div>\n' +
    '                  <div class="col-sm-1 text-left"><span></span><span>{{airline.departure.flightNbr}}</span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span><strong>{{airline.departure.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.departure.departUnixTimestamp" event="event"></span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.departure.seat}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.departure.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                  <div class="col-sm-3"></div>\n' +
    '                  <div class="col-sm-1 text-left"><span></span><span>{{airline.arrival.flightNbr}}</span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span><strong>{{airline.arrival.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.arrival.arriveUnixTimestamp" event="event"></span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.arrival.seat}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.arrival.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'airline\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.airlines.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Airline:</span><a ng-click="edit(event.id, \'airline\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.cars.length">\n' +
    '                <div ng-repeat="car in person.travelInfo.cars">\n' +
    '                  <div class="col-sm-3 text-left"><span>Car:</span><span>{{car.name}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span></span><span>{{car.address}} {{car.city}}, {{car.state}} {{car.zip}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span>Phone:</span><span>{{car.phone}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{car.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'car\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.cars.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Car:</span><a ng-click="edit(event.id, \'car\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-12 margin-top-large"><span g4employee-lookup="g4employee-lookup" model="employeeDirectory" link-text="+ Add Traveler"></span>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Station Information</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="station_info" collapse="isCollapsed_station_info" class="collapse-section">\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> Manager First Name\n' +
    '          <input name="managerFirstName" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.firstName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerFirstName.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerFirstName.$error.required" class="small no-bottom-margin text-danger managerFirstName-required">Manager First Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> Manager Last Name\n' +
    '          <input name="managerLastName" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.lastName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerLastName.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerLastName.$error.required" class="small no-bottom-margin text-danger managerLastName-required">Manager Last Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '          <input name="managerPhone" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.phone" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerPhone.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerPhone.$error.required" class="small no-bottom-margin text-danger managerPhone-required">Phone is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> On-Call First Name\n' +
    '          <input name="onCallFirstName" ng-required="true" type="text" ng-model="newRoadTrip.stationOnCall.firstName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallFirstName.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallFirstName.$error.required" class="small no-bottom-margin text-danger onCallFirstName-required">On-Call First Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> On-Call Last Name\n' +
    '          <input name="onCallLastName" ng-required="true" type="text" ng-model="newRoadTrip.stationOnCall.lastName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallLastName.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallLastName.$error.required" class="small no-bottom-margin text-danger onCallLastName-required">On-Call Last Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '          <input name="onCallPhone" ng-required="true" type="text" ng-model="newRoadTrip.stationOnCall.phone" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallPhone.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallPhone.$error.required" class="small no-bottom-margin text-danger onCallPhone-required">Phone is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <label class="col-sm-4"><span class="required text-danger">*</span> Address\n' +
    '          <input name="stationAddress" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.address" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationAddress.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationAddress.$error.required" class="small no-bottom-margin text-danger stationAddress-required"> Address is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> City\n' +
    '          <input name="stationCity" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.city" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationCity.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationCity.$error.required" class="small no-bottom-margin text-danger stationCity-required"> City is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-1"><span class="required text-danger">*</span> State\n' +
    '          <select name="stationState" ng-required="true" ng-model="newRoadTrip.stationManager.state">\n' +
    '            <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            <div ng-show="roadTripForm.stationState.$dirty">\n' +
    '              <p ng-show="roadTripForm.stationState.$error.required" class="small no-bottom-margin text-danger stationState-required"> State is required.</p>\n' +
    '            </div>\n' +
    '          </select>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Zipcode\n' +
    '          <input name="stationZipcode" ng-required="true" type="text" ng-model="newRoadTrip.stationManager.zip" maxlength="5" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationZipcode.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationZipcode.$error.required" class="small no-bottom-margin text-danger stationZipcode-required"> Zipcode is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>On-Call Maintenance Vendor Information<strong>&nbsp;({{vendors.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="vendor_info" collapse="isCollapsed_vendor_info" class="collapse-section">\n' +
    '        <div ng-repeat="vendor in vendors" ng-class="{\'vendor\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(vendors, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4"><span class="required text-danger">*</span> Vendor Name\n' +
    '            <input name="vendorName" ng-required="true" type="text" ng-model="vendor.name" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.vendorName.$dirty">\n' +
    '              <p ng-show="roadTripForm.vendorName.$error.required" class="small no-bottom-margin text-danger vendorName-required">Vendor Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Contract No.\n' +
    '            <input name="contractNo" ng-required="true" type="text" ng-model="vendor.contract" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contractNo.$dirty">\n' +
    '              <p ng-show="roadTripForm.contractNo.$error.required" class="small no-bottom-margin text-danger contractNo-required">Contract No. is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> Contact First Name\n' +
    '            <input name="contactFirstName" ng-required="true" type="text" ng-model="vendor.contactFirstName" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactFirstName.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactFirstName.$error.required" class="small no-bottom-margin text-danger contactFirstName-required">Contact First Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> Contact Last Name\n' +
    '            <input name="contactLastName" ng-required="true" type="text" ng-model="vendor.contactLastName" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactLastName.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactLastName.$error.required" class="small no-bottom-margin text-danger contactLastName-required">Contact Last Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '            <input name="contactPhone" ng-required="true" type="text" ng-model="vendor.phone" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactPhone.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactPhone.$error.required" class="small no-bottom-margin text-danger contactPhone-required">Phone is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Fax\n' +
    '            <input name="contactFax" ng-required="true" type="text" ng-model="vendor.fax" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactFax.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactFax.$error.required" class="small no-bottom-margin text-danger contactFax-required">Fax is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4"><span class="required text-danger">*</span> Address\n' +
    '            <input name="contactAddress" ng-required="true" type="text" ng-model="vendor.address" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactAddress.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactAddress.$error.required" class="small no-bottom-margin text-danger contactAddress-required">Address is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> City\n' +
    '            <input name="contactCity" ng-required="true" type="text" ng-model="vendor.city" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactCity.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactCity.$error.required" class="small no-bottom-margin text-danger contactCity-required">City is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1"><span class="required text-danger">*</span> State\n' +
    '            <select ng-model="vendor.state">\n' +
    '              <option name="contactState" ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '              <div ng-show="roadTripForm.contactState.$dirty">\n' +
    '                <p ng-show="roadTripForm.contactState.$error.required" class="small no-bottom-margin text-danger contactState-required">State is required.</p>\n' +
    '              </div>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Zipcode\n' +
    '            <input name="contactZipcode" ng-required="true" type="text" ng-model="vendor.zip" maxlength="5" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactZipcode.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactZipcode.$error.required" class="small no-bottom-margin text-danger contactZipcode-required">Zipcode is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addVendorFields()">+ Add Vendor</a>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <fieldset class="margin-top-large padding-bottom-large text-center">\n' +
    '          <button ng-click="cancelRTcreation()" class="btn btn-translucent btn-larger margin-right-large">Cancel</button>\n' +
    '          <button type="submit" id="submit" class="btn btn-solid btn-larger">Save</button>\n' +
    '        </fieldset>\n' +
    '      </div>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/roadtrip/add_travel.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Road Trip to AOS {{event.flightInfo.currentInfo.flightNbr}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right"></div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="roadtrip_info" class="travel_info">\n' +
    '    <form ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <div id="traveler_info" class="collapse-section">\n' +
    '        <div class="col-sm-12 pull-right margin-bottom-large">\n' +
    '          <div class="icon_container col-sm-1"><i class="fa fa-mail-reply"></i></div>\n' +
    '          <div class="col-sm-3 text-left"><a href="http://www.globalcrewlogistics.com/" target="_blank">Global Crew Logistics Website</a></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="person padding-bottom">\n' +
    '          <div class="col-sm-12">\n' +
    '            <div class="icon_container col-sm-1"><i class="fa fa-user"></i></div>\n' +
    '            <div class="col-sm-2 text-left">\n' +
    '              <h3>{{currentTraveler.employee.firstName}} {{currentTraveler.employee.lastName}}</h3>\n' +
    '            </div>\n' +
    '            <div class="col-sm-1 text-center"><span>ID:</span><span><strong>{{currentTraveler.employee.id}}</strong></span></div>\n' +
    '            <div class="col-sm-3 text-center"><span>Phone:</span><span><strong>{{currentTraveler.employee.phone}}</strong></span></div>\n' +
    '            <div class="col-sm-1 text-center"><span>Base:</span><span><strong>{{currentTraveler.employee.base}}</strong></span></div>\n' +
    '            <div class="col-sm-3 text-center"><span>D.O.B:</span><span><strong>{{currentTraveler.employee.DOB}}</strong></span></div>\n' +
    '            <div class="col-sm-1 text-center"><span>Gender:</span><span><strong>{{currentTraveler.employee.gender}}</strong></span></div>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Hotels</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_hotels" ng-click="isCollapsed_hotels = !isCollapsed_hotels" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_hotels" ng-click="isCollapsed_hotels = !isCollapsed_hotels" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_hotels" class="collapse-section">\n' +
    '        <div ng-repeat="hotel in currentTraveler.travelInfo.hotels" ng-class="{\'hotel\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(hotels, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Hotel Name\n' +
    '            <input type="text" ng-model="hotel.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="hotel.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="hotel.phone" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Address\n' +
    '            <input type="text" ng-model="hotel.address" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3">City\n' +
    '            <input type="text" ng-model="hotel.city" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">State\n' +
    '            <select ng-model="hotel.state">\n' +
    '              <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Zipcode\n' +
    '            <input type="text" ng-model="hotel.zip" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addHotelFields()">+ Add Hotel</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Airlines</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_airlines" ng-click="isCollapsed_airlines = !isCollapsed_airlines" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_airlines" ng-click="isCollapsed_airlines = !isCollapsed_airlines" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_airlines" class="collapse-section">\n' +
    '        <div ng-repeat="airline in currentTraveler.travelInfo.airlines" ng-class="{\'airline\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(airlines, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Airline Name\n' +
    '            <input type="text" ng-model="airline.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div><strong class="margin-top col-sm-6">Departure</strong>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="airline.departure.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Flight Number\n' +
    '            <input type="text" ng-model="airline.departure.flightNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Airport\n' +
    '            <input type="text" ng-model="airline.departure.station" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="col-sm-2 datetimepicker">\n' +
    '            <label>Date\n' +
    '              <div class="input-group">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt[airline.id]" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event); openDate = !openDate" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <div class="col-sm-2 datetimepicker timepicker">\n' +
    '            <label>Time\n' +
    '              <timepicker ng-model="mytime_dt[airline.id]" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <label class="col-sm-1">Seat\n' +
    '            <input type="text" ng-model="airline.departure.seat" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div><strong class="margin-top col-sm-6">Arrival</strong>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="airline.arrival.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Flight Number\n' +
    '            <input type="text" ng-model="airline.arrival.flightNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Airport\n' +
    '            <input type="text" ng-model="airline.arrival.station" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="col-sm-2 datetimepicker">\n' +
    '            <label>Date\n' +
    '              <div class="input-group">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="at[airline.id]" is-open="openDate2" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event); openDate2 = !openDate2" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <div class="col-sm-2 datetimepicker timepicker">\n' +
    '            <label>Time\n' +
    '              <timepicker ng-model="mytime_at[airline.id]" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <label class="col-sm-1">Seat\n' +
    '            <input type="text" ng-model="airline.arrival.seat" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addAirlineFields()">+ Add Airline</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Cars</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_cars" ng-click="isCollapsed_cars = !isCollapsed_cars" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_cars" ng-click="isCollapsed_cars = !isCollapsed_cars" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_cars" class="collapse-section">\n' +
    '        <div ng-repeat="car in currentTraveler.travelInfo.cars" ng-class="{\'car\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(cars, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Car Name\n' +
    '            <input type="text" ng-model="car.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="car.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="car.phone" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Address\n' +
    '            <input type="text" ng-model="car.address" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3">City\n' +
    '            <input type="text" ng-model="car.city" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">State\n' +
    '            <select ng-model="car.state">\n' +
    '              <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Zipcode\n' +
    '            <input type="text" ng-model="car.zip" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addCarFields()">+ Add Car</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <fieldset class="margin-top-large padding-bottom-large text-center">\n' +
    '          <button ng-click="goToPath($event, \'/roadtrip/add/\' + id)" class="btn btn-translucent btn-larger margin-right-large">Cancel</button>\n' +
    '          <button type="submit" id="submit" class="btn btn-solid btn-larger">Save</button>\n' +
    '        </fieldset>\n' +
    '      </div>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/roadtrip/edit.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"><a ng-click="goToPath($event, \'/view/\' + event.id)" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>AOS Event</span></a></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Road Trip to AOS {{event.flightInfo.currentInfo.flightNbr}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right"></div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="roadtrip_info">\n' +
    '    <form name="roadTripForm" ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>AOS Tracking Details</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_tracking_details" class="collapse-section">\n' +
    '        <div class="col-sm-3"><span>Tail No.:</span>\n' +
    '          <h3>{{event.tailNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-4"><span>AOS Date:</span>\n' +
    '          <h3 g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="event.createdUnixTimestamp" event="event"></h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-3"><span>Flight No.:</span>\n' +
    '          <h3>{{event.flightInfo.routes[2].currentInfo.flightNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-2"><span>Station:</span>\n' +
    '          <h3>{{event.station.toUpperCase()}}</h3>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top-large margin-bottom-large"><span>Reason:</span>\n' +
    '          <p ng-show="event.description!=\'\'">{{event.description}}</p>\n' +
    '          <p ng-show="event.description==\'\'">No description has been added to this event.</p>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top-large margin-bottom"></div>\n' +
    '        <div class="col-sm-3"><span>ATA Code:</span><span><strong ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</strong></span></div>\n' +
    '        <div class="col-sm-5"><span>Description:</span><span><strong>Air Conditioning and Pressurization</strong></span></div>\n' +
    '        <div class="col-sm-4"><span class="required text-danger">*</span> Inspector Required:\n' +
    '          <label>Yes\n' +
    '            <input type="radio" ng-model="roadTrip.inspectionRequired" value="Y" name="inspectionReq" required="required"/><span></span>\n' +
    '          </label>\n' +
    '          <label>No\n' +
    '            <input type="radio" ng-model="roadTrip.inspectionRequired" value="N" name="inspectionReq" required="required"/><span></span>\n' +
    '          </label>\n' +
    '          <div ng-show="roadTripForm.inspectionReq.$dirty">\n' +
    '            <p ng-show="roadTripForm.inspectionReq.$error.required" class="small no-bottom-margin text-danger inspectionReq-required">Inspector Required is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top-large"></div>\n' +
    '        <div class="col-sm-12 margin-top"><span class="required text-danger">*</span> Special Equipment Requirements:\n' +
    '          <textarea name="specialEquipReq" ng-required="true" rows="5" ng-model="roadTrip.specialEquipmentReqs" maxlength="250" class="form-control"></textarea>\n' +
    '          <div ng-show="roadTripForm.specialEquipReq.$dirty">\n' +
    '            <p ng-show="roadTripForm.specialEquipReq.$error.required" class="small no-bottom-margin text-danger specialEquipReq-required">Special Equipment Requirements is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Parts<strong>&nbsp;({{parts.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_parts" class="collapse-section">\n' +
    '        <div ng-show="parts.length &gt; 0">\n' +
    '          <section class="col-sm-3">\n' +
    '            <label>Part #</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-1">\n' +
    '            <label>Qty</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-6">\n' +
    '            <label>Description</label>\n' +
    '          </section>\n' +
    '          <div ng-repeat="part in parts" class="row margin-top">\n' +
    '            <section class="col-sm-3">\n' +
    '              <input type="text" ng-model="part.partNbr" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section class="col-sm-1">\n' +
    '              <input type="text" ng-model="part.qty" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="part.partNbr==null" class="col-sm-8">\n' +
    '              <input type="text" ng-model="part.description" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="part.partNbr!=null" class="col-sm-8">\n' +
    '              <div class="col-sm-11">\n' +
    '                <input type="text" ng-model="part.description" class="form-control"/>\n' +
    '              </div>\n' +
    '              <div class="col-sm-1"><i ng-click="deleteItem(parts, $index)" class="pull-left fa fa-times-circle"></i></div>\n' +
    '            </section>\n' +
    '          </div>\n' +
    '          <div class="col-sm-12 margin-top"><a ng-click="addPartFields()">+ Add Part</a></div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6 margin-top-large">\n' +
    '          <h2>Tooling<strong>&nbsp;({{tooling.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div ng-show="tooling.length &gt; 0">\n' +
    '          <section class="col-sm-3">\n' +
    '            <label>Tooling #</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-1">\n' +
    '            <label>Qty</label>\n' +
    '          </section>\n' +
    '          <section class="col-sm-6">\n' +
    '            <label>Description</label>\n' +
    '          </section>\n' +
    '          <div ng-repeat="tool in tooling" class="row margin-top">\n' +
    '            <section class="col-sm-3">\n' +
    '              <input type="text" ng-model="tool.toolNbr" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section class="col-sm-1">\n' +
    '              <input type="text" ng-model="tool.qty" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="tool.toolNbr==null" class="col-sm-8">\n' +
    '              <input type="text" ng-model="tool.description" class="form-control"/>\n' +
    '            </section>\n' +
    '            <section ng-show="tool.toolNbr!=null" class="col-sm-8">\n' +
    '              <div class="col-sm-11">\n' +
    '                <input type="text" ng-model="tool.description" class="form-control"/>\n' +
    '              </div>\n' +
    '              <div class="col-sm-1"><i ng-click="deleteItem(tooling, $index)" class="pull-left fa fa-times-circle"></i></div>\n' +
    '            </section>\n' +
    '          </div>\n' +
    '          <div class="col-sm-12 margin-top"><a ng-click="addToolingFields()">+ Add Tool</a></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2><span class="required text-danger">*</span> Prescribed Repair Scheme\n' +
    '          </h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_repair_scheme" class="collapse-section">\n' +
    '        <div class="col-sm-12">\n' +
    '          <textarea name="prescribedRepairScheme" ng-required="true" rows="5" ng-model="roadTrip.repairScheme" maxlength="250" class="form-control">{{roadTrip.repairScheme}}</textarea>\n' +
    '          <div ng-show="roadTripForm.prescribedRepairScheme.$dirty">\n' +
    '            <p ng-show="roadTripForm.prescribedRepairScheme.$error.required" class="small no-bottom-margin text-danger prescribedRepairScheme-required">Prescribed Repair Scheme is required.</p>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Traveler Information<strong>&nbsp;({{travelers.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="traveler_info" collapse="isCollapsed_traveler_info" class="collapse-section">\n' +
    '        <div class="col-sm-12 pull-right margin-bottom">\n' +
    '          <div class="text-left"><i class="fa fa-mail-reply">&nbsp;&nbsp;</i>\n' +
    '            <!--a Employee Lookup--><span g4employee-lookup="g4employee-lookup" model="employeeDirectory" link-text="Employee Directory"></span>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div ng-repeat="person in travelers" class="person">\n' +
    '          <label class="col-sm-2">First Name\n' +
    '            <input type="text" ng-model="person.employee.firstName" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Last Name\n' +
    '            <input type="text" ng-model="person.employee.lastName" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">ID\n' +
    '            <input type="number" ng-model="person.employee.id" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">D.O.B.\n' +
    '            <input type="text" ng-model="person.employee.DOB" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">Base\n' +
    '            <input type="text" ng-model="person.employee.base" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="person.employee.phone" disabled="disabled" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">Gender\n' +
    '            <select ng-model="person.employee.gender" ng-options="gender as gender for gender in genders" disabled="disabled"></select>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div ng-hide="person.travelInfo.hotels.length || person.travelInfo.airlines.length || person.travelInfo.cars.length || !person.employee.id" class="col-sm-12"><i ng-click="deleteItem(travelers, $index)" class="pull-left fa fa-times-circle"></i><small>&nbsp;&nbsp;|&nbsp;&nbsp;</small><a ng-click="add(event.id, $index)">Add Travel Arrangements</a></div>\n' +
    '          <div ng-init="isCollapsed_travel_arrangements=true" class="clearfix"></div>\n' +
    '          <div ng-show="person.travelInfo.hotels.length || person.travelInfo.airlines.length || person.travelInfo.cars.length" class="col-sm-12 margin-bottom"><i ng-click="deleteItem(travelers, $index)" class="pull-left fa fa-times-circle"></i><small>&nbsp;&nbsp;|&nbsp;&nbsp;</small><a ng-show="!isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements">Travel Arrangements -</a><a ng-show="isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements">Travel Arrangements ></a></div>\n' +
    '          <di class="clearfix"></di>\n' +
    '          <div collapse="isCollapsed_travel_arrangements">\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.hotels.length">\n' +
    '                <div ng-repeat="hotel in person.travelInfo.hotels">\n' +
    '                  <div class="col-sm-3 text-left"><span>Hotel:</span><span>{{hotel.name}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span></span><span>{{hotel.address}} {{hotel.city}}, {{hotel.state}} {{hotel.zip}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span>Phone:</span><span>{{hotel.phone}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{hotel.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'hotel\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.hotels.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Hotel:</span><a ng-click="edit(event.id, \'hotel\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.airlines.length">\n' +
    '                <div ng-repeat="airline in person.travelInfo.airlines">\n' +
    '                  <div class="col-sm-3 text-left"><span><strong>Airline:</strong></span><span>{{airline.name}}</span></div>\n' +
    '                  <div class="col-sm-1 text-left"><span></span><span>{{airline.departure.flightNbr}}</span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span><strong>{{airline.departure.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.departure.departUnixTimestamp" event="event"></span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.departure.seat}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.departure.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                  <div class="col-sm-3"></div>\n' +
    '                  <div class="col-sm-1 text-left"><span></span><span>{{airline.arrival.flightNbr}}</span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span><strong>{{airline.arrival.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.arrival.arriveUnixTimestamp" event="event"></span></div>\n' +
    '                  <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.arrival.seat}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.arrival.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'airline\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.airlines.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Airline:</span><a ng-click="edit(event.id, \'airline\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="travel_arrangement">\n' +
    '              <div ng-show="person.travelInfo.cars.length">\n' +
    '                <div ng-repeat="car in person.travelInfo.cars">\n' +
    '                  <div class="col-sm-3 text-left"><span>Car:</span><span>{{car.name}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span></span><span>{{car.address}} {{car.city}}, {{car.state}} {{car.zip}}</span></div>\n' +
    '                  <div class="col-sm-3 text-left"><span>Phone:</span><span>{{car.phone}}</span></div>\n' +
    '                  <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{car.confNbr}}</span></div>\n' +
    '                  <div class="clearfix"></div>\n' +
    '                </div>\n' +
    '                <div class="clearfix"><a ng-click="edit(event.id, \'car\', $index)" class="col-sm-2">Edit</a></div>\n' +
    '              </div>\n' +
    '              <div ng-hide="person.travelInfo.cars.length">\n' +
    '                <div class="col-sm-3 text-left"><span>Car:</span><a ng-click="edit(event.id, \'car\', $index)">Add</a></div>\n' +
    '                <div class="clearfix"></div>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-12 margin-top-large"><span g4employee-lookup="g4employee-lookup" model="employeeDirectory" link-text="+ Add Traveler"></span>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Station Information</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="station_info" collapse="isCollapsed_station_info" class="collapse-section">\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> Manager First Name\n' +
    '          <input name="managerFirstName" ng-required="true" type="text" ng-model="roadTrip.stationManager.firstName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerFirstName.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerFirstName.$error.required" class="small no-bottom-margin text-danger managerFirstName-required">Manager First Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> Manager Last Name\n' +
    '          <input name="managerLastName" ng-required="true" type="text" ng-model="roadTrip.stationManager.lastName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerLastName.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerLastName.$error.required" class="small no-bottom-margin text-danger managerLastName-required">Manager Last Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '          <input name="managerPhone" ng-required="true" type="text" ng-model="roadTrip.stationManager.phone" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.managerPhone.$dirty">\n' +
    '            <p ng-show="roadTripForm.managerPhone.$error.required" class="small no-bottom-margin text-danger managerPhone-required">Phone is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> On-Call First Name\n' +
    '          <input name="onCallFirstName" ng-required="true" type="text" ng-model="roadTrip.stationOnCall.firstName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallFirstName.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallFirstName.$error.required" class="small no-bottom-margin text-danger onCallFirstName-required">On-Call First Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> On-Call Last Name\n' +
    '          <input name="onCallLastName" ng-required="true" type="text" ng-model="roadTrip.stationOnCall.lastName" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallLastName.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallLastName.$error.required" class="small no-bottom-margin text-danger onCallLastName-required">On-Call Last Name is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '          <input name="onCallPhone" ng-required="true" type="text" ng-model="roadTrip.stationOnCall.phone" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.onCallPhone.$dirty">\n' +
    '            <p ng-show="roadTripForm.onCallPhone.$error.required" class="small no-bottom-margin text-danger onCallPhone-required">Phone is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <label class="col-sm-4"><span class="required text-danger">*</span> Address\n' +
    '          <input name="stationAddress" ng-required="true" type="text" ng-model="roadTrip.stationManager.address" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationAddress.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationAddress.$error.required" class="small no-bottom-margin text-danger stationAddress-required"> Address is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-3"><span class="required text-danger">*</span> City\n' +
    '          <input name="stationCity" ng-required="true" type="text" ng-model="roadTrip.stationManager.city" maxlength="25" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationCity.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationCity.$error.required" class="small no-bottom-margin text-danger stationCity-required"> City is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <label class="col-sm-1"><span class="required text-danger">*</span> State\n' +
    '          <select name="stationState" ng-required="true" ng-model="roadTrip.stationManager.state">\n' +
    '            <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            <div ng-show="roadTripForm.stationState.$dirty">\n' +
    '              <p ng-show="roadTripForm.stationState.$error.required" class="small no-bottom-margin text-danger stationState-required"> State is required.</p>\n' +
    '            </div>\n' +
    '          </select>\n' +
    '        </label>\n' +
    '        <label class="col-sm-2"><span class="required text-danger">*</span> Zipcode\n' +
    '          <input name="stationZipcode" ng-required="true" type="text" ng-model="roadTrip.stationManager.zip" maxlength="5" class="form-control"/>\n' +
    '          <div ng-show="roadTripForm.stationZipcode.$dirty">\n' +
    '            <p ng-show="roadTripForm.stationZipcode.$error.required" class="small no-bottom-margin text-danger stationZipcode-required"> Zipcode is required.</p>\n' +
    '          </div>\n' +
    '        </label>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>On-Call Maintenance Vendor Information<strong>&nbsp;({{vendors.length}})</strong></h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div id="vendor_info" collapse="isCollapsed_vendor_info" class="collapse-section">\n' +
    '        <div ng-repeat="vendor in vendors" ng-class="{\'vendor\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(vendors, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4"><span class="required text-danger">*</span> Vendor Name\n' +
    '            <input name="vendorName" ng-required="true" type="text" ng-model="vendor.name" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.vendorName.$dirty">\n' +
    '              <p ng-show="roadTripForm.vendorName.$error.required" class="small no-bottom-margin text-danger vendorName-required">Vendor Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Contract No.\n' +
    '            <input name="contractNo" ng-required="true" type="text" ng-model="vendor.contract" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contractNo.$dirty">\n' +
    '              <p ng-show="roadTripForm.contractNo.$error.required" class="small no-bottom-margin text-danger contractNo-required">Contract No. is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> Contact First Name\n' +
    '            <input name="contactFirstName" ng-required="true" type="text" ng-model="vendor.contactFirstName" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactFirstName.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactFirstName.$error.required" class="small no-bottom-margin text-danger contactFirstName-required">Contact First Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> Contact Last Name\n' +
    '            <input name="contactLastName" ng-required="true" type="text" ng-model="vendor.contactLastName" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactLastName.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactLastName.$error.required" class="small no-bottom-margin text-danger contactLastName-required">Contact Last Name is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Phone\n' +
    '            <input name="contactPhone" ng-required="true" type="text" ng-model="vendor.phone" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactPhone.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactPhone.$error.required" class="small no-bottom-margin text-danger contactPhone-required">Phone is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Fax\n' +
    '            <input name="contactFax" ng-required="true" type="text" ng-model="vendor.fax" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactFax.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactFax.$error.required" class="small no-bottom-margin text-danger contactFax-required">Fax is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4"><span class="required text-danger">*</span> Address\n' +
    '            <input name="contactAddress" ng-required="true" type="text" ng-model="vendor.address" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactAddress.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactAddress.$error.required" class="small no-bottom-margin text-danger contactAddress-required">Address is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3"><span class="required text-danger">*</span> City\n' +
    '            <input name="contactCity" ng-required="true" type="text" ng-model="vendor.city" maxlength="25" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactCity.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactCity.$error.required" class="small no-bottom-margin text-danger contactCity-required">City is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1"><span class="required text-danger">*</span> State\n' +
    '            <select ng-model="vendor.state">\n' +
    '              <option name="contactState" ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '              <div ng-show="roadTripForm.contactState.$dirty">\n' +
    '                <p ng-show="roadTripForm.contactState.$error.required" class="small no-bottom-margin text-danger contactState-required">State is required.</p>\n' +
    '              </div>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2"><span class="required text-danger">*</span> Zipcode\n' +
    '            <input name="contactZipcode" ng-required="true" type="text" ng-model="vendor.zip" maxlength="5" class="form-control"/>\n' +
    '            <div ng-show="roadTripForm.contactZipcode.$dirty">\n' +
    '              <p ng-show="roadTripForm.contactZipcode.$error.required" class="small no-bottom-margin text-danger contactZipcode-required">Zipcode is required.</p>\n' +
    '            </div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addVendorFields()">+ Add Vendor</a>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <fieldset class="margin-top-large padding-bottom-large text-center">\n' +
    '          <button ng-click="cancelRTcreation()" class="btn btn-translucent btn-larger margin-right-large">Cancel</button>\n' +
    '          <button type="submit" id="submit" class="btn btn-solid btn-larger">Save</button>\n' +
    '        </fieldset>\n' +
    '      </div>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/roadtrip/edit_travel.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Road Trip to AOS {{event.flightInfo.currentInfo.flightNbr}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right"></div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="roadtrip_info" class="travel_info">\n' +
    '    <form ng-submit="submit()" class="col-sm-12 border-none">\n' +
    '      <div id="traveler_info" class="collapse-section">\n' +
    '        <div class="col-sm-12 pull-right margin-bottom-large">\n' +
    '          <div class="icon_container col-sm-1"><i class="fa fa-mail-reply"></i></div>\n' +
    '          <div class="col-sm-2 text-left"><a>Egencia Website</a></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="person padding-bottom">\n' +
    '          <div class="col-sm-12">\n' +
    '            <div class="icon_container col-sm-1"><i class="fa fa-user"></i></div>\n' +
    '            <div class="col-sm-2 text-left">\n' +
    '              <h3>{{roadTripTraveler.employee.firstName}} {{roadTripTraveler.employee.lastName}}</h3>\n' +
    '            </div>\n' +
    '            <div class="col-sm-1 text-center"><span>ID:</span><span><strong>{{roadTripTraveler.employee.id}}</strong></span></div>\n' +
    '            <div class="col-sm-3 text-center"><span>Phone:</span><span><strong>{{roadTripTraveler.employee.phone}}</strong></span></div>\n' +
    '            <div class="col-sm-1 text-center"><span>Base:</span><span><strong>{{roadTripTraveler.employee.base}}</strong></span></div>\n' +
    '            <div class="col-sm-3 text-center"><span>D.O.B:</span><span><strong>{{roadTripTraveler.employee.DOB}}</strong></span></div>\n' +
    '            <div class="col-sm-1 text-center"><span>Gender:</span><span><strong>{{roadTripTraveler.employee.gender}}</strong></span></div>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Hotels</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_hotels" ng-click="isCollapsed_hotels = !isCollapsed_hotels" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_hotels" ng-click="isCollapsed_hotels = !isCollapsed_hotels" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div ng-init="isCollapsed_hotels = editType!=\'hotel\' || false" collapse="isCollapsed_hotels" class="collapse-section">\n' +
    '        <div ng-repeat="hotel in hotels" ng-class="{\'hotel\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(hotels, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Hotel Name\n' +
    '            <input type="text" ng-model="hotel.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="hotel.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="hotel.phone" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Address\n' +
    '            <input type="text" ng-model="hotel.address" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3">City\n' +
    '            <input type="text" ng-model="hotel.city" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">State\n' +
    '            <select ng-model="hotel.state">\n' +
    '              <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Zipcode\n' +
    '            <input type="text" ng-model="hotel.zip" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addHotelFields()">+ Add Hotel</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Airlines</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_airlines" ng-click="isCollapsed_airlines = !isCollapsed_airlines" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_airlines" ng-click="isCollapsed_airlines = !isCollapsed_airlines" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div ng-init="isCollapsed_airlines = editType!=\'airline\' || false" collapse="isCollapsed_airlines" class="collapse-section">\n' +
    '        <div ng-repeat="airline in airlines" ng-class="{\'airline\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(airlines, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Airline Name\n' +
    '            <input type="text" ng-model="airline.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div><strong class="margin-top col-sm-6">Departure</strong>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="airline.departure.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Flight Number\n' +
    '            <input type="text" ng-model="airline.departure.flightNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Airport\n' +
    '            <input type="text" ng-model="airline.departure.station" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="col-sm-2 datetimepicker">\n' +
    '            <label>Date\n' +
    '              <div class="input-group">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="dt[airline.id]" is-open="openDate" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event); openDate = !openDate" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <div class="col-sm-2 datetimepicker timepicker">\n' +
    '            <label>Time\n' +
    '              <timepicker ng-model="mytime_dt[airline.id]" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <label class="col-sm-1">Seat\n' +
    '            <input type="text" ng-model="airline.departure.seat" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div><strong class="margin-top col-sm-6">Arrival</strong>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="airline.arrival.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Flight Number\n' +
    '            <input type="text" ng-model="airline.arrival.flightNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Airport\n' +
    '            <input type="text" ng-model="airline.arrival.station" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="col-sm-2 datetimepicker">\n' +
    '            <label>Date\n' +
    '              <div class="input-group">\n' +
    '                <input type="text" show-button-bar="false" show-weeks="false" datepicker-popup="{{format}}" ng-model="at[airline.id]" is-open="openDate2" min-date="minDate" max-date="\'2015-06-22\'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" close-text="Close" class="form-control"/><span class="input-group-btn">\n' +
    '                  <button type="button" ng-click="openDatepicker($event); openDate2 = !openDate2" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>\n' +
    '              </div>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <div class="col-sm-2 datetimepicker timepicker">\n' +
    '            <label>Time\n' +
    '              <timepicker ng-model="mytime_at[airline.id]" ng-change="changed()" show-meridian="false"></timepicker>\n' +
    '            </label>\n' +
    '          </div>\n' +
    '          <label class="col-sm-1">Seat\n' +
    '            <input type="text" ng-model="airline.arrival.seat" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addAirlineFields()">+ Add Airline</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <div class="col-sm-6">\n' +
    '          <h2>Add Cars</h2>\n' +
    '        </div>\n' +
    '        <div class="col-sm-6"><i ng-show="isCollapsed_cars" ng-click="isCollapsed_cars = !isCollapsed_cars" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_cars" ng-click="isCollapsed_cars = !isCollapsed_cars" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div ng-init="isCollapsed_cars = editType!=\'car\' || false" collapse="isCollapsed_cars" class="collapse-section">\n' +
    '        <div ng-repeat="car in cars" ng-class="{\'car\': $index &gt; 0}"><i ng-show="$index &gt; 0" ng-click="deleteItem(cars, $index)" class="pull-right fa fa-times-circle"></i>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Car Name\n' +
    '            <input type="text" ng-model="car.name" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Conf. No.\n' +
    '            <input type="text" ng-model="car.confNbr" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Phone\n' +
    '            <input type="text" ng-model="car.phone" class="form-control"/>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <label class="col-sm-4">Address\n' +
    '            <input type="text" ng-model="car.address" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-3">City\n' +
    '            <input type="text" ng-model="car.city" class="form-control"/>\n' +
    '          </label>\n' +
    '          <label class="col-sm-1">State\n' +
    '            <select ng-model="car.state">\n' +
    '              <option ng-repeat="state in states" value="{{state.abbreviation}}">{{state.abbreviation}}</option>\n' +
    '            </select>\n' +
    '          </label>\n' +
    '          <label class="col-sm-2">Zipcode\n' +
    '            <input type="text" ng-model="car.zip" class="form-control"/>\n' +
    '            <div class="clearfix"></div>\n' +
    '          </label>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <div class="col-sm-12"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top"><a ng-click="addCarFields()">+ Add Car</a></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="border-top">\n' +
    '        <fieldset class="margin-top-large padding-bottom-large text-center">\n' +
    '          <button ng-click="goToPath($event, \'/roadtrip/edit/\' + id)" class="btn btn-translucent btn-larger margin-right-large">Cancel</button>\n' +
    '          <button type="submit" id="submit" class="btn btn-solid btn-larger">Save</button>\n' +
    '        </fieldset>\n' +
    '      </div>\n' +
    '    </form>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/roadtrip/view.jade',
    '\n' +
    '<header>\n' +
    '  <div class="row header_bar">\n' +
    '    <div class="action_btns col-sm-4 text-left"><a ng-click="goToPath($event, \'/view/\' + event.id)" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>AOS Event</span></a></div>\n' +
    '    <div class="row col-sm-4">\n' +
    '      <h1>Road Trip to AOS {{event.tailNbr}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-4 pull-right">\n' +
    '      <div class="btn-group pull-right">\n' +
    '        <button ng-click="openRTDeleteModal()" class="btn btn-action btn-solid btn-default">Close Road Trip</button>\n' +
    '      </div>\n' +
    '      <div class="pull-right">&nbsp;&nbsp;</div>\n' +
    '      <div class="btn-group pull-right">\n' +
    '        <button ng-click="goToPath($event, \'/roadtrip/edit/\' + event.id)" class="btn btn-action btn-solid btn-default">Edit Road Trip</button>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <section id="roadtrip_info">\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>AOG Tracking Details</h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_tracking_details" ng-click="isCollapsed_tracking_details = !isCollapsed_tracking_details" class="pull-right fa fa-angle-up"></i></div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div collapse="isCollapsed_tracking_details" class="collapse-section">\n' +
    '        <div class="col-sm-3"><span>Tail No.:</span>\n' +
    '          <h3>{{event.tailNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-4"><span>AOG Date:</span>\n' +
    '          <h3 g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="event.createdUnixTimestamp" event="event"></h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-3"><span>Flight No.:</span>\n' +
    '          <h3>{{event.flightInfo.routes[2].currentInfo.flightNbr}}</h3>\n' +
    '        </div>\n' +
    '        <div class="col-sm-2"><span>Station:</span>\n' +
    '          <h3>{{event.station.toUpperCase()}}</h3>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <div class="col-sm-12 margin-top-large margin-bottom-large"><span>Reason:</span>\n' +
    '          <p ng-show="event.description!=\'\'">{{event.description}}</p>\n' +
    '          <p ng-show="event.description==\'\'">No description has been added to this event.</p>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top-large margin-bottom"></div>\n' +
    '        <div class="col-sm-3"><span>ATA Code:</span><span><strong ng-repeat="code in event.ataCode">{{code.chapter}}{{code.section}}</strong></span></div>\n' +
    '        <div class="col-sm-5"><span>Description:</span><span><strong>Air Conditioning and Pressurization</strong></span></div>\n' +
    '        <div class="col-sm-4"><span>Inspector Req:</span><span><strong>{{roadTrip.inspectionRequired}}</strong></span></div>\n' +
    '        <div class="clearfix margin-top-large"></div>\n' +
    '        <div class="col-sm-12 margin-top"><span>Special Equiptment Requirements:</span>\n' +
    '          <p ng-show="roadTrip.specialEquipmentReqs!=undefined">{{roadTrip.specialEquipmentReqs}}</p>\n' +
    '          <p ng-show="roadTrip.specialEquipmentReqs==undefined">No equiptment requirements have been added to this road trip.</p>\n' +
    '        </div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>Parts<strong ng-show="roadTrip.parts.length&gt;0">&nbsp;({{roadTrip.parts.length}})</strong></h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_parts" ng-click="isCollapsed_parts = !isCollapsed_parts" class="pull-right fa fa-angle-up"></i></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '    <div collapse="isCollapsed_parts" class="collapse-section">\n' +
    '      <div ng-show="roadTrip.parts.length&gt;0" ng-repeat="part in roadTrip.parts" class="clearfix">\n' +
    '        <div class="col-sm-2"><span>Qty:</span><span><strong>{{part.qty}}</strong></span></div>\n' +
    '        <div class="col-sm-3"><span>Part No.:</span><span><strong>{{part.partNbr}}</strong></span></div>\n' +
    '        <div class="col-sm-7"><span>Description:</span><span><strong>{{part.description}}</strong></span></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div ng-show="roadTrip.parts.length==0" class="col-sm-12">\n' +
    '        <p>No parts have been added to this road trip.</p>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <div class="col-sm-12">\n' +
    '        <h2>Tooling<strong ng-show="roadTrip.tooling.length&gt;0">&nbsp;({{roadTrip.tooling.length}})</strong></h2>\n' +
    '      </div>\n' +
    '      <div ng-show="roadTrip.tooling.length&gt;0" ng-repeat="tool in roadTrip.tooling" class="clearfix">\n' +
    '        <div class="col-sm-2"><span>Qty:</span><span><strong>1</strong></span></div>\n' +
    '        <div class="col-sm-3"><span>Part No.:</span><span><strong>{{tool.toolNbr}}</strong></span></div>\n' +
    '        <div class="col-sm-7"><span>Description:</span><span><strong>{{tool.description}}</strong></span></div>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div ng-show="roadTrip.tooling.length==0" class="col-sm-12">\n' +
    '        <p>No tools have been added to this road trip.</p>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '    </div>\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>Prescribed Repair Scheme</h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_repair_scheme" ng-click="isCollapsed_repair_scheme = !isCollapsed_repair_scheme" class="pull-right fa fa-angle-up"></i></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '    <div collapse="isCollapsed_repair_scheme" class="collapse-section">\n' +
    '      <div class="col-sm-12">\n' +
    '        <p ng-show="roadTrip.repairScheme!=undefined">{{roadTrip.repairScheme}}</p>\n' +
    '        <p ng-show="roadTrip.repairScheme==undefined">No repair scheme has been added to this road trip.</p>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '    </div>\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>Traveler Information<strong ng-show="roadTrip.roadTripTraveler.length&gt;0">&nbsp;({{roadTrip.roadTripTraveler.length}})</strong></h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_traveler_info" ng-click="isCollapsed_traveler_info = !isCollapsed_traveler_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '    <div id="traveler_info" collapse="isCollapsed_traveler_info" class="collapse-section">\n' +
    '      <div class="col-sm-12 pull-right margin-bottom-large">\n' +
    '        <div class="icon_container col-sm-1"><i class="fa fa-mail-reply"></i></div>\n' +
    '        <div class="col-sm-3 text-left"><a href="http://www.globalcrewlogistics.com/" target="_blank">Global Crew Logistics Website</a></div>\n' +
    '      </div>\n' +
    '      <div ng-repeat="person in roadTrip.roadTripTraveler" class="person">\n' +
    '        <div class="col-sm-12">\n' +
    '          <div class="icon_container col-sm-1"><i class="fa fa-user"></i></div>\n' +
    '          <div class="col-sm-2 text-left">\n' +
    '            <h3>{{person.employee.firstName}} {{person.employee.lastName}}</h3>\n' +
    '          </div>\n' +
    '          <div class="col-sm-1 text-center"><span>ID:</span><span><strong>{{person.employee.id}}</strong></span></div>\n' +
    '          <div class="col-sm-3 text-center"><span>Phone:</span><span><strong>{{person.employee.phone}}</strong></span></div>\n' +
    '          <div class="col-sm-1 text-center"><span>Base:</span><span><strong>{{person.employee.base}}</strong></span></div>\n' +
    '          <div class="col-sm-3 text-center"><span>D.O.B:</span><span><strong>{{person.employee.DOB}}</strong></span></div>\n' +
    '          <div class="col-sm-1 text-center"><span>Gender:</span><span><strong>{{person.employee.gender}}</strong></span></div>\n' +
    '        </div>\n' +
    '        <div ng-show="person.travelInfo.hotel.length || person.travelInfo.airline.length || person.travelInfo.car.length" class="col-sm-12 pull-right">\n' +
    '          <div ng-init="isCollapsed_travel_arrangements=true" class="icon_container col-sm-1"></div><a ng-show="!isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements" class="col-sm-2">Travel Arrangements -</a><a ng-show="isCollapsed_travel_arrangements" ng-click="isCollapsed_travel_arrangements = !isCollapsed_travel_arrangements" class="col-sm-2">Travel Arrangements ></a>\n' +
    '        </div>\n' +
    '        <div class="clearfix margin-top"></div>\n' +
    '        <div collapse="isCollapsed_travel_arrangements" class="margin-top">\n' +
    '          <div ng-show="person.travelInfo.hotel.length" class="col-sm-12 travel_arrangement">\n' +
    '            <div ng-repeat="hotel in person.travelInfo.hotel">\n' +
    '              <div class="icon_container col-sm-1"></div>\n' +
    '              <div class="col-sm-3 text-left"><span><strong>Hotel:</strong></span><span>{{hotel.name}}</span></div>\n' +
    '              <div class="col-sm-3 text-left"><span></span><span>{{hotel.address}} {{hotel.city}}, {{hotel.state}} {{hotel.zip}}</span></div>\n' +
    '              <div class="col-sm-3 text-center"><span>Phone:</span><span>{{hotel.phone}}</span></div>\n' +
    '              <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{hotel.confNbr}}</span></div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <!--div.clearfix-->\n' +
    '            <!--  div.icon_container.col-sm-1-->\n' +
    '            <!--  a.col-sm-2 Edit-->\n' +
    '          </div>\n' +
    '          <div ng-show="person.travelInfo.airline.length" class="col-sm-12 travel_arrangement">\n' +
    '            <div ng-repeat="airline in person.travelInfo.airline">\n' +
    '              <div class="icon_container col-sm-1"></div>\n' +
    '              <div class="col-sm-3 text-left"><span><strong>Airline:</strong></span><span>{{airline.name}}</span></div>\n' +
    '              <div class="col-sm-1 text-left"><span></span><span>{{airline.departure.flightNbr}}</span></div>\n' +
    '              <div class="col-sm-2 text-left"><span><strong>{{airline.departure.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.departure.departUnixTimestamp" event="event"></span></div>\n' +
    '              <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.departure.seat}}</span></div>\n' +
    '              <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.departure.confNbr}}</span></div>\n' +
    '              <div class="clearfix"></div>\n' +
    '              <div class="icon_container col-sm-1"></div>\n' +
    '              <div class="col-sm-3"></div>\n' +
    '              <div class="col-sm-1 text-left"><span></span><span>{{airline.arrival.flightNbr}}</span></div>\n' +
    '              <div class="col-sm-2 text-left"><span><strong>{{airline.arrival.station}}</strong></span><span g4-unix-timestamp-converter="" formatting="MM/DD/YYYY HH:mm" duration-or-conversion="conversion" timestamp="airline.arrival.arriveUnixTimestamp" event="event"></span></div>\n' +
    '              <div class="col-sm-2 text-left"><span>Seat:</span><span>{{airline.arrival.seat}}</span></div>\n' +
    '              <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{airline.arrival.confNbr}}</span></div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <!--div.clearfix-->\n' +
    '            <!--  div.icon_container.col-sm-1-->\n' +
    '            <!--  a.col-sm-2 Edit-->\n' +
    '          </div>\n' +
    '          <div ng-show="person.travelInfo.car.length" class="col-sm-12 travel_arrangement">\n' +
    '            <div ng-repeat="car in person.travelInfo.car">\n' +
    '              <div class="icon_container col-sm-1"></div>\n' +
    '              <div class="col-sm-3 text-left"><span><strong>Car:</strong></span><span>{{car.name}}</span></div>\n' +
    '              <div class="col-sm-3 text-left"><span></span><span>{{car.address}} {{car.city}}, {{car.state}} {{car.zip}}</span></div>\n' +
    '              <div class="col-sm-3 text-center"><span>Phone:</span><span>{{car.phone}}</span></div>\n' +
    '              <div class="col-sm-2 text-right"><span>Conf. No.:</span><span>{{car.confNbr}}</span></div>\n' +
    '              <div class="clearfix"></div>\n' +
    '            </div>\n' +
    '            <!--div.clearfix-->\n' +
    '            <!--  div.icon_container.col-sm-1-->\n' +
    '            <!--  a.col-sm-2 Edit-->\n' +
    '          </div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>Station Information</h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_station_info" ng-click="isCollapsed_station_info = !isCollapsed_station_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '    <div collapse="isCollapsed_station_info" class="collapse-section">\n' +
    '      <div class="col-sm-4"><span>Manager:</span><span><strong>{{roadTrip.stationManager.firstName}} {{roadTrip.stationManager.lastName}}</strong></span>\n' +
    '        <div class="clearfix"></div><span>Address:</span><span><strong>{{roadTrip.stationManager.address}} {{roadTrip.stationManager.city}}, {{roadTrip.stationManager.state}} {{roadTrip.stationManager.zip}}</strong></span>\n' +
    '        <div class="clearfix"></div>\n' +
    '      </div>\n' +
    '      <div class="col-sm-3"><span>Phone:</span><span><strong>{{roadTrip.stationManager.phone}}</strong></span></div>\n' +
    '      <div class="col-sm-2"><span>On Call:</span><span><strong>{{roadTrip.stationOnCall.firstName}} {{roadTrip.stationOnCall.lastName}}</strong></span></div>\n' +
    '      <div class="col-sm-3"><span>Phone:</span><span><strong>{{roadTrip.stationOnCall.phone}}</strong></span></div>\n' +
    '      <div class="clearfix"></div>\n' +
    '    </div>\n' +
    '    <div class="border-top">\n' +
    '      <div class="col-sm-6">\n' +
    '        <h2>On-Call Maintenance Vendor Information</h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-6"><i ng-show="isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-down"></i><i ng-show="!isCollapsed_vendor_info" ng-click="isCollapsed_vendor_info = !isCollapsed_vendor_info" class="pull-right fa fa-angle-up"></i></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix"></div>\n' +
    '    <div collapse="isCollapsed_vendor_info" class="collapse-section">\n' +
    '      <div ng-repeat="vendor in vendors">\n' +
    '        <div class="col-sm-4"><span>Name:</span><span><strong>{{vendor.name}}</strong></span>\n' +
    '          <div class="clearfix"></div><span>Address:</span><span><strong>{{vendor.address}} {{vendor.city}}, {{vendor.state}} {{vendor.zip}}</strong></span>\n' +
    '          <div class="clearfix"></div><span>Contract No.:</span><span><strong>{{vendor.contract}}</strong></span>\n' +
    '        </div>\n' +
    '        <div class="col-sm-3"><span>Contact:</span><span><strong>{{vendor.contactFirstName}} {{vendor.contactLastName}}</strong></span></div>\n' +
    '        <div class="col-sm-3"><span>Phone:</span><span><strong>{{vendor.phone}}</strong></span></div>\n' +
    '        <div class="col-sm-2"><span>Fax:</span><span><strong>{{vendor.fax}}</strong></span></div>\n' +
    '        <div class="clearfix margin-bottom"></div>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/view/view.jade',
    '\n' +
    '<header>\n' +
    '  <div ng-class="event.eventCode" class="row header_bar">\n' +
    '    <div class="action_btns col-sm-3 text-left"><a ng-click="goToPath($event, \'/dashboard\')" class="active"><i class="fa fa-angle-left">&nbsp;&nbsp;</i><span>Dashboard</span></a></div>\n' +
    '    <div class="row col-sm-6">\n' +
    '      <h1>{{event.eventCode.toUpperCase()}}</h1>\n' +
    '    </div>\n' +
    '    <div class="action_btns col-sm-3 pull-right">\n' +
    '      <div class="btn-group pull-right">\n' +
    '        <button ng-click="openDeleteModal()" class="btn btn-action btn-translucent btn-default">Return to Service</button>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div id="content_body" class="row">\n' +
    '  <p flash-message="flash-message" message="flashMessage"></p>\n' +
    '  <section id="view_info" class="padding-bottom-large">\n' +
    '    <div class="col-sm-3">\n' +
    '      <div class="img_container view_thumb pull-right"><img src="http://kmph.images.worldnow.com/images/23491452_BG1.jpg"/></div>\n' +
    '    </div>\n' +
    '    <div class="col-sm-6 font-16">\n' +
    '      <div class="col-sm-5 view_tail">\n' +
    '        <h1>{{event.tailNbr}}</h1>\n' +
    '      </div>\n' +
    '      <div class="col-sm-7">\n' +
    '        <h1>{{event.station.name.toUpperCase()}}  /&nbsp;<span class="gate">{{event.location}}</span></h1>\n' +
    '      </div>\n' +
    '      <div class="clearfix"></div>\n' +
    '      <p>{{event.description}}</p>\n' +
    '    </div>\n' +
    '    <div class="col-sm-2 pull-right">\n' +
    '      <div class="col-sm-4"><a ng-click="goToPath($event, \'/edit/\' + event.id)" class="active"><i class="fa fa-edit">&nbsp;&nbsp;Edit</i></a></div>\n' +
    '      <div class="col-sm-4"><a ng-click="" class="active margin-left"><i class="fa fa-print">&nbsp;&nbsp;Print</i></a></div>\n' +
    '    </div>\n' +
    '    <div class="clearfix padding-bottom-large"></div>\n' +
    '    <section class="padding-top-large">\n' +
    '      <div class="col-sm-3">\n' +
    '        <div class="view_icon_set pull-right text-center">\n' +
    '          <div g4-aos-indicators="g4-aos-indicators" list-data="event" class="indicator-container"></div>\n' +
    '          <div class="clearfix"></div>\n' +
    '          <button ng-show="roadTrip==undefined" ng-click="goToPath($event, \'/roadtrip/add/\'+ event.id)" class="margin-top btn btn-action btn-solid btn-default">+ Road Trip</button>\n' +
    '          <button ng-show="roadTrip!=undefined" ng-click="goToPath($event, \'/roadtrip/view/\' + event.id)" class="margin-top btn btn-action btn-solid btn-default">View Road Trip</button>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="col-sm-3 view_codes">\n' +
    '        <p class="col-sm-5">Event Code:</p>\n' +
    '        <h2><strong class="col-sm-6">{{event.eventCode.toUpperCase()}}</strong></h2>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <p class="col-sm-5">ATA Code:</p>\n' +
    '        <h2><strong ng-repeat="code in event.ataCode" class="col-sm-6">{{code.chapter}}{{code.section}}</strong></h2>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <p class="col-sm-5">Root Cause:</p>\n' +
    '        <h2><strong class="col-sm-6">{{event.rootCause.toUpperCase()}}</strong></h2>\n' +
    '        <div class="clearfix"></div>\n' +
    '        <p class="col-sm-5">Start Time:</p>\n' +
    '        <h2><strong class="col-sm-6"><span g4-unix-timestamp-converter="" formatting="HH:mm" duration-or-conversion="conversion" timestamp="event.createdUnixTimestamp" event="event"></span><span>Z</span></strong></h2>\n' +
    '      </div>\n' +
    '      <div class="col-sm-3">\n' +
    '        <div class="view_flight_info">\n' +
    '          <div class="col-sm-3"><i class="fa fa-plane muted"></i></div>\n' +
    '          <div class="col-sm-9">\n' +
    '            <p>{{event.flightInfo.routes[2].currentInfo.flightNbr}}</p>\n' +
    '            <h2><strong g4-unix-timestamp-converter="" formatting="MM/DD[•]HH:mm" duration-or-conversion="conversion" timestamp="event.flightInfo.routes[0].departureInfo.scheduledDepartureUnixTimestamp" event="event"></strong></h2>\n' +
    '            <p>{{event.status.toUpperCase()}}</p>\n' +
    '            <h2><strong ng-if="event.status.toUpperCase()==\'ADV\'" g4-unix-timestamp-converter="" formatting="MM/DD[•]HH:mm" duration-or-conversion="conversion" timestamp="event.advisoryUnixTimestamp" event="event"></strong><strong ng-if="event.status.toUpperCase()==\'ETR\'" g4-unix-timestamp-converter="" formatting="MM/DD[•]HH:mm" duration-or-conversion="conversion" timestamp="event.etrUnixTimestamp" event="event"></strong></h2>\n' +
    '          </div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '      <div class="col-sm-3">\n' +
    '        <div class="view_etr margin-top-large">\n' +
    '          <div class="col-sm-12"><i class="fa fa-clock-o muted pull-left margin-bottom-large"></i>\n' +
    '            <p g4-unix-timestamp-converter="" formatting="" duration-or-conversion="duration" timestamp="elapsedTime" event="event" class="time"></p>\n' +
    '          </div>\n' +
    '          <div class="clearfix"></div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '    </section>\n' +
    '  </section>\n' +
    '  <div class="clearfix padding-bottom-large"></div>\n' +
    '  <div g4-routing="g4-routing" list-data="event" class="border-top border-bottomdiv"></div>\n' +
    '  <div class="clearfix padding-bottom-large"></div>\n' +
    '  <div id="comments" class="padding-top-large normal">\n' +
    '    <section class="widget">\n' +
    '      <section class="widget-body col-sm-12">\n' +
    '        <div g4-comments="g4-comments" config="commentConfig" template-dir="v2"></div>\n' +
    '      </section>\n' +
    '    </section>\n' +
    '  </div>\n' +
    '  <div class="margin-top"></div>\n' +
    '  <div class="clearfix padding-bottom-large">\n' +
    '    <div class="margin-top"></div>\n' +
    '  </div>\n' +
    '  <div id="view_station_info" class="padding-top-large">\n' +
    '    <section class="widget">\n' +
    '      <section class="widget-body col-sm-12">\n' +
    '        <h2><i class="fa fa-wrench"></i><strong>&nbsp;Station Information</strong></h2>\n' +
    '        <hr/>\n' +
    '        <div class="pull-left">\n' +
    '          <ul>\n' +
    '            <li><strong>Station Name</strong></li>\n' +
    '            <li><span>{{event.station.name.toUpperCase()}}</span></li>\n' +
    '            <li class="clearfix"><strong>Manager Contact Name</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.firstName}} {{event.station.stationManager.lastName}}</span></li>\n' +
    '            <li class="clearfix"><strong>Manager Phone #</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.phone}}</span></li>\n' +
    '            <li class="clearfix"><strong>Address</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.address}} {{event.station.stationManager.city}}, {{event.station.stationManager.state}} {{event.station.stationManager.zip}}</span></li>\n' +
    '            <li></li>\n' +
    '          </ul>\n' +
    '          <div class="margin-top-large"></div>\n' +
    '          <ul>\n' +
    '            <li class="clearfix"><strong>On-call Contact Name</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.firstName}} {{event.station.stationManager.lastName}}</span></li>\n' +
    '            <li class="clearfix"><strong>On-call Phone #</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.phone}}</span></li>\n' +
    '            <li class="clearfix"><strong>Address</strong></li>\n' +
    '            <li><span>{{event.station.stationManager.address}} {{event.station.stationManager.city}}, {{event.station.stationManager.state}} {{event.station.stationManager.zip}}</span></li>\n' +
    '            <li class="clearfix"></li>\n' +
    '          </ul>\n' +
    '        </div>\n' +
    '        <div class="pull-right">\n' +
    '          <ul ng-repeat="vendor in event.station.mxVendor">\n' +
    '            <li><strong>Vendor Name</strong></li>\n' +
    '            <li><span>{{vendor.name}}</span></li>\n' +
    '            <li class="clearfix"><strong>Vendor Contact Name</strong></li>\n' +
    '            <li><span>{{vendor.contactFirstName}} {{vendor.contactLastName}}</span></li>\n' +
    '            <li class="clearfix"><strong>Phone #</strong></li>\n' +
    '            <li><span>{{vendor.phone}}</span></li>\n' +
    '            <li class="clearfix"><strong>Fax #</strong></li>\n' +
    '            <li><span>{{vendor.phone}}</span></li>\n' +
    '            <li class="clearfix"><strong>Contract</strong></li>\n' +
    '            <li><span>{{vendor.contract}}</span></li>\n' +
    '            <li class="clearfix"><strong>Address</strong></li>\n' +
    '            <li><span>{{vendor.address}} {{vendor.city}}, {{vendor.state}} {{vendor.zip}}</span></li>\n' +
    '            <li class="clearfix"></li>\n' +
    '          </ul>\n' +
    '        </div>\n' +
    '      </section>\n' +
    '    </section>\n' +
    '  </div>\n' +
    '  <div class="clearfix padding-bottom-large">\n' +
    '    <div class="margin-top"></div>\n' +
    '  </div>\n' +
    '  <div id="parts" ng-show="event.parts.length &amp;&amp; event.parts[0].id!=null" class="padding-top-large">\n' +
    '    <section class="widget">\n' +
    '      <section class="widget-body col-sm-12">\n' +
    '        <h2><i class="fa fa-wrench"></i><strong>&nbsp;Parts</strong></h2>\n' +
    '        <table class="table-lined border">\n' +
    '          <thead>\n' +
    '            <tr class="header_bar">\n' +
    '              <th class="normal">Part Number</th>\n' +
    '              <th class="normal border-left">QTY</th>\n' +
    '              <th class="normal border-left">Description</th>\n' +
    '              <th class="normal border-left">Status</th>\n' +
    '            </tr>\n' +
    '          </thead>\n' +
    '          <tbody>\n' +
    '            <tr ng-repeat="part in event.parts">\n' +
    '              <td>{{part.part}}</td>\n' +
    '              <td class="border-left">{{part.qty}}</td>\n' +
    '              <td class="border-left">{{part.description}}</td>\n' +
    '              <td class="border-left">{{part.status}}</td>\n' +
    '            </tr>\n' +
    '          </tbody>\n' +
    '        </table>\n' +
    '      </section>\n' +
    '    </section>\n' +
    '  </div>\n' +
    '  <div class="clearfix padding-bottom-large">\n' +
    '    <div class="margin-top"></div>\n' +
    '  </div>\n' +
    '  <div id="tail_history" ng-show="event.versionInfo.length" class="padding-top-large">\n' +
    '    <section class="widget">\n' +
    '      <section class="widget-body col-sm-12">\n' +
    '        <h2><i class="fa fa-plane"></i><strong>&nbsp;Event History</strong></h2>\n' +
    '        <ul class="clearfix border">\n' +
    '          <li class="header_bar">\n' +
    '            <div class="td narrow">\n' +
    '              <h3 class="bold">Status</h3>\n' +
    '            </div>\n' +
    '            <div class="td medium">\n' +
    '              <h3 class="bold">Hours</h3>\n' +
    '            </div>\n' +
    '            <div class="td medium">\n' +
    '              <h3 class="bold">Start Time</h3>\n' +
    '            </div>\n' +
    '            <div class="td wide">\n' +
    '              <h3 class="bold">Time in Status</h3>\n' +
    '            </div>\n' +
    '            <div class="td medium">\n' +
    '              <h3 class="bold">Reporter</h3>\n' +
    '            </div>\n' +
    '            <div class="td wide">\n' +
    '              <h3 class="bold">Description</h3>\n' +
    '            </div><span class="clearfix"></span>\n' +
    '          </li>\n' +
    '          <li ng-repeat="version in event.versionInfo" class="tr">\n' +
    '            <div class="td narrow bold">{{version[0].status.toUpperCase()}}<a ng-init="isCollapsed = true" ng-click="isCollapsed = !isCollapsed" class="pull-right"><i class="fa fa-angle-right {{collapsedIcon(isCollapsed)}}"></i></a></div>\n' +
    '            <div g4-unix-timestamp-converter="" formatting="HH:mm" duration-or-conversion="duration" timestamp="version[0].duration" event="event" class="td medium"></div>\n' +
    '            <div g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="conversion" timestamp="version[0].createdUnixTimestamp" event="event" class="td medium"></div>\n' +
    '            <div class="td wide">\n' +
    '              <progressbar value="version[0].durationPercentage" type="warn" class="progress-striped active"></progressbar>\n' +
    '              <h3 class="margin-none padding-none">{{version[0].durationPercentage}} %</h3>\n' +
    '            </div>\n' +
    '            <div class="td medium">{{version[0].createdBy.fullName}}</div>\n' +
    '            <div class="td wide">{{version[0].description}}</div><span class="clearfix"></span>\n' +
    '            <ol collapse="isCollapsed" class="border-top {{isCollapsed}}">\n' +
    '              <li ng-repeat="item in version" ng-show="version.length &gt; 1" class="tr">\n' +
    '                <div ng-show="$index &gt; 0">\n' +
    '                  <div class="td wide">John Smith</div>\n' +
    '                  <div class="td wider">{{item.description}}</div>\n' +
    '                  <div g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="conversion" timestamp="item.createdUnixTimestamp" event="event" class="td wide"></div><span class="clearfix"></span>\n' +
    '                </div>\n' +
    '              </li>\n' +
    '            </ol>\n' +
    '          </li>\n' +
    '          <li class="clearfix"></li>\n' +
    '        </ul>\n' +
    '      </section>\n' +
    '    </section>\n' +
    '  </div>\n' +
    '  <div class="clearfix padding-bottom-large"></div>\n' +
    '  <div id="uploads">\n' +
    '    <div id="documents_upload" class="padding-top-large col-sm-12">\n' +
    '      <section class="widget">\n' +
    '        <section class="widget-body col-sm-12">\n' +
    '          <h2><i class="fa fa-file-o"></i><strong>&nbsp;Documents</strong>\n' +
    '            <div ng-file-select="onFileSelect($files)" onclick="this.value=null" class="margin-top btn btn-action btn-solid btn-default pull-right btn-upload">+ Document</div>\n' +
    '          </h2>\n' +
    '          <table class="table-lined border-none">\n' +
    '            <tbody>\n' +
    '              <tr ng-repeat="doc in event.documents">\n' +
    '                <td class="border-bottom"><a ng-click="ng-click" href="{{doc.path}}" target="_blank">{{doc.name}}</a><span class="small">&nbsp;&nbsp;|&nbsp;&nbsp;</span><span g4-unix-timestamp-converter="" formatting="MM/DD/YY HH:mm" duration-or-conversion="conversion" timestamp="doc.createdUnixTimestamp" event="event" class="small"></span></td>\n' +
    '                <td class="border-bottom"><a ng-click="ng-click" href="{{doc.path}}" target="_blank" class="pull-right"><i class="fa fa-upload"></i></a></td>\n' +
    '              </tr>\n' +
    '              <tr ng-hide="event.documents">\n' +
    '                <td class="border-bottom">No documents added yet.</td>\n' +
    '              </tr>\n' +
    '            </tbody>\n' +
    '          </table>\n' +
    '        </section>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '    <!--div.padding-top-large.col-sm-5.pull-right#media_upload-->\n' +
    '    <!--  section.widget-->\n' +
    '    <!--    section.widget-body.col-sm-12-->\n' +
    '    <!---->\n' +
    '    <!--      h2-->\n' +
    '    <!--        i.fa.fa-file-->\n' +
    '    <!--        strong &nbsp;Media-->\n' +
    '    <!--        .margin-top.btn.btn-action.btn-solid.btn-default.pull-right.btn-upload(ng-file-select=\'onFileSelect($files)\', onclick=\'this.value=null\')-->\n' +
    '    <!--          | + Media-->\n' +
    '    <!---->\n' +
    '    <!--      table.table-lined.border-none-->\n' +
    '    <!--        tbody-->\n' +
    '    <!--          tr(ng-repeat="doc in event.documents", ng-show="getAttachmentType(doc.path).images")-->\n' +
    '    <!--            td.border-bottom-->\n' +
    '    <!--              a(ng-click, href="{{doc.path}}", target="_blank") {{doc.name}}-->\n' +
    '    <!--            td.border-bottom {{doc.createdUnixTimestamp}}-->\n' +
    '    <!--            td.border-bottom-->\n' +
    '    <!--              a(ng-click, href="{{doc.path}}", target="_blank")-->\n' +
    '    <!--                i.fa.fa-upload-->\n' +
    '    <!--          tr(ng-show="!imagesInMedia")-->\n' +
    '    <!--            td.border-bottom-->\n' +
    '    <!--              | No images added yet.-->\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/ui_flow/g4plus-directives/src/routing.jade',
    '\n' +
    '<div class="activity_routing margin-top carousel">\n' +
    '  <!-- Wrapper for slides-->\n' +
    '  <carousel>\n' +
    '    <slide ng-repeat="flight in flightDays track by $index" active="flight.active" class="aircraft-track-slide">\n' +
    '      <div class="aircraft-track-item">\n' +
    '        <div class="aircraft_track">\n' +
    '          <ul class="flight-events kpi_icons">\n' +
    '            <li ng-repeat="flightEvent in flight track by $index" ng-class="bulletClass($parent.$index, $index)" ng-style="bulletPosition($index, flight.length)" class="flight-event icons_kpi">\n' +
    '              <div class="flight-event__time">{{flightEvent.time}}</div>\n' +
    '              <div class="flight-event__station">{{flightEvent.station}}</div>\n' +
    '            </li>\n' +
    '          </ul>\n' +
    '          <div ng-if="$index==currentFlightIndex"><i tooltip-trigger="mouseenter" tooltip-append-to-body="true" tooltip-placement="bottom" tooltip-html-unsafe="{{live_flight_data}}" ng-style="aircraftPosition(flight.length)" class="icons_aircraft"></i>\n' +
    '            <div ng-style="greenTrackWidth(flight.length)" class="aircraft_track green-aircraft-track"></div>\n' +
    '            <div ng-style="redTrackPosition(flight.length)" class="aircraft_track red-aircraft-track"></div>\n' +
    '          </div>\n' +
    '        </div>\n' +
    '      </div>\n' +
    '    </slide>\n' +
    '  </carousel>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/bootstrap-g4plus/examples.jade',
    '\n' +
    '<header class="page-header">\n' +
    '  <div class="row">\n' +
    '    <div class="col-xs-2"><a class="btn btn-success"><i class="icon-plus">&nbsp;</i>Add Task Card</a></div>\n' +
    '    <h1 class="col-xs-8 text-center"><span>Fleet:</span> Airbus 320 FamilyFleet: Aurbus 320 Family\n' +
    '    </h1>\n' +
    '    <div class="col-xs-2 text-right">\n' +
    '      <div class="btn-group">\n' +
    '        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle">Actions&nbsp;<span class="caret"></span></button>\n' +
    '        <ul class="dropdown-menu no-padding pull-right text-left">\n' +
    '          <li><a href="#"><i class="icon-plus"></i> Add Task Card</a></li>\n' +
    '          <li><a href="#"><i class="icon-question-sign"></i> Help</a></li>\n' +
    '        </ul>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div class="row">\n' +
    '  <section class="widget with-header col-md-12">\n' +
    '    <div class="widget-wrapper">\n' +
    '      <header class="widget-header">\n' +
    '        <h2> Information\n' +
    '        </h2>\n' +
    '      </header>\n' +
    '      <section class="widget-body">\n' +
    '        <form class="form-horizontal clearfix pad-top">\n' +
    '          <fieldset class="col-md-8">\n' +
    '            <div class="form-group">\n' +
    '              <label class="col-md-2">Title:</label>\n' +
    '              <div class="col-md-9">\n' +
    '                <input type="text" class="form-control"/>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="form-group">\n' +
    '              <label class="col-md-2">Category:</label>\n' +
    '              <div class="col-md-4 no-right-padding">\n' +
    '                <div class="input-group"><span class="input-group-addon"><i class="icon-envelope"></i></span>\n' +
    '                  <input type="text" class="form-control"/>\n' +
    '                </div>\n' +
    '              </div>\n' +
    '              <div class="col-md-1 no-left-padding">\n' +
    '                <button class="btn btn-primary"><i class="icon-search"></i> Find\n' +
    '                </button>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="form-group">\n' +
    '              <label class="col-md-2">ATA:</label>\n' +
    '              <div class="col-md-4">\n' +
    '                <input type="text" class="form-control"/>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="form-group">\n' +
    '              <label class="col-md-2">Zones:</label>\n' +
    '              <div class="col-md-9">\n' +
    '                <input type="text" class="form-control"/>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div class="form-group">\n' +
    '              <label class="col-md-2">Panel:</label>\n' +
    '              <div class="col-md-9">\n' +
    '                <input type="text" class="form-control"/>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '          </fieldset>\n' +
    '          <fieldset class="col-md-4">\n' +
    '            <p>Fields on the right.</p>\n' +
    '          </fieldset>\n' +
    '          <fieldset class="col-md-12 form-actions pad-bottom">\n' +
    '            <input type="submit" class="btn btn-success pull-left"/><a href="#" class="btn btn-default pull-left margin-left">Cancel</a>\n' +
    '          </fieldset>\n' +
    '          <fieldset class="col-md-12 form-actions pad-bottom">\n' +
    '            <input type="submit" class="btn btn-success pull-right"/><a href="#" class="btn btn-default pull-right margin-right">Cancel</a>\n' +
    '          </fieldset>\n' +
    '        </form>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '</div>\n' +
    '<div class="row">\n' +
    '  <section class="widget col-md-12">\n' +
    '    <section class="widget-body">\n' +
    '      <p>Nunc eu ullamcorper orci. Quisque eget odio ac lectus vestibulum faucibus eget in metus. In pellentesque faucibus vestibulum. Nulla at nulla justo, eget luctus tortor. Nulla facilisi. Duis aliquet egestas purus in blandit. Curabitur vulputate, ligula lacinia scelerisque tempor, lacus lacus ornare ante, ac egestas est urna sit amet arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed molestie augue sit amet leo consequat posuere. Vestibulum ante ipsum primis in.</p>\n' +
    '    </section>\n' +
    '  </section>\n' +
    '</div>\n' +
    '<div class="row">\n' +
    '  <section class="widget with-header col-md-12">\n' +
    '    <div class="widget-wrapper">\n' +
    '      <header class="widget-header">\n' +
    '        <h2>My Header Two</h2>\n' +
    '      </header>\n' +
    '      <section class="widget-body">\n' +
    '        <p class="col-md-12 pad-top">Nunc eu ullamcorper orci. Quisque eget odio ac lectus vestibulum faucibus eget in metus. In pellentesque faucibus vestibulum. Nulla at nulla justo, eget luctus tortor. Nulla facilisi. Duis aliquet egestas purus in blandit. Curabitur vulputate, ligula lacinia scelerisque tempor, lacus lacus ornare ante, ac egestas est urna sit amet arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed molestie augue sit amet leo consequat posuere. Vestibulum ante ipsum primis in.</p>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '</div>\n' +
    '<header class="page-header">\n' +
    '  <div class="row">\n' +
    '    <h1 class="col-xs-8"> Program Task Cards\n' +
    '    </h1>\n' +
    '    <div class="col-xs-4 text-right">\n' +
    '      <div class="btn-group">\n' +
    '        <button data-toggle="dropdown" class="btn btn-success btn-sm dropdown-toggle">Actions&nbsp;<span class="caret"></span></button>\n' +
    '        <ul class="dropdown-menu no-padding pull-right text-left">\n' +
    '          <li><a href="#"><i class="icon-plus"></i> Add Task Card</a></li>\n' +
    '          <li><a href="#">Help<i class="icon-question-sign"></i> Help</a></li>\n' +
    '        </ul>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</header>\n' +
    '<div class="row">\n' +
    '  <p class="text-muted col-md-12">Example widget without a header.</p>\n' +
    '  <section class="widget col-md-12">\n' +
    '    <div class="widget-wrapper">\n' +
    '      <!--header(class="widget-header")h2 Program Task Cards\n' +
    '      -->\n' +
    '      <section class="widget-body">\n' +
    '        <form class="table-tools form-horizontal row no-left-padding no-right-padding">\n' +
    '          <fieldset>\n' +
    '            <ul class="horizontal col-md-12">\n' +
    '              <li>\n' +
    '                <div class="btn-group text-left">\n' +
    '                  <button data-toggle="dropdown" class="btn btn-default btn-sm dropdown-toggle">Select Fleet&nbsp;<span class="caret"></span></button>\n' +
    '                  <ul class="dropdown-menu no-padding pull-left">\n' +
    '                    <li><a href="#">Fleet 1</a></li>\n' +
    '                    <li><a href="#">Fleet 2</a></li>\n' +
    '                  </ul>\n' +
    '                </div>\n' +
    '              </li>\n' +
    '              <li>\n' +
    '                <select id="items-per-page" class="form-control">\n' +
    '                  <option>10</option>\n' +
    '                  <option>25</option>\n' +
    '                  <option>50</option>\n' +
    '                  <option>100</option>\n' +
    '                </select>&nbsp;\n' +
    '                <label for="items-per-page" class="control-label no-left-padding">Items per page</label>\n' +
    '              </li>\n' +
    '              <li class="pull-right">\n' +
    '                <label for="table-filter" class="control-label text-right">Filter:</label>\n' +
    '                <input id="table-filter" type="text" class="form-control"/>\n' +
    '              </li>\n' +
    '            </ul>\n' +
    '          </fieldset>\n' +
    '        </form>\n' +
    '        <table class="table-lined rounded">\n' +
    '          <thead>\n' +
    '            <tr>\n' +
    '              <th scope="col">A/C Type</th>\n' +
    '              <th scope="col">Chapter</th>\n' +
    '              <th scope="col">Title</th>\n' +
    '              <th scope="col">Effective Date</th>\n' +
    '              <th scope="col">Continue Date</th>\n' +
    '              <th scope="col" class="actions"></th>\n' +
    '            </tr>\n' +
    '          </thead>\n' +
    '          <tbody>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '          </tbody>\n' +
    '        </table>\n' +
    '        <div class="table-tools clearfix">\n' +
    '          <p class="pull-left"><strong>Showing 1 of n Entries</strong></p>\n' +
    '          <ul class="pagination pagination-sm pull-right">\n' +
    '            <li><a href="#">&larr; Prev</a></li>\n' +
    '            <li><a href="#">1</a></li>\n' +
    '            <li><a href="#">2</a></li>\n' +
    '            <li><a href="#">3</a></li>\n' +
    '            <li><a href="#">4</a></li>\n' +
    '            <li><a href="#">Next &rarr;</a></li>\n' +
    '          </ul>\n' +
    '        </div>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '</div>\n' +
    '<div class="row">\n' +
    '  <p class="text-muted col-md-12 no-padding-left">Example widget with a header.</p>\n' +
    '  <section class="widget with-header col-md-10">\n' +
    '    <div class="widget-wrapper">\n' +
    '      <header class="widget-header">\n' +
    '        <h2>Program Task Cards</h2>\n' +
    '      </header>\n' +
    '      <section class="widget-body">\n' +
    '        <form class="table-tools form-horizontal row no-left-padding no-right-padding">\n' +
    '          <fieldset>\n' +
    '            <ul class="horizontal col-md-12">\n' +
    '              <li>\n' +
    '                <div class="btn-group text-left">\n' +
    '                  <button data-toggle="dropdown" class="btn btn-default btn-sm dropdown-toggle">Select Fleet&nbsp;<span class="caret"></span></button>\n' +
    '                  <ul class="dropdown-menu no-padding pull-left">\n' +
    '                    <li><a href="#">Fleet 1</a></li>\n' +
    '                    <li><a href="#">Fleet 2</a></li>\n' +
    '                  </ul>\n' +
    '                </div>\n' +
    '              </li>\n' +
    '              <li>\n' +
    '                <select id="items-per-page" class="form-control">\n' +
    '                  <option>10</option>\n' +
    '                  <option>25</option>\n' +
    '                  <option>50</option>\n' +
    '                  <option>100</option>\n' +
    '                </select>&nbsp;\n' +
    '                <label for="items-per-page" class="control-label no-left-padding">Items per page</label>\n' +
    '              </li>\n' +
    '              <li class="pull-right">\n' +
    '                <label for="table-filter" class="control-label text-right">Filter:</label>\n' +
    '                <input id="table-filter" type="text" class="form-control"/>\n' +
    '              </li>\n' +
    '            </ul>\n' +
    '          </fieldset>\n' +
    '        </form>\n' +
    '        <table class="table-lined">\n' +
    '          <thead>\n' +
    '            <tr>\n' +
    '              <th scope="col">A/C Type</th>\n' +
    '              <th scope="col">Chapter</th>\n' +
    '              <th scope="col">Title</th>\n' +
    '              <th scope="col">Effective Date</th>\n' +
    '              <th scope="col">Continue Date</th>\n' +
    '              <th scope="col" class="actions"></th>\n' +
    '            </tr>\n' +
    '          </thead>\n' +
    '          <tbody>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '          </tbody>\n' +
    '        </table>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '  <section class="widget col-md-6">\n' +
    '    <p class="text-muted col-md-12">Example widget without a header.</p>\n' +
    '    <div class="widget-wrapper">\n' +
    '      <header class="widget-header">\n' +
    '        <h2>Program Task Cards</h2>\n' +
    '      </header>\n' +
    '      <section class="widget-body">\n' +
    '        <table class="table-lined side-table">\n' +
    '          <thead>\n' +
    '            <tr>\n' +
    '              <th scope="col">A/C Type</th>\n' +
    '              <th scope="col">Chapter</th>\n' +
    '              <th scope="col">Title</th>\n' +
    '              <th scope="col">Effective Date</th>\n' +
    '              <th scope="col">Continue Date</th>\n' +
    '              <th scope="col" class="actions"></th>\n' +
    '            </tr>\n' +
    '          </thead>\n' +
    '          <tbody>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '            <tr ng-repeat="card in taskcards">\n' +
    '              <td>{{card.aircraftTypeText||\'All\'}}</td>\n' +
    '              <td>{{card.ataCode}}</td>\n' +
    '              <td>{{card.title}}</td>\n' +
    '              <td>{{card.effectiveDate||\'--\'}}</td>\n' +
    '              <td>{{card.ContinueDate||\'--\'}}</td>\n' +
    '              <td><a href="/ataAdmin/view/{{card.ataCode}}">view &raquo; &nbsp;</a><a href="/ataAdmin/view/{{card.ataCode}}">edit &raquo;</a></td>\n' +
    '            </tr>\n' +
    '          </tbody>\n' +
    '        </table>\n' +
    '      </section>\n' +
    '    </div>\n' +
    '  </section>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-header/header.jade',
    '');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-header/menu.jade',
    '\n' +
    '<div id="menu" ng-controller="MenuCtrl" g4-app-code="g4-app-code"><a id="menu-button" title="G4Plus Menu"><i class="icon-reorder"></i></a>\n' +
    '  <div id="menu-popover" ng-class="recentApps.length ? \'\' : \'narrow-menu\'" class="popover bottom"><span class="arrow"></span>\n' +
    '    <div class="apps col-sm-8 pull-right">\n' +
    '      <div class="page-header clearfix">\n' +
    '        <div class="search pull-left"><a href="javascript:void(0)" ng-click="searchTrigger()"><i class="icon-search"></i></a>\n' +
    '          <form class="hide">\n' +
    '            <input type="text" ng-model="searchTerm" class="form-control ng-override"/><a href="javascript:void(0)" ng-click="searchTrigger()" class="pull-left">Cancel Search</a>\n' +
    '          </form>\n' +
    '        </div>\n' +
    '        <ul class="list-unstyled breadcrumbs clearfix">\n' +
    '          <li><a href="#" class="apps-home">Home</a></li>\n' +
    '        </ul>\n' +
    '      </div>\n' +
    '      <div apps-list="apps-list" trigger="#menu-button" depth="6" back-button=".apps-list .back" home-button=".apps-home" breadcrumbs="{{breadcrumbSelector}}" list-width="387" search-filter="{{searchTerm}}"></div>\n' +
    '    </div>\n' +
    '    <div ng-show="recentApps.length" class="recent col-sm-4">\n' +
    '      <h4>Recent Apps</h4>\n' +
    '      <ul class="list-unstyled">\n' +
    '        <li ng-repeat="app in recentApps"><a href="{{app.path}}" class="normal"><i class="icon-caret-right"></i>{{app.name}}</a></li>\n' +
    '      </ul>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-ata-select-directive/src/ata.modal.jade',
    '\n' +
    '<div class="modal-header">\n' +
    '  <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close"><i class="fa fa-times-circle"></i></button>\n' +
    '  <h1 class="alg-blue">Select ATA Code</h1>\n' +
    '</div>\n' +
    '<div class="modal-body">\n' +
    '  <div ng-if="parentCodes.length == 0">\n' +
    '    <table class="table-lined table-condensed">\n' +
    '      <thead>\n' +
    '        <tr class="header_bar">\n' +
    '          <th class="narrow">Chapter</th>\n' +
    '          <th class="medium">Title</th>\n' +
    '          <th class="narrow"></th>\n' +
    '        </tr>\n' +
    '      </thead>\n' +
    '      <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: \'move-animation\'}">\n' +
    '        <tr>\n' +
    '          <td class="narrow">{{code.id}}</td>\n' +
    '          <td class="medium">{{code.title}}</td>\n' +
    '          <td class="narrow text-right"><a ng-click="getChildCodes(code)">Select</a></td>\n' +
    '        </tr>\n' +
    '      </tbody>\n' +
    '    </table>\n' +
    '  </div>\n' +
    '  <div ng-if="parentCodes.length &gt; 0">\n' +
    '    <div class="btn-group pull-right">\n' +
    '      <button ng-click="getParentCodes()" class="btn btn-action btn-solid btn-default">< Back</button>\n' +
    '    </div>\n' +
    '    <table class="table-lined">\n' +
    '      <thead>\n' +
    '        <tr class="header_bar">\n' +
    '          <th class="narrow">Chapter</th>\n' +
    '          <th class="narrow">Title</th>\n' +
    '          <th class="medium"></th>\n' +
    '        </tr>\n' +
    '      </thead>\n' +
    '      <tbody ng-repeat="code in ataCodes | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize" ng-animate="{move: \'move-animation\'}">\n' +
    '        <tr>\n' +
    '          <td class="narrow">{{code.id}}</td>\n' +
    '          <td class="narrow">{{code.aircraftTypeText}}</td>\n' +
    '          <td class="medium text-left"><a ng-click="getChildCodes(code)">{{code.title}}</a></td>\n' +
    '        </tr>\n' +
    '      </tbody>\n' +
    '    </table>\n' +
    '  </div>\n' +
    '  <div g4-pagination-message="" current-page="pagination.page" page-size="10" total-items="parentATAcodes.length" class="col-md-4"></div>\n' +
    '  <div g4-pagination-navigation="" current-page="pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange" class="col-md-8 no-right-padding"></div>\n' +
    '</div>\n' +
    '<div class="modal-footer no-top-margin white-footer">\n' +
    '  <button ng-click="cancel()" class="btn btn-default pull-right modal-cancel-button">Cancel</button>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-header/settings/settings.jade',
    '\n' +
    '<p>settings jade file</p>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/comment-block.jade',
    '<a ng-transclude="ng-transclude" href="javascript:void(0)" ng-click="config.show.toggle()" ng-if="!config.show.visible"></a>\n' +
    '<div ng-show="config.show.isVisible()" class="comments-container">\n' +
    '  <div class="main">\n' +
    '    <div>\n' +
    '      <button type="button" aria-hiddent="true" ng-click="config.show.toggle()" ng-show="config.show.close" class="close">&times;</button>\n' +
    '      <h1 class="comment-title">Comments</h1>\n' +
    '    </div>\n' +
    '    <div>\n' +
    '      <div ng-show="!notice[0].reply">\n' +
    '        <div flash-message="" message="notice"></div>\n' +
    '      </div>\n' +
    '      <div class="commentable">\n' +
    '        <form novalidate="" name="commentForm" class="comment-form">\n' +
    '          <div class="form-group">\n' +
    '            <label for="comment-box" class="col-sm-1 control-label text-right">Comments</label>\n' +
    '            <div class="col-sm-9">\n' +
    '              <textarea id="comment-box" name="comment_body" cols="150" rows="1" ng-model="body" ng-click="showButtons()" ng-required="true" class="form-control"></textarea>\n' +
    '              <div ng-show="commentForm.comment_body.$dirty &amp;&amp; commentForm.comment_body.$invalid ">\n' +
    '                <p ng-show="commentForm.comment_body.$error.required" class="small no-bottom-margin text-danger"> Comment is required.</p>\n' +
    '              </div>\n' +
    '            </div>\n' +
    '            <div ng-show="config.show.attachments &amp;&amp; showButton" class="attachment-form col-sm-2">\n' +
    '              <div g4-file-upload="" g4-current-file="commentForm.file" g4-current-file-info="commentForm.fileInfo">Attach</div>\n' +
    '              <div ng-show="commentForm.fileInfo.fileName" class="attachment-form__fileinfo"><span title="{{commentForm.fileInfo.fileName}}" class="attachment-form__fileinfo__name">{{commentForm.fileInfo.fileName}}</span></div>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '          <div class="row">\n' +
    '            <div ng-show="showButton" class="col-sm-10 text-right buttons">\n' +
    '              <button ng-click="cancelComment()" type="button" class="btn btn-cancel cancel-comment">Cancel</button>\n' +
    '              <button ng-click="createComment()" ng-disabled="commentForm.$invalid" class="btn btn-primary submit-comment">Add Comment</button>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '        </form>\n' +
    '        <div class="comments-count">{{ total }} comments</div>\n' +
    '        <ul class="comment-list list-unstyled">\n' +
    '          <li id="comment-{{ $index+1 }}" ng-repeat="comment in comments | orderBy: &quot;-dateCreatedTimestamp&quot;" ng-include=" &quot;src/app/g4plus-comments/templates/v1/comment-item.jade&quot; " class="comment-item clearfix"></li>\n' +
    '        </ul>\n' +
    '        <button ng-show="hasMoreItemsToShow()" ng-click="showMoreItems()" class="btn btn-link more-comments">More Comments &hellip;</button>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/comment-item.jade',
    '\n' +
    '<div class="comment-container clearfix">\n' +
    '  <div ng-hide="comment.editing" ng-click="commentReply(comment)" class="comment media">\n' +
    '    <div id="attach_{{comment.id}}" ng-if="comment.attachments.length" class="comment-attachment pull-left"><img src="//placehold.it/80" class="comment-attachment__image media-object"/>\n' +
    '      <div g4-file-info-custom="comment.attachments[0]" templateDir="v1">{{ comment.attachments[0].name }}</div><a href="javascript:void(0)" ng-click="deleteAttachment(comment, &quot;v1&quot;, null); $event.stopPropagation()" ng-show="canDeleteAttachment(comment)" title="Delete attachment" class="comment-attachment__delete">×</a>\n' +
    '    </div>\n' +
    '    <div class="media-body">\n' +
    '      <div class="comment-header clearfix"><small class="pull-left"><span class="comment-number">Comment {{$index + 1}} of {{total}}:&nbsp;</span><span class="comment-author-date"><span class="comment-author">{{comment.creatingUser.fullName}}</span>\n' +
    '            <time class="comment-date">{{ formatDate(comment.dateCreatedTimestamp) }}</time></span></small><small class="comment-replies-count pull-right">\n' +
    '          <ng-pluralize count="comment.replies.length" when="{&quot;0&quot;: &quot;0 Replies&quot;,          &quot;one&quot;: &quot;1 Reply.&quot;,          &quot;other&quot;: &quot;{} Replies&quot;}"></ng-pluralize></small></div>\n' +
    '      <p class="comment-body">{{comment.text}}</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div ng-show="replyNotice[\'comment\'+comment.id][0].reply">\n' +
    '    <div flash-message="flash-message" message="replyNotice[\'comment\'+comment.id]"></div>\n' +
    '  </div>\n' +
    '  <div ng-include=" &quot;src/app/g4plus-comments/templates/v1/comment-reply-form.jade&quot; " ng-show="comment.replying"></div>\n' +
    '  <div ng-include=" &quot;src/app/g4plus-comments/templates/v1/comment-replies-list.jade&quot; " ng-if="comment.replies.length"></div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/comment-replies-list.jade',
    '\n' +
    '<ul class="comment-list list-unstyled comment-replies-list">\n' +
    '  <li ng-repeat="reply in comment.replies | orderBy: &quot;dateCreatedTimestamp&quot;" class="reply-item comment-reply">\n' +
    '    <div class="comment media">\n' +
    '      <div id="attach_{{reply.id}}" ng-if="reply.attachments.length" class="comment-attachment pull-left"><img src="//placehold.it/80" class="comment-attachment__image media-object"/>\n' +
    '        <div g4-file-info-custom="reply.attachments[0]" templateDir="v1">{{ reply.attachments[0].name }}</div><a href="javascript:void(0)" ng-click="deleteAttachment(reply, &quot;v1&quot;, comment)" ng-show="canDeleteAttachment(reply)" title="Delete attachment" class="comment-attachment__delete">×</a>\n' +
    '      </div>\n' +
    '      <div class="media-body">\n' +
    '        <div class="comment-header clearfix"><small class="pull-left"><span class="comment-number">Reply {{$index + 1}} of {{comment.replies.length}}:&nbsp;</span><span class="comment-author-date"><span class="comment-author">{{reply.creatingUser.fullName}}</span>\n' +
    '              <time class="timeago">{{ formatDate(reply.dateCreatedTimestamp) }}</time></span></small></div>\n' +
    '        <p class="comment-body">{{reply.text}}</p>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </li>\n' +
    '</ul>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/comment-reply-form.jade',
    '\n' +
    '<form name="replyForm" class="comment-form comment-reply-form">\n' +
    '  <div class="form-group">\n' +
    '    <label for="reply-box" class="col-sm-1 control-label text-right">Reply</label>\n' +
    '    <div class="col-sm-9">\n' +
    '      <textarea id="reply-box-{{comment.id}}" cols="150" rows="1" ng-model="comment.interact" ng-required="true" name="reply_interact" class="form-control"></textarea>\n' +
    '      <div ng-show="replyForm.reply_interact.$dirty &amp;&amp; replyForm.reply_interact.$invalid">\n' +
    '        <p ng-show="replyForm.reply_interact.$error.required" class="small no-bottom-margin text-danger">Reply is required.</p>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '    <div ng-show="config.show.attachments" class="attachment-form col-sm-2">\n' +
    '      <div g4-file-upload="" g4-current-file="replyForm.file" g4-current-file-info="replyForm.fileInfo">Attach</div>\n' +
    '      <div ng-show="replyForm.fileInfo.fileName" class="attachment-form__fileinfo"><span title="{{replyForm.fileInfo.fileName}}" class="attachment-form__fileinfo__name">{{replyForm.fileInfo.fileName}}</span></div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="row">\n' +
    '    <div class="col-sm-10 text-right buttons">\n' +
    '      <button ng-click="cancelReply(comment, replyForm)" type="button" class="btn btn-cancel cancel-reply">Cancel</button>\n' +
    '      <button ng-click="replyComment(comment, replyForm)" ng-disabled="replyForm.$invalid" class="btn btn-primary">Add Reply</button>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</form>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/delete-attachment.jade',
    '\n' +
    '<div class="modal-header">\n' +
    '  <div ng-show="notice[0].level">\n' +
    '    <div flash-message="" message="notice"></div>\n' +
    '  </div>\n' +
    '  <h1><span class="alg-blue">Delete {{attachment.name}}</span></h1>\n' +
    '</div>\n' +
    '<div class="modal-body">Are you sure you wish to delete {{attachment.name}}?</div>\n' +
    '<div class="modal-footer">\n' +
    '  <button ng-click="deleteAttach()" type="button" class="btn btn-success pull-right">Confirm Delete</button>\n' +
    '  <button ng-click="cancelDelete()" type="button" class="btn btn-default pull-right margin-right">Cancel</button>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v1/show-attachment.jade',
    '\n' +
    '<div><span ng-hide="currentFile.ref" ng-transclude=""></span><span ng-show="currentFile.ref" class="comment-attachment__filename"><a x-ng-href="{{ getDownloadUrl() }}" target="_blank" ng-click="$event.stopPropagation()" class="fa-textlink"><i class="fa fa-file-o"></i><span class="fa-textlink__text">{{ currentFile.name }}</span></a></span></div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/comment-block.jade',
    '<a ng-transclude="ng-transclude" href="javascript:void(0)" ng-click="config.show.toggle()" ng-if="!config.show.isVisible()"></a>\n' +
    '<div ng-show="config.show.isVisible()" ng-class="{\'comments-container--sidebar\': config.show.close}" class="comments-container">\n' +
    '  <div class="main">\n' +
    '    <div>\n' +
    '      <button type="button" aria-hiddent="true" ng-click="config.show.toggle()" ng-show="config.show.close" class="close">&times;</button>\n' +
    '      <h1 class="comment-title"><i class="g4c-icon g4c-title"></i>Comments</h1>\n' +
    '    </div>\n' +
    '    <div>\n' +
    '      <div ng-show="!notice[0].reply">\n' +
    '        <div flash-message="" message="notice"></div>\n' +
    '      </div>\n' +
    '      <div class="commentable">\n' +
    '        <form novalidate="" name="commentForm" class="comment-form">\n' +
    '          <div class="form-group">\n' +
    '            <textarea id="comment-box" name="comment_body" cols="150" rows="1" ng-model="body" ng-click="showButtons()" ng-required="true" placeholder="Add a comment" class="form-control"></textarea>\n' +
    '            <div ng-show="commentForm.comment_body.$dirty &amp;&amp; commentForm.comment_body.$invalid ">\n' +
    '              <p ng-show="commentForm.comment_body.$error.required" class="small no-bottom-margin text-danger"> Comment is required.</p>\n' +
    '            </div>\n' +
    '          </div>\n' +
    '          <div ng-show="showButton" class="form-actions text-right">\n' +
    '            <div ng-show="config.show.attachments &amp;&amp; showButton" class="attachment-form">\n' +
    '              <div g4-file-upload="" g4-current-file="commentForm.file" g4-current-file-info="commentForm.fileInfo">Attach</div>\n' +
    '              <div ng-show="commentForm.fileInfo.fileName" class="attachment-form__fileinfo"><span title="{{commentForm.fileInfo.fileName}}" class="attachment-form__fileinfo__name">{{commentForm.fileInfo.fileName}}</span></div>\n' +
    '            </div>\n' +
    '            <button ng-click="cancelComment()" type="button" class="btn btn-cancel cancel-comment">Cancel</button>\n' +
    '            <button ng-click="createComment()" ng-disabled="commentForm.$invalid" class="btn btn-primary submit-comment">Add Comment</button>\n' +
    '          </div>\n' +
    '        </form>\n' +
    '        <ul class="comment-list list-unstyled">\n' +
    '          <li id="comment-{{ $index+1 }}" ng-class="{&quot;comment-replying&quot;: comment.replying}" ng-repeat="comment in comments | orderBy: &quot;-dateCreatedTimestamp&quot;" ng-include=" &quot;src/app/g4plus-comments/templates/v2/comment-item.jade&quot; " class="comment-item clearfix"></li>\n' +
    '        </ul>\n' +
    '        <button ng-show="hasMoreItemsToShow()" ng-click="showMoreItems()" class="btn btn-link more-comments">More Comments</button>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/comment-item.jade',
    '\n' +
    '<div class="comment-container clearfix">\n' +
    '  <div ng-hide="comment.editing" ng-click="commentReply(comment)" class="comment media">\n' +
    '    <div id="attach_{{comment.id}}" ng-if="comment.attachments.length" class="comment-attachment pull-left"><img src="//placehold.it/80" class="comment-attachment__image media-object"/>\n' +
    '      <div g4-file-info-custom="comment.attachments[0]">{{ comment.attachments[0].name }}</div><a href="javascript:void(0)" ng-click="deleteAttachment(comment, &quot;v2&quot;, null); $event.stopPropagation()" ng-show="canDeleteAttachment(comment)" title="Delete attachment" class="comment-attachment__delete">×</a>\n' +
    '    </div>\n' +
    '    <div class="media-body">\n' +
    '      <div class="comment-header clearfix"><small class="pull-left"><span class="comment-number">Comment {{$index + 1}} of {{total}}:&nbsp;</span><span class="comment-author-date"><span class="comment-author">{{comment.creatingUser.fullName}}</span>\n' +
    '            <time class="comment-date">{{ formatDate(comment.dateCreatedTimestamp) }}</time></span></small></div>\n' +
    '      <p class="comment-body">{{comment.text}}</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div ng-show="replyNotice[\'comment\'+comment.id][0].reply">\n' +
    '    <div flash-message="flash-message" message="replyNotice[\'comment\'+comment.id]"></div>\n' +
    '  </div>\n' +
    '  <div ng-include=" &quot;src/app/g4plus-comments/templates/v2/comment-reply-form.jade&quot; " ng-show="comment.replying"></div>\n' +
    '  <div ng-include=" &quot;src/app/g4plus-comments/templates/v2/comment-replies-list.jade&quot; " ng-if="comment.replies.length"></div>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/comment-replies-list.jade',
    '\n' +
    '<ul class="comment-list list-unstyled comment-replies-list">\n' +
    '  <li ng-repeat="reply in comment.replies | orderBy: &quot;dateCreatedTimestamp&quot;" class="comment-item reply-item comment-reply">\n' +
    '    <div class="comment media">\n' +
    '      <div id="attach_{{reply.id}}" ng-if="reply.attachments.length" class="comment-attachment pull-left"><img src="//placehold.it/80" class="comment-attachment__image media-object"/>\n' +
    '        <div g4-file-info-custom="reply.attachments[0]">{{ reply.attachments[0].name }}</div><a href="javascript:void(0)" ng-click="deleteAttachment(reply, &quot;v2&quot;, comment)" ng-show="canDeleteAttachment(reply)" title="Delete attachment" class="comment-attachment__delete">×</a>\n' +
    '      </div>\n' +
    '      <div class="media-body">\n' +
    '        <div class="comment-header clearfix"><small class="pull-left"><span class="comment-number">Reply {{$index + 1}} of {{comment.replies.length}}:&nbsp;</span><span class="comment-author-date"><span class="comment-author">{{reply.creatingUser.fullName}}</span>\n' +
    '              <time class="timeago">{{ formatDate(reply.dateCreatedTimestamp) }}</time></span></small></div>\n' +
    '        <p class="comment-body">{{reply.text}}</p>\n' +
    '      </div>\n' +
    '    </div>\n' +
    '  </li>\n' +
    '</ul>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/comment-reply-form.jade',
    '\n' +
    '<form name="replyForm" class="comment-form comment-reply-form">\n' +
    '  <div class="form-group">\n' +
    '    <textarea id="reply-box-{{comment.id}}" cols="150" rows="1" ng-model="comment.interact" ng-required="true" name="reply_interact" class="form-control"></textarea>\n' +
    '    <div ng-show="replyForm.reply_interact.$dirty &amp;&amp; replyForm.reply_interact.$invalid">\n' +
    '      <p ng-show="replyForm.reply_interact.$error.required" class="small no-bottom-margin text-danger">Reply is required.</p>\n' +
    '    </div>\n' +
    '  </div>\n' +
    '  <div class="form-actions text-right">\n' +
    '    <div ng-show="config.show.attachments" class="attachment-form">\n' +
    '      <div g4-file-upload="" g4-current-file="replyForm.file" g4-current-file-info="replyForm.fileInfo">Attach</div>\n' +
    '      <div ng-show="replyForm.fileInfo.fileName" class="attachment-form__fileinfo"><span title="{{replyForm.fileInfo.fileName}}" class="attachment-form__fileinfo__name">{{replyForm.fileInfo.fileName}}</span></div>\n' +
    '    </div>\n' +
    '    <button ng-click="cancelReply(comment, replyForm)" type="button" class="btn btn-cancel cancel-reply">Cancel</button>\n' +
    '    <button ng-click="replyComment(comment, replyForm)" ng-disabled="replyForm.$invalid" class="btn btn-primary">Add Reply</button>\n' +
    '  </div>\n' +
    '</form>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/delete-attachment.jade',
    '\n' +
    '<div class="modal-header">\n' +
    '  <div ng-show="notice[0].level">\n' +
    '    <div flash-message="" message="notice"></div>\n' +
    '  </div>\n' +
    '  <h1>Delete {{attachment.name}}</h1>\n' +
    '</div>\n' +
    '<div class="modal-body">Are you sure you wish to delete {{attachment.name}}?</div>\n' +
    '<div class="modal-footer">\n' +
    '  <button ng-click="deleteAttach()" type="button" class="btn btn-success pull-right">Confirm Delete</button>\n' +
    '  <button ng-click="cancelDelete()" type="button" class="btn btn-default pull-right margin-right">Cancel</button>\n' +
    '</div>');
}]);
})();

(function(module) {
try {
  module = angular.module('src.templates');
} catch (e) {
  module = angular.module('src.templates', []);
}
module.run(['$templateCache', function($templateCache) {
  $templateCache.put('src/app/g4plus-comments/templates/v2/show-attachment.jade',
    '\n' +
    '<div><span ng-hide="currentFile.ref" ng-transclude=""></span><span ng-show="currentFile.ref" class="comment-attachment__filename"><a x-ng-href="{{ getDownloadUrl() }}" target="_blank" ng-click="$event.stopPropagation()" class="fa-textlink"><span class="fa-textlink__text">{{ currentFile.name }}</span></a></span></div>');
}]);
})();
