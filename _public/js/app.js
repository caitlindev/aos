(function() {
  "use strict";
  var App, AppCtrl;

  App = angular.module("app", ['ui.router', 'src.templates', 'mx.menu', 'app.list', 'app.dashboard', 'app.view', 'app.add', 'app.edit', 'app.delete', 'app.roadtrip.add', 'app.roadtrip.view', 'app.roadtrip.edit', 'app.roadtrip.edittravel', 'app.roadtrip.addtravel', 'services.events', 'services.roadtrips', 'services.flights', 'services.stations', 'services.list_state', 'services.states', 'services.tailNumbers', 'services.parts', 'services.travel_arrangements', 'g4plus.directives', 'g4plus-date.directive', 'g4plus-date.filter', 'g4plus.sort-button', 'g4plus-loading.directive', 'g4ActionsButton', 'g4plus.autofocus', 'g4plus-super-list', 'g4plus.chart', 'g4plus-mapbox.directive', 'g4plus.ata-select', 'g4plus-comments', 'g4plus-file-upload', 'ui.select2', 'g4plus.employee-lookup']);

  App.config(function($stateProvider, $urlRouterProvider) {
    $stateProvider.state('dashboard', {
      url: '/dashboard',
      templateUrl: 'src/app/ui_flow/dashboard/dashboard.jade',
      controller: 'DashboardCtrl',
      pageTitle: 'Dashboard'
    });
    $stateProvider.state('list', {
      url: '/list?select&page&pageSize&filter_value&filter_option',
      templateUrl: 'src/app/ui_flow/list/list.jade',
      controller: 'ListCtrl'
    });
    $stateProvider.state('view', {
      url: '/view/:id',
      templateUrl: 'src/app/ui_flow/view/view.jade',
      controller: 'ViewCtrl'
    });
    $stateProvider.state('view-param/:id', {
      url: '/view/:id',
      templateUrl: 'src/app/ui_flow/view/view.jade',
      controller: 'ViewCtrl'
    });
    $stateProvider.state('add', {
      url: '/add',
      templateUrl: 'src/app/ui_flow/add/add.jade',
      controller: 'AddCtrl'
    });
    $stateProvider.state('roadtrip/view', {
      url: '/roadtrip/view/:id',
      templateUrl: 'src/app/ui_flow/roadtrip/view.jade',
      controller: 'RoadTripViewCtrl'
    });
    $stateProvider.state('roadtrip/edit', {
      url: '/roadtrip/edit/:id',
      templateUrl: 'src/app/ui_flow/roadtrip/edit.jade',
      controller: 'RoadTripEditCtrl'
    });
    $stateProvider.state('roadtrip/add', {
      url: '/roadtrip/add/:id',
      templateUrl: 'src/app/ui_flow/roadtrip/add.jade',
      controller: 'RoadTripAddCtrl'
    });
    $stateProvider.state('roadtrip/add_travel', {
      url: '/roadtrip/add_travel/:id',
      templateUrl: 'src/app/ui_flow/roadtrip/add_travel.jade',
      controller: 'RoadTripAddTravelCtrl'
    });
    $stateProvider.state('roadtrip/edit_travel', {
      url: '/roadtrip/edit_travel/:id/:editType',
      templateUrl: 'src/app/ui_flow/roadtrip/edit_travel.jade',
      controller: 'RoadTripEditTravelCtrl'
    });
    $stateProvider.state('edit', {
      url: '/edit/:id',
      templateUrl: 'src/app/ui_flow/edit/edit.jade',
      controller: 'EditCtrl'
    });
    return $urlRouterProvider.otherwise('/dashboard');
  });

  App.controller("AppCtrl", AppCtrl = function($scope, $rootScope) {
    $rootScope.appTitle = "AOS Work Control";
    return $scope.$on("$stateChangeSuccess", function(event, toState, toParams, fromState, fromParams) {
      if (angular.isDefined(toState.data) && angular.isDefined(toState.data.pageTitle)) {
        return $scope.pageTitle = toState.data.pageTitle + " | G4Plus";
      }
    });
  });

  App.config(function($httpProvider) {
    if (!$httpProvider.defaults.headers.get) {
      $httpProvider.defaults.headers.get = {};
    }
    return $httpProvider.defaults.headers.get['If-Modified-Since'] = '0';
  });

}).call(this);

(function() {
  var filters;

  filters = angular.module('app.filters', []);

  filters.filter('date', function() {
    return function(input) {
      var digits, parsed;
      if (typeof input === 'string') {
        digits = input.replace(/\D/g, '');
        switch (digits.length) {
          case 8:
            parsed = moment(digits, ['YYYYMMDD', 'MMDDYYYY']);
            break;
          case 6:
            parsed = moment(digits, ['YYMMDD', 'MMDDYY']);
        }
        if (parsed != null ? parsed.isValid() : void 0) {
          return parsed.format('YYYY/MM/DD');
        }
      }
      return input;
    };
  });

}).call(this);

(function() {
  var home;

  home = angular.module("app.home", []);

  home.controller("HomeCtrl", [
    '$scope', function($scope) {
      $scope.pageTitle = "MX Skeleton Project";
      return $scope.foo = "Welcome to the G4Plus Brunch/AngularJS/Jade Skeleton!";
    }
  ]);

}).call(this);

(function() {
  var module;

  module = angular.module('services.alerts', []);

  module.factory('Alerts', function() {
    var message;
    message = "";
    return {
      set: function(mes) {
        return message = mes;
      },
      get: function() {
        return message;
      }
    };
  });

}).call(this);

(function() {
  var add;

  add = angular.module('app.add', []);

  add.controller("AddCtrl", [
    '$scope', '$location', '$modal', 'EventsService', 'FlightsService', 'StationsService', 'ATAService', function($scope, $location, $modal, EventsService, FlightsService, StationsService, ATAService) {
      var _this;
      $scope.currentTime = moment().utc().format('HH:mm a');
      $scope.selectedCodes = [];
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.partsStatus = ['In Stock', 'Out Of Stock', 'On Order'];
      $scope.partSelected = $scope.partsStatus[0];
      $scope.addPartFields = function() {
        return $scope.parts.push({
          id: null,
          part: null,
          qty: null,
          description: null,
          status: null
        });
      };
      if ($scope.parts === void 0) {
        $scope.parts = [
          {
            id: null,
            part: null,
            qty: null,
            description: null,
            status: null
          }, {
            id: null,
            part: null,
            qty: null,
            description: null,
            status: null
          }, {
            id: null,
            part: null,
            qty: null,
            description: null,
            status: null
          }
        ];
      }
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.addToSelectedCodes = function(e, value) {
        if (e.which === 13 || e.which === 1) {
          e.preventDefault();
          return $scope.selectedCodes.push({
            chapter: value.substr(0, 2),
            section: value.substr(2, 2)
          });
        }
      };
      $scope.today = function() {
        $scope.dt = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = null;
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = moment(new Date()).utc().format("YYYY-MM-DD HH:mm");
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = moment(new Date()).utc().format("YYYY-MM-DD HH:mm");
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        event.stopPropagation();
        return $scope.openDate = true;
      };
      _this = this;
      $scope.rootCauseCodeList = [
        {
          id: 0,
          description: 'Select an event code...',
          code: 'A'
        }
      ];
      _this.getEventCodesWs = {
        eventCodeWs: function(id, service) {
          return service.getEventCodes(id, _this.getEventCodesWs.success, _this.getEventCodesWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.eventCodeList = data.items;
          return _this.getRootCauseCodesWs.rootCauseCodeWs(EventsService);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getRootCauseCodesWs = {
        rootCauseCodeWs: function(service) {
          return service.getRootCauseCodes(_this.getRootCauseCodesWs.success, _this.getRootCauseCodesWs.error);
        },
        success: function(data, status, headers, config) {
          var eachRcCodeIds, rcCode, rcCodeIds, tmpRootCauseList, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
          _ref = $scope.eventCodeList;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            rcCodeIds = _ref[_i];
            tmpRootCauseList = [];
            _ref1 = rcCodeIds.rootCauseCodeIds;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              eachRcCodeIds = _ref1[_j];
              _ref2 = data.items;
              for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
                rcCode = _ref2[_k];
                if (eachRcCodeIds.toString() === rcCode.id.toString()) {
                  eachRcCodeIds = rcCode.description;
                  tmpRootCauseList.push({
                    id: rcCode.id,
                    description: eachRcCodeIds,
                    code: rcCode.code
                  });
                }
              }
            }
            _results.push(rcCodeIds.rootCauseCodeIds = tmpRootCauseList);
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventCodesWs.eventCodeWs(2, EventsService);
      $scope.changeRootCauseList = function(code) {
        return $scope.rootCauseCodeList = code.rootCauseCodeIds;
      };
      $scope.ataCodesList = $scope.selectedCodes;
      _this.getTailNbrWs = {
        tailNbrWs: function(service) {
          return service.getFlights(null, _this.getTailNbrWs.success, _this.getTailNbrWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.tailNbrList = data;
        },
        error: function(data, status, headers, config) {
          return console.log('error');
        }
      };
      _this.getTailNbrWs.tailNbrWs(FlightsService);
      $scope.filter_tailNbr = 'Tail Number';
      $scope.changeTailNbrFilter = function(val) {
        return $scope.filter_tailNbr = val;
      };
      _this.getStationsWs = {
        stationsWs: function(service) {
          return service.getStations(_this.getStationsWs.success, _this.getStationsWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.stationsList = data;
          return console.log(data);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStationsWs.stationsWs(StationsService);
      $scope.filter_station = 'Station';
      $scope.changeStationFilter = function(val) {
        return $scope.filter_station = val;
      };
      $scope.filteredParts = function(partsList) {
        var i, newPartsList, part;
        i = 0;
        newPartsList = [];
        while (i < partsList.length) {
          part = partsList[i];
          if (part.part !== null) {
            newPartsList.push(part);
          }
          i++;
        }
        return newPartsList;
      };
      $scope.newEvent = {
        id: null,
        type: "aos",
        tailNbr: null,
        station: null,
        location: null,
        description: null,
        advisoryUnixTimestamp: null,
        etrUnixTimestamp: null,
        eventCode: null,
        rootCause: $scope.rootCauseCodeList[0],
        ataCode: $scope.ataCodesList[0],
        status: null,
        state: "open",
        createdUnixTimestamp: $scope.toMilliseconds(new Date()),
        createdBy: {
          loginId: "caitlin.smith",
          empId: "10593",
          fullName: "Caitlin Smith"
        },
        modifiedUnixTimestamp: null,
        modifiedBy: {
          loginId: "caitlin.smith",
          empId: "10593",
          fullName: "Caitlin Smith"
        },
        parts: [
          {
            id: 1000,
            part: "064-50000 [Series]",
            qty: 4,
            description: "DME-XCVR",
            status: "In Stock"
          }, {
            id: 2000,
            part: "17M903 [Series]",
            qty: 1,
            description: "LCD Monitor Assembly",
            status: "On Order"
          }, {
            id: 3000,
            part: "064-50000 [Series]",
            qty: 1,
            description: "Recorder",
            status: "In Stock"
          }, {
            id: 4000,
            part: "064-50000 [Series]",
            qty: 4,
            description: "Radar Antenna",
            status: "In Stock"
          }
        ],
        roadTrips: [],
        comments: [],
        documents: []
      };
      _this.postEventWs = {
        eventWs: function(service, data) {
          return service.postEvent(data, _this.postEventWs.success, _this.postEventWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/dashboard');
        },
        error: function(data, status, headers, config) {}
      };
      return $scope.submit = function() {
        var etrTime;
        $scope.newEvent.eventCode = $scope.newEvent.eventCode.code;
        $scope.newEvent.rootCause = $scope.newEvent.rootCause.code;
        if ($scope.newEvent.status.toUpperCase() === 'ETR') {
          etrTime = moment($scope.dt).format('ddd ll') + " " + moment($scope.mytime).format('HH:mm:ss');
          $scope.newEvent.etrUnixTimestamp = $scope.toMilliseconds(new Date(etrTime));
          $scope.newEvent.advisoryUnixTimestamp;
        }
        $scope.newEvent.createdUnixTimestamp = $scope.toMilliseconds(new Date());
        $scope.newEvent.ataCode = $scope.selectedCodes;
        return _this.postEventWs.eventWs(EventsService, $scope.newEvent);
      };
    }
  ]);

  add.filter("startFrom", function() {
    return function(input, start) {
      if (input !== void 0) {
        start = +start;
        return input.slice(start);
      }
    };
  });

}).call(this);

(function() {
  var dashboard;

  dashboard = angular.module('app.dashboard', ['ngSanitize', 'ui.bootstrap', 'g4plus.pagination', 'g4plus-date.filter', 'g4plus.sort-button', 'g4ActionsButton', 'g4plus.list-filter']);

  dashboard.controller('DashboardCtrl', [
    '$scope', '$location', '$interval', 'ListState', 'EventsService', 'FlightsService', 'StationsService', 'RoadTripService', function($scope, $location, $interval, ListState, EventsService, FlightsService, StationsService, RoadTripService) {
      var _this;
      $scope.tab = [
        {
          title: "Dashboard",
          active: true
        }, {
          title: "Routing",
          active: false
        }
      ];
      $scope.mapFilters = {
        stations: ['LAS', 'SFB', 'AZA', 'LAX'],
        events: ['AOS', 'SOS', 'HPR', 'SPR']
      };
      $scope.changeRouting = function(isCollapsed, tailNumber) {
        if (isCollapsed === false) {
          $scope.refreshMap = !$scope.refreshMap;
          $scope.tailNumbers = tailNumber;
          return $scope.tab[1].active = true;
        } else {
          return $scope.tailNumbers = false;
        }
      };
      $scope.collapsedIcon = function(isCollapsed) {
        if (isCollapsed === true) {
          return 'fa-angle-right';
        } else {
          return 'fa-angle-down';
        }
      };
      $scope.collapsedSectionIcon = function(isCollapsed) {
        if (isCollapsed === true) {
          return {
            "class": 'fa-plus-square',
            text: 'Show'
          };
        } else {
          return {
            "class": 'fa-minus-square',
            text: 'Hide'
          };
        }
      };
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.filter_station = '';
      $scope.filter_stationList = [];
      $scope.currentStationList = [];
      $scope.changeStationFilter = function(val) {
        var filter, station, _i, _len, _ref, _results;
        filter = val.toUpperCase();
        $scope.filter_stationList = [];
        $scope.filter_station = filter;
        if (filter === 'ALL') {
          $scope.filter_stationList = [];
          return $scope.filter_station = '';
        } else if (filter === "AZA" || filter === "IWA") {
          $scope.filter_stationList.push("AZA", "IWA");
          return $scope.filter_station = "IWA";
        } else if (filter === "WEST") {
          return $scope.filter_stationList.push("AZA", "IWA", "LAS", "LAX", "ENV", "OAK", "BLI", "HNL");
        } else if (filter === "EAST") {
          return $scope.filter_stationList.push("SFB", "PIE", "FLL", "PGD", "MYR");
        } else if (filter === "HVY") {
          return $scope.filter_stationList.push("OKC", "TUS", "SBD");
        } else if (filter === "BASE") {
          return $scope.filter_stationList.push("SFB", "IWA", "AZA", "LAS");
        } else if (filter === "NON") {
          _ref = $scope.currentStationList;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            station = _ref[_i];
            if (station.toUpperCase() !== 'SFB' && station.toUpperCase() !== 'PIE' && station.toUpperCase() !== 'FLL' && station.toUpperCase() !== 'PGD' && station.toUpperCase() !== 'MYR' && station.toUpperCase() !== 'IWA' && station.toUpperCase() !== 'AZA' && station.toUpperCase() !== 'LAS' && station.toUpperCase() !== 'LAX' && station.toUpperCase() !== 'ENV' && station.toUpperCase() !== 'OAK' && station.toUpperCase() !== 'BLI' && station.toUpperCase() !== 'HNL' && station.toUpperCase() !== 'OKC' && station.toUpperCase() !== 'TUS' && station.toUpperCase() !== 'SBD') {
              console.log(station);
              _results.push($scope.filter_stationList.push(station.toUpperCase()));
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        } else {
          return $scope.filter_stationList.push(filter);
        }
      };
      $scope.currentTime = new Date();
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.setElapsedTime = function(event) {
        return event.elapsedTime = moment().unix() - event.createdUnixTimestamp;
      };
      _this = this;
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getRoadTripWs = {
        roadTripWs: function(service) {
          return service.getRoadTrips(_this.getRoadTripWs.success, _this.getRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.roadTripList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getRoadTripWs.roadTripWs(RoadTripService);
      _this.getEventsWs = {
        eventWs: function(service) {
          return service.getEvents(null, _this.getEventsWs.success, _this.getEventsWs.error);
        },
        success: function(data, status, headers, config) {
          var events, eventsKey, flightInfo, flights, flightsKey, roadTrips, roadTripssKey, rtId, rtState, tailNbr;
          events = data;
          flights = $scope.flightList;
          roadTrips = $scope.roadTripList;
          for (eventsKey in events) {
            $scope.currentStationList.push(events[eventsKey].station);
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if (events[eventsKey].tailNbr === tailNbr) {
                events[eventsKey].flightInfo = flightInfo;
              }
            }
            for (roadTripssKey in roadTrips) {
              rtId = roadTrips[roadTripssKey].id.toString();
              rtState = roadTrips[roadTripssKey].state.toString().toUpperCase();
              if (events[eventsKey].id.toString() === rtId && rtState === "OPEN") {
                events[eventsKey].roadTrip = true;
              } else {

              }
            }
          }
          $scope.eventList = events;
          return console.log(events);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventsWs.eventWs(EventsService);
      _this = this;
      _this.getStationsWs = {
        stationsWs: function(service) {
          return service.getStations(_this.getStationsWs.success, _this.getStationsWs.error);
        },
        success: function(data, status, headers, config) {
          var stations, _i, _len, _results;
          _results = [];
          for (_i = 0, _len = data.length; _i < _len; _i++) {
            stations = data[_i];
            _results.push($scope.stationList.push(stations.name));
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      $scope.stationList = [];
      return _this.getStationsWs.stationsWs(StationsService);
    }
  ]);

  dashboard.filter("keepSPRinDashboard", function() {
    return function(items) {
      var currentTime, filteredItems;
      filteredItems = [];
      currentTime = moment().unix();
      return angular.forEach(items, function(item, i) {
        var twelveHours2Sec;
        twelveHours2Sec = 43200;
        if (parseInt(currentTime) - parseInt(item.modifiedUnixTimestamp) < twelveHours2Sec) {
          filteredItems.push(item);
        }
        return items;
      });
    };
  });

  dashboard.filter("filterStations", function() {
    return function(items, filter) {
      var filteredItems;
      filteredItems = [];
      angular.forEach(items, function(item, i) {
        var station;
        station = item.station.toUpperCase();
        if ($.inArray(station, filter) > -1) {
          return filteredItems.push(item);
        }
      });
      if (!filter.length) {
        return items;
      }
      return filteredItems;
    };
  });

}).call(this);

(function() {
  var del;

  del = angular.module('app.delete', []);

  del.controller('DeleteWarningModalCtrl', [
    '$scope', '$modalInstance', function($scope, $modalInstance) {
      return $scope.cancel = function() {
        return $modalInstance.close();
      };
    }
  ]);

  del.controller('DeleteModalCtrl', [
    '$scope', '$state', '$modalInstance', '$location', 'FlashStorage', 'RoadTripService', 'EventsService', 'ev', 'rt', function($scope, $state, $modalInstance, $location, FlashStorage, RoadTripService, EventsService, ev, rt) {
      var _this;
      _this = this;
      _this.updateRoadTripWs = {
        roadTripWs: function(service, data) {
          return service.putRoadTrip(data, _this.updateRoadTripWs.success, _this.updateRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.flashMessage = FlashStorage.set({
            level: 'success',
            status: 200,
            message: 'Road trip has been closed',
            critical: true,
            view: 'list'
          });
          $modalInstance.close(true);
          return $scope.deleteInProgress = false;
        },
        error: function(data, status, headers, config) {
          var _ref;
          $scope.flashMessage = FlashStorage.set({
            level: 'danger',
            status: (typeof response !== "undefined" && response !== null ? response.status : void 0) || 500,
            message: (typeof response !== "undefined" && response !== null ? (_ref = response.data) != null ? _ref.message : void 0 : void 0) || "Could not close road trip",
            critical: true,
            view: 'view'
          });
          return $scope.deleteInProgress = false;
        }
      };
      _this.putEventWs = {
        eventWs: function(service, data) {
          var id;
          id = ev.id;
          return service.putEvent(id, data, _this.putEventWs.success, _this.putEventWs.error);
        },
        success: function(data, status, headers, config) {
          $modalInstance.close(true);
          $scope.deleteInProgress = false;
          return $state.go('view', {
            id: ev.id
          });
        },
        error: function(data, status, headers, config) {
          return $scope.deleteInProgress = false;
        }
      };
      $scope.deleteRT = function() {
        $scope.message = {};
        $scope.deleteInProgress = true;
        $scope.rt = rt;
        $scope.rt.state = 'closed';
        return _this.updateRoadTripWs.roadTripWs(RoadTripService, rt);
      };
      $scope.deleteEvent = function() {
        $scope.message = {};
        $scope.deleteInProgress = true;
        $scope.event = ev;
        console.log($scope.event);
        $scope.event.state = 'closed';
        $scope.event.eventCode = 'spr';
        $scope.event.status = 'rdy';
        $scope.event.station = $scope.event.station.name;
        return _this.putEventWs.eventWs(EventsService, $scope.event);
      };
      return $scope.cancel = function() {
        return $modalInstance.close();
      };
    }
  ]);

}).call(this);

(function() {
  var edit;

  edit = angular.module('app.edit', []);

  edit.controller("EditCtrl", [
    '$scope', '$location', '$modal', '$stateParams', 'EventsService', 'FlightsService', 'StationsService', function($scope, $location, $modal, $stateParams, EventsService, FlightsService, StationsService) {
      var _this;
      $scope.currentTime = moment().utc().format('hh:mm a');
      $scope.selectedCodes = {};
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.partsStatus = ['In Stock', 'Out Of Stock', 'On Order'];
      $scope.partSelected = $scope.partsStatus[0];
      $scope.addPartFields = function() {
        return $scope.parts.push({
          id: null,
          part: null,
          qty: null,
          description: null,
          status: null
        });
      };
      $scope.parts = [
        {
          id: null,
          part: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          part: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          part: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.today = function() {
        $scope.dt = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = null;
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.open = function($event) {
        $event.preventDefault();
        $event.stopPropagation();
        $scope.opened = true;
      };
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.initDate = new Date("2016-15-20");
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = new Date();
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = new Date();
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        event.stopPropagation();
        return $scope.openDate = true;
      };
      _this = this;
      $scope.rootCauseCodeList = [
        {
          id: 0,
          description: 'Select Event Code first...',
          code: 'A'
        }
      ];
      _this.getEventCodesWs = {
        eventCodeWs: function(id, service) {
          return service.getEventCodes(id, _this.getEventCodesWs.success, _this.getEventCodesWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.eventCodeList = data.items;
          return _this.getRootCauseCodesWs.rootCauseCodeWs(EventsService);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getRootCauseCodesWs = {
        rootCauseCodeWs: function(service) {
          return service.getRootCauseCodes(_this.getRootCauseCodesWs.success, _this.getRootCauseCodesWs.error);
        },
        success: function(data, status, headers, config) {
          var eachRcCodeIds, rcCode, rcCodeIds, tmpRootCauseList, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
          _ref = $scope.eventCodeList;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            rcCodeIds = _ref[_i];
            tmpRootCauseList = [];
            _ref1 = rcCodeIds.rootCauseCodeIds;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              eachRcCodeIds = _ref1[_j];
              _ref2 = data.items;
              for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
                rcCode = _ref2[_k];
                if (eachRcCodeIds.toString() === rcCode.id.toString()) {
                  eachRcCodeIds = rcCode.description;
                  tmpRootCauseList.push({
                    id: rcCode.id,
                    description: eachRcCodeIds,
                    code: rcCode.code
                  });
                  if (rcCode.code === $scope.event.rootCause.toUpperCase()) {
                    $scope.event.rootCause = rcCode.code.toLowerCase();
                  }
                }
              }
            }
            rcCodeIds.rootCauseCodeIds = tmpRootCauseList;
            _results.push($scope.changeRootCauseList($scope.event.eventCode));
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventCodesWs.eventCodeWs(2, EventsService);
      $scope.changeRootCauseList = function(code) {
        return $scope.rootCauseCodeList = code.rootCauseCodeIds;
      };
      _this.getTailNbrWs = {
        tailNbrWs: function(service) {
          return service.getFlights(null, _this.getTailNbrWs.success, _this.getTailNbrWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.tailNbrList = data;
        },
        error: function(data, status, headers, config) {
          return console.log('error');
        }
      };
      _this.getTailNbrWs.tailNbrWs(FlightsService);
      _this.getStationsWs = {
        stationsWs: function(service) {
          return service.getStations(_this.getStationsWs.success, _this.getStationsWs.error);
        },
        success: function(data, status, headers, config) {
          var key, _results;
          $scope.stationsList = data;
          _results = [];
          for (key in data) {
            _results.push($scope.stationArray.push(data[key].name.toUpperCase()));
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStationsWs.stationsWs(StationsService);
      $scope.filter_station = 'Station';
      $scope.changeStationFilter = function(val) {
        return $scope.filter_station = val;
      };
      $scope.stationArray = [];
      $(function() {
        return $("#stations").autocomplete({
          source: $scope.stationArray
        });
      });
      _this.getEventWs = {
        eventWs: function(service) {
          var id;
          id = $stateParams.id;
          return service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var code, _i, _len, _ref;
          $scope.event = data;
          _ref = $scope.eventCodeList;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            code = _ref[_i];
            if (code.code.toUpperCase() === $scope.event.eventCode.toUpperCase()) {
              $scope.event.eventCode = code;
              break;
            }
          }
          if (data.ataCode.length > 0) {
            $scope.selectedCodes = data.ataCode;
          }
          if (data.parts.length > 0) {
            $scope.parts = data.parts;
            $scope.dt = moment.unix($scope.event.advisoryUnixTimestamp)._d;
            return $scope.mytime = $scope.dt;
          }
        },
        error: function(data, status, headers, config) {
          return console.log('error');
        }
      };
      _this.getEventWs.eventWs(EventsService);
      _this.putEventWs = {
        eventWs: function(service, data) {
          var id;
          id = $stateParams.id;
          return service.putEvent(id, data, _this.putEventWs.success, _this.putEventWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/view/' + data.id);
        },
        error: function(data, status, headers, config) {}
      };
      return $scope.submit = function() {
        var advisoryTime;
        advisoryTime = moment($scope.dt).format('ddd ll') + " " + moment($scope.mytime).format('hh:mm:ss');
        if ($scope.event.status.toUpperCase() === "ADV") {
          $scope.event.advisoryUnixTimestamp = $scope.toMilliseconds(new Date(advisoryTime));
        } else if ($scope.event.status.toUpperCase() === "ETR") {
          $scope.event.etrUnixTimestamp = $scope.toMilliseconds(new Date(advisoryTime));
        }
        $scope.event.eventCode = $scope.event.eventCode.code;
        $scope.event.rootCause = $scope.event.rootCause.code;
        $scope.event.ataCode = $scope.selectedCodes;
        console.log($scope.event);
        return _this.putEventWs.eventWs(EventsService, $scope.event);
      };
    }
  ]);

  edit.filter("startFrom", function() {
    return function(input, start) {
      if (input !== void 0) {
        start = +start;
        return input.slice(start);
      }
    };
  });

}).call(this);

(function() {
  var list;

  list = angular.module('app.list', ['services.events', 'g4plus.directives']);

  list.controller("ListCtrl", [
    '$scope', '$location', '$state', 'EventsService', 'FlightsService', 'ListState', function($scope, $location, $state, EventsService, FlightsService, ListState) {
      var getEvents;
      $scope.goToPath = function(path) {
        return $location.path(path);
      };
      getEvents = {
        success: function(data, status, headers, config) {},
        error: function(data, status, headers, config) {}
      };
      $scope.updateUrl = function() {
        return $location.url(ListState.getListStateUrl());
      };
      $scope.getParams = function() {
        return ListState.setParams($location.search());
      };
      $scope.updateList = function() {
        return $scope.$broadcast('SuperList:reload');
      };
      $scope.list = [];
      $scope.list_length = 0;
      $scope.superList = {
        service: {
          data: EventsService.getEvents,
          type: 'http',
          loadId: 'tableOptions',
          hasSorting: false,
          hasPagination: false,
          hasFiltering: false
        },
        columns: [
          {
            title: 'Tail',
            field: 'tailNbr',
            sorting: false
          }, {
            title: 'Station',
            field: 'station',
            sorting: false,
            cellClass: 'station'
          }, {
            title: 'Status',
            field: 'status',
            sorting: false,
            cellClass: 'status'
          }, {
            title: 'Event',
            field: 'description',
            sorting: false,
            columnClass: 'medium'
          }, {
            title: 'Event Code',
            field: 'eventCode',
            sorting: false
          }, {
            title: 'ATA',
            field: 'ataCode',
            sorting: false
          }, {
            title: 'Root Cause',
            field: 'rootCause',
            sorting: false
          }, {
            title: 'Reporter',
            field: 'createdBy.fullName',
            sorting: false
          }
        ],
        filters: [
          {
            key: '_all',
            label: 'All',
            visible: true,
            type: 'keyword'
          }, {
            key: 'station',
            label: 'Station',
            visible: true,
            type: 'keyword'
          }, {
            key: 'event',
            label: 'Event',
            visible: true,
            type: 'keyword'
          }, {
            key: 'eventCode',
            label: 'Event Code',
            visible: true,
            type: 'keyword'
          }, {
            key: 'createdUnixTimestamp',
            label: 'Date Created',
            visible: true,
            type: 'keyword'
          }
        ],
        params: ListState.getParams(),
        success: getEvents.success,
        error: getEvents.error,
        updateUrl: $scope.updateUrl
      };
      $scope.getParams();
      return $scope.$on('$routeUpdate', function() {
        $scope.getParams();
        return $scope.updateList();
      });
    }
  ]);

}).call(this);

(function() {
  var roadtripadd;

  roadtripadd = angular.module('app.roadtrip.add', []);

  roadtripadd.controller("RoadTripAddCtrl", [
    '$scope', '$location', '$modal', '$stateParams', '$cookieStore', 'StatesService', 'RoadTripService', 'FlightsService', 'EventsService', 'StationsService', 'TravelArrangementsService', function($scope, $location, $modal, $stateParams, $cookieStore, StatesService, RoadTripService, FlightsService, EventsService, StationsService, TravelArrangementsService) {
      var _this;
      $scope.employeeDirectory = $cookieStore.get('travelers');
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.id = $stateParams.id;
      $scope.genders = ['F', 'M'];
      $scope.dt = [];
      $scope.at = [];
      $scope.today = function() {
        $scope.dt[0] = new Date();
        $scope.at[0] = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = [];
        $scope.at = [];
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.initDate = new Date("2016-15-20");
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = new Date();
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = new Date();
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        return event.stopPropagation();
      };
      $scope.addPartFields = function() {
        return $scope.parts.push({
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        });
      };
      $scope.parts = [
        {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.deleteItem = function(list, index) {
        return list.splice(index, 1);
      };
      $scope.addToolingFields = function() {
        return $scope.tooling.push({
          id: null,
          toolNbr: null,
          qty: null,
          description: null
        });
      };
      $scope.tooling = [
        {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.addTravelerFields = function() {
        return $scope.travelers.push({
          "employee": {
            "firstName": null,
            "lastName": null,
            "id": null,
            "phone": null,
            "base": null,
            "DOB": null,
            "gender": null
          },
          "travelInfo": {
            hotels: null,
            airlines: null,
            cars: null
          }
        });
      };
      if ($cookieStore.get('travelers')) {
        $scope.travelers = $cookieStore.get('travelers');
      } else {
        $scope.travelers = [
          {
            "employee": {
              "firstName": null,
              "lastName": null,
              "id": null,
              "phone": null,
              "base": null,
              "DOB": null,
              "gender": null
            },
            "travelInfo": {
              hotels: null,
              airlines: null,
              cars: null
            }
          }
        ];
      }
      $scope.$watch('employeeDirectory.length', function(newVal, oldVal) {
        var value;
        value = $scope.employeeDirectory;
        if (newVal > 0) {
          $scope.travelers = value;
          return $cookieStore.put('travelers', $scope.travelers);
        }
      });
      $scope.addVendorFields = function() {
        return $scope.vendors.push({
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        });
      };
      $scope.vendors = [
        {
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        }
      ];
      _this = this;
      _this.getStatesWs = {
        statesWs: function(service) {
          return service.getStates(_this.getStatesWs.success, _this.getStatesWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.states = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStatesWs.statesWs(StatesService);
      $scope.openDeleteModal = function() {
        var modalInstance;
        modalInstance = $modal.open({
          controller: "DeleteModalCtrl",
          templateUrl: 'src/app/ui_flow/delete/modal.jade',
          resolve: {
            rt: function() {
              return $scope.roadTrip;
            }
          }
        });
        return modalInstance.result.then(function(flashMessage) {
          return $scope.goToPath({
            which: 13
          }, '/view/' + $scope.roadTrip.id);
        });
      };
      $scope.cancel = function() {
        return $modalInstance.close();
      };
      _this.getStationsWs = {
        stationsWs: function(service) {
          return service.getStations(_this.getStationsWs.success, _this.getStationsWs.error);
        },
        success: function(data, status, headers, config) {
          var stations, _i, _len, _results;
          _results = [];
          for (_i = 0, _len = data.length; _i < _len; _i++) {
            stations = data[_i];
            if (stations.name.toUpperCase() === $scope.event.station.toUpperCase()) {
              $scope.newRoadTrip.station = stations.name;
              $scope.newRoadTrip.stationManager = stations.stationManager;
              $scope.newRoadTrip.stationOnCall = stations.stationOnCall;
              $scope.vendors = stations.mxVendor;
              break;
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getEventWs = {
        eventWs: function(service) {
          return service.getEvent($scope.id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var event;
          event = data;
          $scope.event = event;
          _this.getStationsWs.stationsWs(StationsService);
          return $scope.$watch("flightList", function() {
            var flightInfo, flights, flightsKey, tailNbr;
            flights = $scope.flightList;
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if ($scope.event.tailNbr === tailNbr) {
                $scope.event.flightInfo = flightInfo;
              }
            }
            if ($cookieStore.get('currentRT')) {
              return $scope.newRoadTrip = $cookieStore.get('currentRT');
            } else {
              return $scope.newRoadTrip = {
                "id": $scope.id,
                "state": "open",
                "tailNbr": event.flightInfo.tailNbr,
                "flightNbr": event.flightInfo.routes[2].currentInfo.flightNbr,
                "station": event.station,
                "reason": event.description,
                "ataCodes": event.ataCode,
                "inspectionRequired": null,
                "specialEquipmentReqs": null,
                "remarks": null,
                "createdUnixTimestamp": $scope.toMilliseconds(new Date()),
                "createdBy": {
                  "id": 10195,
                  "aisId": 10195,
                  "companyName": "Allegiant Air, LLC",
                  "company": 20,
                  "name": "Nathan Sculli",
                  "roles": ["dev_sudo"],
                  "image": null,
                  "userType": "Standard User",
                  "employeeGroup": "AD Administration",
                  "department": "686 Information Technology",
                  "email": "nathan.sculli@allegiantair.com"
                },
                "parts": $scope.parts,
                "tooling": $scope.tooling,
                "station": null,
                "stationManager": {
                  "firstName": null,
                  "lastName": null,
                  "phone": null,
                  "address": null,
                  "city": null,
                  "state": null,
                  "zip": null
                },
                "stationOnCall": {
                  "firstName": null,
                  "lastName": null,
                  "phone": null
                },
                "mxVendor": $scope.vendors,
                "repairScheme": null,
                "roadTripTraveler": $scope.travelers
              };
            }
          });
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventWs.eventWs(EventsService);
      _this.postRoadTripWs = {
        roadTripWs: function(service, data) {
          return service.postRoadTrip(data, _this.postRoadTripWs.success, _this.postRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/roadtrip/view/' + $scope.id);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.removeEmpties = function(list, attr, attr2) {
        var i, item, _results;
        i = 0;
        _results = [];
        while (i < list.length) {
          item = list[i];
          if (attr2 === null) {
            if (item[attr] === null || item[attr] === void 0 || item[attr] === '') {
              list.splice(i, 1);
              i--;
            }
          } else {
            if (item[attr][attr2] === null || item[attr][attr2] === void 0 || item[attr][attr2] === '') {
              list.splice(i, 1);
              i--;
            }
          }
          _results.push(i++);
        }
        return _results;
      };
      $scope.edit = function(event_id, eventType, index) {
        $cookieStore.put('travelers', $scope.travelers);
        $cookieStore.put('currentTraveler', {
          traveler: $scope.travelers[index],
          returnURL: $location.path()
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/add_travel/' + event_id);
      };
      $scope.add = function(event_id, index) {
        $cookieStore.put('travelers', $scope.travelers);
        $cookieStore.put('currentRT', $scope.newRoadTrip);
        $cookieStore.put('currentTraveler', {
          traveler: $scope.travelers[index],
          returnURL: $location.path()
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/add_travel/' + event_id);
      };
      $scope.cancelRTcreation = function() {
        $cookieStore.remove('travelers');
        $cookieStore.remove('currentRT');
        $cookieStore.remove('currentTraveler');
        return goToPath({
          which: 13
        }, '/view/' + event.id);
      };
      return $scope.submit = function() {
        $scope.removeEmpties($scope.parts, "partNbr", null);
        $scope.removeEmpties($scope.tooling, "toolNbr", null);
        $scope.removeEmpties($scope.travelers, "employee", "id");
        $scope.removeEmpties($scope.vendors, "name", null);
        $cookieStore.remove('travelers');
        $cookieStore.remove('currentRT');
        $cookieStore.remove('currentTraveler');
        return console.log($scope.newRoadTrip);
      };
    }
  ]);

}).call(this);

(function() {
  var roadtripaddtravel;

  roadtripaddtravel = angular.module('app.roadtrip.addtravel', []);

  roadtripaddtravel.controller("RoadTripAddTravelCtrl", [
    '$scope', '$location', '$modal', '$stateParams', '$cookieStore', 'StatesService', 'RoadTripService', 'FlightsService', 'EventsService', 'TravelArrangementsService', function($scope, $location, $modal, $stateParams, $cookieStore, StatesService, RoadTripService, FlightsService, EventsService, TravelArrangementsService) {
      var _this;
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.id = $stateParams.id;
      $scope.employee_id = $stateParams.employee_id;
      $scope.travelers = $cookieStore.get('travelers');
      $scope.currentTraveler = $cookieStore.get('currentTraveler').traveler;
      $scope.returnURL = $cookieStore.get('currentTraveler').returnURL;
      $scope.dt = [];
      $scope.at = [];
      $scope.today = function() {
        $scope.dt[0] = new Date();
        $scope.at[0] = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = [];
        $scope.at = [];
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.initDate = new Date("2016-15-20");
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = new Date();
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = new Date();
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        return event.stopPropagation();
      };
      $scope.addHotelFields = function() {
        return $scope.currentTraveler.travelInfo.hotels.push({
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        });
      };
      if ($scope.currentTraveler.travelInfo.hotels === void 0) {
        $scope.currentTraveler.travelInfo.hotels = [
          {
            "name": null,
            "address": null,
            "city": null,
            "state": null,
            "zip": null,
            "phone": null,
            "confNbr": null
          }
        ];
      }
      $scope.addAirlineFields = function() {
        $scope.currentTraveler.travelInfo.airlines.push({
          "id": $scope.id_count,
          "name": null,
          "departure": {
            "flightNbr": null,
            "station": null,
            "departUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          },
          "arrival": {
            "flightNbr": null,
            "station": null,
            "arriveUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          }
        });
        return $scope.id_count++;
      };
      if ($scope.currentTraveler.travelInfo.airlines === void 0) {
        $scope.currentTraveler.travelInfo.airlines = [
          {
            "name": null,
            "departure": {
              "flightNbr": null,
              "station": null,
              "departUnixTimestamp": null,
              "seat": null,
              "confNbr": null
            },
            "arrival": {
              "flightNbr": null,
              "station": null,
              "arriveUnixTimestamp": null,
              "seat": null,
              "confNbr": null
            }
          }
        ];
      }
      $scope.addCarFields = function() {
        return $scope.currentTraveler.travelInfo.cars.push({
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        });
      };
      if ($scope.currentTraveler.travelInfo.cars === void 0) {
        $scope.currentTraveler.travelInfo.cars = [
          {
            "name": null,
            "address": null,
            "city": null,
            "state": null,
            "zip": null,
            "phone": null,
            "confNbr": null
          }
        ];
      }
      $scope.deleteItem = function(list, index) {
        return list.splice(index, 1);
      };
      $scope.removeEmpties = function(list, attr, attr2) {
        var i, item, _results;
        i = 0;
        _results = [];
        while (i < list.length) {
          item = list[i];
          if (attr2 === null) {
            if (item[attr] === null || item[attr] === void 0 || item[attr] === '') {
              list.splice(i, 1);
              i--;
            }
          } else {
            if (item[attr][attr2] === null || item[attr][attr2] === void 0 || item[attr][attr2] === '') {
              list.splice(i, 1);
              i--;
            }
          }
          _results.push(i++);
        }
        return _results;
      };
      _this = this;
      _this.getStatesWs = {
        statesWs: function(service) {
          return service.getStates(_this.getStatesWs.success, _this.getStatesWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.states = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStatesWs.statesWs(StatesService);
      $scope.id_count = 1;
      _this.putRoadTripWs = {
        roadTripWs: function(service, data) {
          return service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/roadtrip/view/' + $scope.id);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      return $scope.submit = function() {
        var airlines, arrivalTime, departureTime, i, k, traveler;
        $scope.removeEmpties($scope.currentTraveler.travelInfo.hotels, "name", null);
        $scope.removeEmpties($scope.currentTraveler.travelInfo.airlines, "name", null);
        $scope.removeEmpties($scope.currentTraveler.travelInfo.cars, "name", null);
        i = 0;
        while (i < $scope.travelers.length) {
          traveler = $scope.travelers[i];
          if (traveler.employee.id === $scope.currentTraveler.employee.id) {
            $scope.travelers[i] = $scope.currentTraveler;
          }
          i++;
        }
        $cookieStore.put('travelers', $scope.travelers);
        k = 0;
        airlines = $scope.currentTraveler.travelInfo.airlines;
        while (k < airlines.length) {
          departureTime = moment($scope.dt[k]).format('ddd ll') + " " + moment($scope.mytime_dt).format('hh:mm:ss');
          airlines[k].departure.departUnixTimestamp = $scope.toMilliseconds(new Date(departureTime));
          arrivalTime = moment($scope.at[k]).format('ddd ll') + " " + moment($scope.mytime_at).format('hh:mm:ss');
          airlines[k].arrival.arriveUnixTimestamp = $scope.toMilliseconds(new Date(arrivalTime));
          k++;
        }
        console.log($scope.currentTraveler);
        return $scope.goToPath({
          which: 13
        }, $scope.returnURL);
      };
    }
  ]);

}).call(this);

(function() {
  var roadtripedit;

  roadtripedit = angular.module('app.roadtrip.edit', []);

  roadtripedit.controller("RoadTripEditCtrl", [
    '$scope', '$location', '$modal', '$stateParams', '$cookieStore', 'StatesService', 'RoadTripService', 'FlightsService', 'EventsService', 'TravelArrangementsService', function($scope, $location, $modal, $stateParams, $cookieStore, StatesService, RoadTripService, FlightsService, EventsService, TravelArrangementsService) {
      var _this;
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.id = $stateParams.id;
      $scope.genders = ['F', 'M'];
      $scope.addPartFields = function() {
        return $scope.parts.push({
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        });
      };
      $scope.parts = [
        {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.deleteItem = function(list, index) {
        return list.splice(index, 1);
      };
      $scope.addToolingFields = function() {
        return $scope.tooling.push({
          id: null,
          toolNbr: null,
          qty: null,
          description: null
        });
      };
      $scope.tooling = [
        {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.addTravelerFields = function() {
        return $scope.travelers.push({
          "employee": {
            "firstName": null,
            "lastName": null,
            "id": null,
            "phone": null,
            "base": null,
            "DOB": null,
            "gender": null
          },
          "travelInfo": {}
        });
      };
      $scope.travelers = [
        {
          "employee": {
            "firstName": null,
            "lastName": null,
            "id": null,
            "phone": null,
            "base": null,
            "DOB": null,
            "gender": null
          },
          "travelInfo": {}
        }
      ];
      $scope.addVendorFields = function() {
        return $scope.vendors.push({
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        });
      };
      $scope.vendors = [
        {
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        }
      ];
      _this = this;
      _this.getStatesWs = {
        statesWs: function(service) {
          return service.getStates(_this.getStatesWs.success, _this.getStatesWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.states = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStatesWs.statesWs(StatesService);
      _this.getRoadTripWs = {
        roadTripWs: function(service, id) {
          return service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.roadTrip = data;
          console;
          return $scope.fixData(data);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.fixData = function(data) {
        var addTravel, editTravel;
        if (data.parts.length > 0) {
          $scope.parts = data.parts;
        }
        if (data.tooling.length > 0) {
          $scope.tooling = data.tooling;
        }
        if (data.roadTripTraveler.length > 0) {
          $scope.travelers = data.roadTripTraveler;
        }
        if ($cookieStore.get('addTravel')) {
          addTravel = $cookieStore.get('addTravel');
          $scope.travelers = addTravel.newTraveler;
          console.log($scope.travelers);
          $cookieStore.remove('addTravel');
        }
        if ($cookieStore.get('editTravel')) {
          editTravel = $cookieStore.get('editTravel');
          $scope.travelers = editTravel.newTraveler;
          $cookieStore.remove('editTravel');
        }
        if (data.mxVendor.length > 0) {
          return $scope.vendors = data.mxVendor;
        }
      };
      _this.getRoadTripWs.roadTripWs(RoadTripService, $scope.id);
      $scope.openDeleteModal = function() {
        var modalInstance;
        modalInstance = $modal.open({
          controller: "DeleteModalCtrl",
          templateUrl: 'src/app/ui_flow/delete/modal.jade',
          resolve: {
            rt: function() {
              return $scope.roadTrip;
            }
          }
        });
        return modalInstance.result.then(function(flashMessage) {
          return $scope.goToPath({
            which: 13
          }, '/view/' + $scope.roadTrip.id);
        });
      };
      $scope.cancel = function() {
        return $modalInstance.close();
      };
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getEventWs = {
        eventWs: function(service) {
          return service.getEvent($scope.id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var event;
          event = data;
          $scope.event = event;
          return $scope.$watch("flightList", function() {
            var flightInfo, flights, flightsKey, tailNbr, _results;
            flights = $scope.flightList;
            _results = [];
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if ($scope.event.tailNbr === tailNbr) {
                _results.push($scope.event.flightInfo = flightInfo);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventWs.eventWs(EventsService);
      _this.putRoadTripWs = {
        roadTripWs: function(service, data) {
          return service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/roadtrip/view/' + $scope.id);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.removeEmpties = function(list, attr, attr2) {
        var i, item, _results;
        i = 0;
        _results = [];
        while (i < list.length) {
          item = list[i];
          if (attr2 === null) {
            if (item[attr] === null || item[attr] === void 0 || item[attr] === '') {
              list.splice(i, 1);
              i--;
            }
          } else {
            if (item[attr][attr2] === null || item[attr][attr2] === void 0 || item[attr][attr2] === '') {
              list.splice(i, 1);
              i--;
            }
          }
          _results.push(i++);
        }
        return _results;
      };
      $scope.edit = function(event_id, editType, index) {
        $cookieStore.put('editTravel', {
          "newTraveler": $scope.travelers,
          "path": $location.path(),
          "index": index
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/edit_travel/' + event_id + '/' + editType);
      };
      $scope.add = function(event_id, index) {
        $cookieStore.put('addTravel', {
          "newTraveler": $scope.travelers,
          "path": $location.path(),
          "index": index
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/add_travel/' + event_id);
      };
      return $scope.submit = function() {
        $scope.roadTrip.parts = $scope.parts;
        $scope.roadTrip.tooling = $scope.tooling;
        $scope.roadTrip.roadTripTraveler = $scope.travelers;
        $scope.roadTrip.mxVendor = $scope.vendors;
        $scope.removeEmpties($scope.parts, "partNbr", null);
        $scope.removeEmpties($scope.tooling, "toolNbr", null);
        $scope.removeEmpties($scope.travelers, "employee", "id");
        $scope.removeEmpties($scope.vendors, "name", null);
        return _this.putRoadTripWs.roadTripWs(RoadTripService, $scope.roadTrip);
      };
    }
  ]);

}).call(this);

(function() {
  var roadtripedit;

  roadtripedit = angular.module('app.roadtrip.edit', []);

  roadtripedit.controller("RoadTripEditCtrl", [
    '$scope', '$location', '$modal', '$stateParams', '$cookieStore', 'StatesService', 'RoadTripService', 'FlightsService', 'EventsService', 'StationsService', 'TravelArrangementsService', function($scope, $location, $modal, $stateParams, $cookieStore, StatesService, RoadTripService, FlightsService, EventsService, StationsService, TravelArrangementsService) {
      var _this;
      $scope.employeeDirectory = $cookieStore.get('travelers');
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.id = $stateParams.id;
      $scope.genders = ['F', 'M'];
      $scope.dt = [];
      $scope.at = [];
      $scope.today = function() {
        $scope.dt[0] = new Date();
        $scope.at[0] = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = [];
        $scope.at = [];
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.initDate = new Date("2016-15-20");
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = new Date();
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = new Date();
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        return event.stopPropagation();
      };
      $scope.addPartFields = function() {
        return $scope.parts.push({
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        });
      };
      $scope.parts = [
        {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          partNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.deleteItem = function(list, index) {
        return list.splice(index, 1);
      };
      $scope.addToolingFields = function() {
        return $scope.tooling.push({
          id: null,
          toolNbr: null,
          qty: null,
          description: null
        });
      };
      $scope.tooling = [
        {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }, {
          id: null,
          toolNbr: null,
          qty: null,
          description: null,
          status: null
        }
      ];
      $scope.addTravelerFields = function() {
        return $scope.travelers.push({
          "employee": {
            "firstName": null,
            "lastName": null,
            "id": null,
            "phone": null,
            "base": null,
            "DOB": null,
            "gender": null
          },
          "travelInfo": {
            hotels: null,
            airlines: null,
            cars: null
          }
        });
      };
      if ($cookieStore.get('travelers')) {
        $scope.travelers = $cookieStore.get('travelers');
      } else {
        $scope.travelers = [
          {
            "employee": {
              "firstName": null,
              "lastName": null,
              "id": null,
              "phone": null,
              "base": null,
              "DOB": null,
              "gender": null
            },
            "travelInfo": {
              hotels: null,
              airlines: null,
              cars: null
            }
          }
        ];
      }
      $scope.$watch('employeeDirectory.length', function(newVal, oldVal) {
        var value;
        value = $scope.employeeDirectory;
        if (newVal > 0) {
          $scope.travelers = value;
          return $cookieStore.put('travelers', $scope.travelers);
        }
      });
      $scope.addVendorFields = function() {
        return $scope.vendors.push({
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        });
      };
      $scope.vendors = [
        {
          "name": null,
          "contactFirstName": null,
          "contactLastName": null,
          "phone": null,
          "fax": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "contract": null
        }
      ];
      _this = this;
      _this.getStatesWs = {
        statesWs: function(service) {
          return service.getStates(_this.getStatesWs.success, _this.getStatesWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.states = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStatesWs.statesWs(StatesService);
      _this.getRoadTripWs = {
        roadTripWs: function(service, id) {
          return service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.roadTrip = data;
          return console.log(data);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getRoadTripWs.roadTripWs(RoadTripService, $scope.id);
      $scope.openDeleteModal = function() {
        var modalInstance;
        modalInstance = $modal.open({
          controller: "DeleteModalCtrl",
          templateUrl: 'src/app/ui_flow/delete/modal.jade',
          resolve: {
            rt: function() {
              return $scope.roadTrip;
            }
          }
        });
        return modalInstance.result.then(function(flashMessage) {
          return $scope.goToPath({
            which: 13
          }, '/view/' + $scope.roadTrip.id);
        });
      };
      $scope.cancel = function() {
        return $modalInstance.close();
      };
      _this.getStationsWs = {
        stationsWs: function(service) {
          return service.getStations(_this.getStationsWs.success, _this.getStationsWs.error);
        },
        success: function(data, status, headers, config) {
          var stations, _i, _len, _results;
          _results = [];
          for (_i = 0, _len = data.length; _i < _len; _i++) {
            stations = data[_i];
            if (stations.name.toUpperCase() === $scope.event.station.toUpperCase()) {
              $scope.roadTrip.station = stations.name;
              $scope.roadTrip.stationManager = stations.stationManager;
              $scope.roadTrip.stationOnCall = stations.stationOnCall;
              $scope.vendors = stations.mxVendor;
              break;
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getEventWs = {
        eventWs: function(service) {
          return service.getEvent($scope.id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var event;
          event = data;
          $scope.event = event;
          _this.getStationsWs.stationsWs(StationsService);
          return $scope.$watch("flightList", function() {
            var flightInfo, flights, flightsKey, tailNbr, _results;
            flights = $scope.flightList;
            _results = [];
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if ($scope.event.tailNbr === tailNbr) {
                _results.push($scope.event.flightInfo = flightInfo);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventWs.eventWs(EventsService);
      _this.putRoadTripWs = {
        roadTripWs: function(data, service) {
          return service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/roadtrip/view/' + $scope.id);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.removeEmpties = function(list, attr, attr2) {
        var i, item;
        i = 0;
        while (i < list.length) {
          item = list[i];
          if (attr2 === null) {
            if (item[attr] === null || item[attr] === void 0 || item[attr] === '') {
              list.splice(i, 1);
              i--;
            }
          } else {
            if (item[attr][attr2] === null || item[attr][attr2] === void 0 || item[attr][attr2] === '') {
              list.splice(i, 1);
              i--;
            }
          }
          i++;
        }
        return console.log(list);
      };
      $scope.edit = function(event_id, eventType, index) {
        $cookieStore.put('travelers', $scope.travelers);
        $cookieStore.put('currentTraveler', {
          traveler: $scope.travelers[index],
          returnURL: $location.path()
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/add_travel/' + event_id);
      };
      $scope.add = function(event_id, index) {
        $cookieStore.put('travelers', $scope.travelers);
        $cookieStore.put('currentRT', $scope.roadTrip);
        $cookieStore.put('currentTraveler', {
          traveler: $scope.travelers[index],
          returnURL: $location.path()
        });
        return $scope.goToPath({
          which: 13
        }, 'roadtrip/add_travel/' + event_id);
      };
      $scope.cancelRTcreation = function() {
        $cookieStore.remove('travelers');
        $cookieStore.remove('currentRT');
        $cookieStore.remove('currentTraveler');
        return goToPath({
          which: 13
        }, '/view/' + event.id);
      };
      return $scope.submit = function() {
        $scope.removeEmpties($scope.parts, "partNbr", null);
        $scope.removeEmpties($scope.tooling, "toolNbr", null);
        $scope.removeEmpties($scope.travelers, "employee", "id");
        $scope.removeEmpties($scope.vendors, "name", null);
        $cookieStore.remove('travelers');
        $cookieStore.remove('currentRT');
        $cookieStore.remove('currentTraveler');
        return console.log($scope.roadTrip);
      };
    }
  ]);

}).call(this);

(function() {
  var roadtripedittravel;

  roadtripedittravel = angular.module('app.roadtrip.edittravel', []);

  roadtripedittravel.controller("RoadTripEditTravelCtrl", [
    '$scope', '$location', '$modal', '$stateParams', '$cookieStore', 'StatesService', 'RoadTripService', 'FlightsService', 'EventsService', 'TravelArrangementsService', function($scope, $location, $modal, $stateParams, $cookieStore, StatesService, RoadTripService, FlightsService, EventsService, TravelArrangementsService) {
      var _this;
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.id = $stateParams.id;
      $scope.employee_id = $stateParams.employee_id;
      $scope.editType = $stateParams.editType;
      $scope.dt = [];
      $scope.at = [];
      $scope.today = function() {
        $scope.dt[0] = new Date();
        $scope.at[0] = new Date();
      };
      $scope.today();
      $scope.clear = function() {
        $scope.dt = [];
        $scope.at = [];
      };
      $scope.toggleMin = function() {
        $scope.minDate = ($scope.minDate ? null : new Date());
      };
      $scope.toggleMin();
      $scope.dateOptions = {
        formatYear: "yy",
        startingDay: 1
      };
      $scope.initDate = new Date("2016-15-20");
      $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
      $scope.format = $scope.formats[0];
      $scope.mytime = new Date();
      $scope.hstep = 1;
      $scope.mstep = 15;
      $scope.options = {
        hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        mstep: [1, 5, 10, 15, 25, 30]
      };
      $scope.ismeridian = true;
      $scope.toggleMode = function() {
        return $scope.ismeridian = !$scope.ismeridian;
      };
      $scope.update = function() {
        var d;
        d = new Date();
        d.setHours(14);
        d.setMinutes(0);
        return $scope.mytime = d;
      };
      $scope.clear = function() {
        return $scope.mytime = null;
      };
      $scope.openDatepicker = function(event) {
        event.preventDefault();
        return event.stopPropagation();
      };
      $scope.addHotelFields = function() {
        return $scope.hotels.push({
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        });
      };
      $scope.hotels = [
        {
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        }
      ];
      $scope.addAirlineFields = function() {
        $scope.airlines.push({
          "id": $scope.id_count,
          "name": null,
          "departure": {
            "flightNbr": null,
            "station": null,
            "departUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          },
          "arrival": {
            "flightNbr": null,
            "station": null,
            "arriveUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          }
        });
        return $scope.id_count++;
      };
      $scope.airlines = [
        {
          "name": null,
          "departure": {
            "flightNbr": null,
            "station": null,
            "departUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          },
          "arrival": {
            "flightNbr": null,
            "station": null,
            "arriveUnixTimestamp": null,
            "seat": null,
            "confNbr": null
          }
        }
      ];
      $scope.addCarFields = function() {
        return $scope.cars.push({
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        });
      };
      $scope.cars = [
        {
          "name": null,
          "address": null,
          "city": null,
          "state": null,
          "zip": null,
          "phone": null,
          "confNbr": null
        }
      ];
      $scope.deleteItem = function(list, index) {
        return list.splice(index, 1);
      };
      $scope.removeEmpties = function(list, attr, attr2) {
        var i, item, _results;
        i = 0;
        _results = [];
        while (i < list.length) {
          item = list[i];
          if (attr2 === null) {
            if (item[attr] === null || item[attr] === void 0 || item[attr] === '') {
              list.splice(i, 1);
              i--;
            }
          } else {
            if (item[attr][attr2] === null || item[attr][attr2] === void 0 || item[attr][attr2] === '') {
              list.splice(i, 1);
              i--;
            }
          }
          _results.push(i++);
        }
        return _results;
      };
      _this = this;
      _this.getStatesWs = {
        statesWs: function(service) {
          return service.getStates(_this.getStatesWs.success, _this.getStatesWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.states = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getStatesWs.statesWs(StatesService);
      $scope.id_count = 0;
      $scope.fixData = function(travelers) {
        var airline, al, j, _i, _len, _ref;
        if (travelers.travelInfo.hotel.length > 0) {
          $scope.hotels = travelers.travelInfo.hotel;
        }
        if (travelers.travelInfo.airline.length > 0) {
          j = 0;
          al = [];
          _ref = travelers.travelInfo.airline;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            airline = _ref[_i];
            airline.id = j;
            $scope.dt[j] = $scope.mytime_dt = moment.unix(airline.departure.departUnixTimestamp)._d;
            $scope.at[j] = $scope.mytime_at = moment.unix(airline.arrival.arriveUnixTimestamp)._d;
            al.push(airline);
            j++;
            $scope.id_count = j;
          }
          $scope.airlines = al;
        }
        if (travelers.travelInfo.car.length > 0) {
          return $scope.cars = travelers.travelInfo.car;
        }
      };
      $scope.editTravel = $cookieStore.get('editTravel');
      $scope.roadTripTraveler = $scope.editTravel.newTraveler[$scope.editTravel.index];
      $scope.returnURL = $scope.editTravel.path;
      if ($scope.roadTripTraveler.travelInfo.hotel.length) {
        $scope.hotels = $scope.roadTripTraveler.travelInfo.hotel;
      }
      if ($scope.roadTripTraveler.travelInfo.airline) {
        $scope.airlines = $scope.roadTripTraveler.travelInfo.airline;
      }
      if ($scope.roadTripTraveler.travelInfo.car) {
        $scope.cars = $scope.roadTripTraveler.travelInfo.car;
      }
      _this.putRoadTripWs = {
        roadTripWs: function(service, data) {
          return service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.goToPath({
            which: 13
          }, '/roadtrip/view/' + $scope.id);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      return $scope.submit = function() {
        var arrivalTime, departureTime, i;
        $scope.removeEmpties($scope.hotels, "name", null);
        $scope.removeEmpties($scope.airlines, "name", null);
        $scope.removeEmpties($scope.cars, "name", null);
        $scope.roadTripTraveler.travelInfo.hotel = $scope.hotels;
        $scope.roadTripTraveler.travelInfo.airline = $scope.airlines;
        $scope.roadTripTraveler.travelInfo.car = $scope.cars;
        i = 0;
        while (i < $scope.airlines.length) {
          departureTime = moment($scope.dt[i]).format('ddd ll') + " " + moment($scope.mytime_dt).format('hh:mm:ss');
          $scope.airlines[i].departure.departUnixTimestamp = $scope.toMilliseconds(new Date(departureTime));
          arrivalTime = moment($scope.at[i]).format('ddd ll') + " " + moment($scope.mytime_at).format('hh:mm:ss');
          $scope.airlines[i].arrival.arriveUnixTimestamp = $scope.toMilliseconds(new Date(arrivalTime));
          i++;
        }
        $scope.editTravel.newTraveler[$scope.editTravel.index] = $scope.roadTripTraveler;
        $cookieStore.put('editTravel', {
          "newTraveler": $scope.editTravel.newTraveler,
          "path": $location.path(),
          "index": $scope.editTravel.index
        });
        return $scope.goToPath({
          which: 13
        }, $scope.returnURL);
      };
    }
  ]);

}).call(this);

(function() {
  var roadtripview;

  roadtripview = angular.module('app.roadtrip.view', []);

  roadtripview.controller("RoadTripViewCtrl", [
    '$scope', '$location', '$stateParams', '$modal', 'RoadTripService', 'FlightsService', 'EventsService', function($scope, $location, $stateParams, $modal, RoadTripService, FlightsService, EventsService) {
      var _this;
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      _this = this;
      _this.getRoadTripWs = {
        roadTripWs: function(service, id) {
          return service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          $scope.roadTrip = data;
          return console.log($scope.roadTrip);
        },
        error: function(data, status, headers, config) {}
      };
      $scope.id = $stateParams.id;
      _this.getRoadTripWs.roadTripWs(RoadTripService, $scope.id);
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getEventWs = {
        eventWs: function(service) {
          var id;
          id = $stateParams.id;
          return service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var event;
          event = data;
          $scope.event = event;
          return $scope.$watch("flightList", function() {
            var flightInfo, flights, flightsKey, tailNbr, _results;
            flights = $scope.flightList;
            _results = [];
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if ($scope.event.tailNbr === tailNbr) {
                _results.push($scope.event.flightInfo = flightInfo);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventWs.eventWs(EventsService);
      $scope.openRTDeleteModal = function() {
        var modalInstance;
        modalInstance = $modal.open({
          controller: "DeleteModalCtrl",
          templateUrl: 'src/app/ui_flow/delete/rt-modal.jade',
          resolve: {
            rt: function() {
              return $scope.roadTrip;
            },
            ev: function() {
              return $scope.event;
            }
          }
        });
        return modalInstance.result.then(function(flashMessage) {
          return $scope.goToPath({
            which: 1
          }, '/view/' + $scope.roadTrip.id);
        });
      };
      return $scope.cancel = function() {
        return $modalInstance.close();
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var events;

  events = angular.module("services.events", []);

  events.factory("EventsService", [
    "$http", function($http) {
      return {
        getEvents: function(params, success, error) {
          return $http({
            method: "GET",
            url: "/api/events",
            params: params,
            loadId: 'tableOptions',
            retrySuccess: success,
            retryError: error
          });
        },
        getEvent: function(id, success, error) {
          return $http({
            method: "GET",
            url: "/api/events/" + encodeURIComponent(id)
          }).success(success).error(error);
        },
        postEvent: function(data, success, error) {
          return $http({
            method: "POST",
            url: "/api/events/",
            data: data
          }).success(success).error(error);
        },
        putEvent: function(id, data, success, error) {
          return $http({
            method: "PUT",
            url: "/api/events/" + id,
            data: data
          }).success(success).error(error);
        },
        postComment: function(id, data, success, error) {
          return $http({
            method: "POST",
            url: "api/events/" + id + "/comments",
            data: data
          }).success(success).error(error);
        },
        getVersionByTailNbr: function(tailNbr, success, error) {
          return $http({
            method: "GET",
            url: "/api/events/versions/" + encodeURIComponent(tailNbr)
          }).success(success).error(error);
        },
        getVersions: function(id, success, error) {
          return $http({
            method: "GET",
            url: "/api/events/" + id + "/versions"
          }).success(success).error(error);
        },
        getEventCodes: function(id, success, error) {
          return $http({
            method: "GET",
            url: "/api/event-codes"
          }).success(success).error(error);
        },
        getEventCode: function(id, success, error) {
          return $http({
            method: "GET",
            url: "/api/event-codes/" + id
          }).success(success).error(error);
        },
        getRootCauseCodes: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/root-cause-codes"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var flights;

  flights = angular.module("services.flights", []);

  flights.factory("FlightsService", [
    "$http", function($http) {
      return {
        getFlights: function(params, success, error) {
          return $http({
            method: "GET",
            url: "/api/flights",
            params: params,
            loadId: 'tableOptions',
            retrySuccess: success,
            retryError: error
          });
        }
      };
    }
  ]);

}).call(this);

(function() {
  var module;

  module = angular.module('services.list_state', []);

  module.factory('ListState', function() {
    var params;
    params = {
      pagination: {
        page: 1,
        pageSize: 10
      },
      filters: {
        programGroupId: '',
        filter_value: '',
        filter_option: '_all'
      },
      sorting: 'code'
    };
    return {
      getParams: function() {
        return params;
      },
      setParams: function(prms) {
        params.filters.filter_value = prms.filter_value ? prms.filter_value : '';
        params.filters.filter_option = prms.filter_option ? prms.filter_option : '_all';
        params.filters.programGroupId = prms.programGroupId ? prms.programGroupId : '';
        params.pagination.pageSize = prms.pageSize ? prms.pageSize : 10;
        params.pagination.page = prms.page ? prms.page : 1;
        return params.sorting = prms.sort ? prms.sort : 'code';
      },
      getListStateUrl: function() {
        if (!params.filters.programGroupId) {
          params.filters.programGroupId = '';
        }
        return "/list?programGroupId=" + params.filters.programGroupId + "&filter_option=" + params.filters.filter_option + "&filter_value=" + params.filters.filter_value + "&pageSize=" + params.pagination.pageSize + "&page=" + params.pagination.page + "&sort=" + params.sorting;
      }
    };
  });

}).call(this);

(function() {
  var module;

  module = angular.module('services.object-list', []);

  module.factory('ObjectList', [
    '$filter', function($filter) {
      var items;
      items = [
        {
          "id": 1,
          "code": "1",
          "title": "Alpha",
          "description": "Details about item"
        }, {
          "id": 2,
          "code": "2",
          "title": "Beta",
          "description": "Details about item"
        }, {
          "id": 3,
          "code": "3",
          "title": "Gamma",
          "description": "Details about item"
        }, {
          "id": 4,
          "code": "4",
          "title": "Delta",
          "description": "Details about item"
        }, {
          "id": 5,
          "code": "5",
          "title": "Epsilon",
          "description": "Details about item"
        }, {
          "id": 6,
          "code": "6",
          "title": "Alpha",
          "description": "Details about item"
        }, {
          "id": 7,
          "code": "7",
          "title": "Beta",
          "description": "Details about item"
        }, {
          "id": 8,
          "code": "8",
          "title": "Gamma",
          "description": "Details about item"
        }, {
          "id": 9,
          "code": "9",
          "title": "Delta",
          "description": "Details about item"
        }, {
          "id": 10,
          "code": "10",
          "title": "Epsilon",
          "description": "Details about item"
        }, {
          "id": 11,
          "code": "11",
          "title": "Alpha",
          "description": "Details about item"
        }, {
          "id": 12,
          "code": "12",
          "title": "Beta",
          "description": "Details about item"
        }, {
          "id": 13,
          "code": "13",
          "title": "Gamma",
          "description": "Details about item"
        }, {
          "id": 14,
          "code": "14",
          "title": "Delta",
          "description": "Details about item"
        }, {
          "id": 15,
          "code": "15",
          "title": "Epsilon",
          "description": "Details about item"
        }
      ];
      return {
        query: function(api_params) {
          var filtered_list, result;
          filtered_list = items;
          if (api_params.select === 9) {
            return [];
          }
          if (api_params.filter_value && api_params.filter_option) {
            filtered_list = $filter('listFilter')(items, api_params.filter_value, api_params.filter_option);
          }
          filtered_list = filtered_list.slice((api_params.page - 1) * api_params.pageSize, api_params.page * api_params.pageSize);
          result = {
            items: filtered_list,
            totalItems: items.length
          };
          return result;
        }
      };
    }
  ]);

  module.filter('listFilter', [
    '$filter', function($filter) {
      return function(input, value, option) {
        var filter_column, output;
        output = input;
        if (value.length) {
          if (option && option !== '_all') {
            filter_column = {};
            filter_column[option] = value;
            output = $filter('filter')(input, filter_column);
          } else {
            output = $filter('filter')(input, value);
          }
        }
        return output;
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var parts;

  parts = angular.module("services.parts", []);

  parts.factory("PartsService", [
    "$http", function($http) {
      return {
        getParts: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/parts/"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var roadtrips;

  roadtrips = angular.module("services.roadtrips", []);

  roadtrips.factory("RoadTripService", [
    "$http", function($http) {
      return {
        getRoadTrips: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/roadtrips/"
          }).success(success).error(error);
        },
        getRoadTrip: function(id, success, error) {
          return $http({
            method: "GET",
            url: "/api/roadtrips/" + encodeURIComponent(id)
          }).success(success).error(error);
        },
        postRoadTrip: function(data, success, error) {
          return $http({
            method: "POST",
            url: "/api/roadtrips/",
            data: data
          }).success(success).error(error);
        },
        putRoadTrip: function(data, success, error) {
          return $http({
            method: "PUT",
            url: "/api/roadtrips/" + data.id,
            data: data
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var states;

  states = angular.module("services.states", []);

  states.factory("StatesService", [
    "$http", function($http) {
      return {
        getStates: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/states/"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var stations;

  stations = angular.module("services.stations", []);

  stations.factory("StationsService", [
    "$http", function($http) {
      return {
        getStations: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/stations/"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var tailNumbers;

  tailNumbers = angular.module("services.tailNumbers", []);

  tailNumbers.factory("TailNumberService", [
    "$http", function($http) {
      return {
        getTailNumbers: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/tails"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var stations;

  stations = angular.module("services.tail_routes", []);

  stations.factory("TailRoutesService", [
    "$http", function($http) {
      return {
        getTailRoutes: function(params, success, error) {
          return $http({
            method: "GET",
            url: "/api/tailroutes/"
          }).success(success).error(error);
        },
        getTailRouteByTailNbr: function(tailNbr, success, error) {
          return $http({
            method: "GET",
            url: "/api/tailroutes/" + encodeURIComponent(tailNbr)
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var travel;

  travel = angular.module("services.travel_arrangements", []);

  travel.factory("TravelArrangementsService", [
    "$http", function($http) {
      var getRoadTripInProgress, roadTripInProgress, setRoadTripInProgress;
      roadTripInProgress = {};
      setRoadTripInProgress = function(obj) {
        return roadTripInProgress = obj;
      };
      getRoadTripInProgress = function() {
        return roadTripInProgress;
      };
      return {
        setRoadTripInProgress: setRoadTripInProgress,
        getRoadTripInProgress: getRoadTripInProgress
      };
    }
  ]);

}).call(this);

(function() {
  var view;

  view = angular.module('app.view', ['angularFileUpload']);

  view.controller("ViewCtrl", [
    '$scope', '$location', '$interval', '$upload', '$modal', '$stateParams', '$window', 'EventsService', 'FlightsService', 'RoadTripService', 'StationsService', function($scope, $location, $interval, $upload, $modal, $stateParams, $window, EventsService, FlightsService, RoadTripService, StationsService) {
      var _this;
      $scope.imagesInMedia = false;
      $scope.docsInMedia = false;
      $scope.id = $stateParams.id;
      $scope.onFileSelect = function($files) {
        var file, i;
        i = 0;
        while (i < $files.length) {
          file = $files[i];
          $scope.upload = $upload.upload({
            url: "api/mx-filestore-web/v1/api/files",
            data: {
              myObj: $scope.myModelObj
            },
            file: file
          }).progress(function(evt) {}).success(function(data, status, headers, config) {
            var filename, pathType, uploadedFile;
            filename = data[0].fileName;
            pathType = filename.substr(filename.lastIndexOf('.') + 1, filename.length);
            if (pathType === "jpg" || pathType === "jpeg" || pathType === "png" || pathType === "gif") {
              $scope.imagesInMedia = true;
            } else {
              $scope.docsInMedia = true;
            }
            uploadedFile = {
              ref: data[0].fileStoreKey,
              name: filename,
              createdUnixTimestamp: moment().unix(),
              path: 'http://localhost:3333/' + data[0].fileName
            };
            $scope.event.documents.push(uploadedFile);
          });
          i++;
        }
      };
      $scope.openDeleteModal = function() {
        var modalInstance;
        if ($scope.roadTrip != null) {
          modalInstance = $modal.open({
            controller: "DeleteWarningModalCtrl",
            templateUrl: 'src/app/ui_flow/delete/rt-warning-modal.jade'
          });
        } else {
          modalInstance = $modal.open({
            controller: "DeleteModalCtrl",
            templateUrl: 'src/app/ui_flow/delete/modal.jade',
            resolve: {
              rt: function() {
                return $scope.roadTrip;
              },
              ev: function() {
                return $scope.event;
              }
            }
          });
        }
        return modalInstance.result.then(function(flashMessage) {});
      };
      $scope.cancel = function() {
        return $modalInstance.close();
      };
      $scope.goToPath = function(e, path, query) {
        if (e.which === 13 || e.which === 1) {
          return $location.path(path).search({
            'filter_value': query
          });
        }
      };
      $scope.comment_limit_value = 3;
      $scope.increaseCommentLimit = function(lng) {
        if ($scope.comment_limit_value < lng) {
          $scope.comment_limit_value += 3;
        }
        if ($scope.comment_limit_value >= lng) {
          return $scope.comment_limit_value = lng;
        }
      };
      $scope.decreaseCommentLimit = function(lng) {
        if ($scope.comment_limit_value > 0) {
          $scope.comment_limit_value -= 3;
        }
        if ($scope.comment_limit_value <= 0) {
          return $scope.comment_limit_value = 0;
        }
      };
      $scope.history_limit_value = 3;
      $scope.increaseHistoryLimit = function(lng) {
        if ($scope.history_limit_value < lng) {
          $scope.history_limit_value += 3;
        }
        if ($scope.history_limit_value >= lng) {
          return $scope.history_limit_value = lng;
        }
      };
      $scope.decreaseHistoryLimit = function(lng) {
        if ($scope.history_limit_value > 0) {
          $scope.history_limit_value -= 3;
        }
        if ($scope.history_limit_value <= 0) {
          return $scope.history_limit_value = 0;
        }
      };
      $scope.currentTime = new Date();
      $scope.toMilliseconds = function(timestamp) {
        return Math.round(timestamp.getTime() / 1000);
      };
      $scope.collapsedIcon = function(isCollapsed) {
        if (isCollapsed === true) {
          return 'fa-angle-right';
        } else {
          return 'fa-angle-down';
        }
      };
      _this = this;
      $scope.getAttachmentType = function(path) {
        var pathType, paths;
        paths = {
          images: '',
          docs: ''
        };
        if (path !== void 0) {
          pathType = path.substr(path.lastIndexOf('.') + 1, path.length);
          if (pathType === "jpg" || pathType === "jpeg" || pathType === "png" || pathType === "gif") {
            paths.images = path;
            $scope.imagesInMedia = true;
          } else {
            paths.docs = path;
            $scope.docsInMedia = true;
          }
        }
        return paths;
      };
      _this.getFlightsWs = {
        flightWs: function(service) {
          return service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error);
        },
        success: function(data, status, headers, config) {
          return $scope.flightList = data;
        },
        error: function(data, status, headers, config) {}
      };
      _this.getFlightsWs.flightWs(FlightsService);
      _this.getStationsWs = {
        stationWs: function(service) {
          return service.getStations(function(data, status, headers, config) {
            var station, _i, _len, _results;
            _results = [];
            for (_i = 0, _len = data.length; _i < _len; _i++) {
              station = data[_i];
              if (station.name === $scope.event.station) {
                _results.push($scope.event.station = station);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          }, function(data, status, headers, config) {
            return console.log('error');
          });
        }
      };
      _this.getEventVersionsWs = {
        eventVersionsWs: function(service) {
          var id;
          id = $stateParams.id;
          return service.getVersions(id, _this.getEventVersionsWs.success, _this.getEventVersionsWs.error);
        },
        success: function(data, status, headers, config) {
          var i, j, k, lng, openVersions, sortByCreatedTime, splitVersionsByStatus, statusCloseTime, statusDuration, statusOpenTime, ticketCloseTime, ticketDuration, ticketOpenTime, versionList;
          versionList = data;
          openVersions = [];
          if (versionList.length > 0) {
            lng = versionList.length;
            sortByCreatedTime = function(a, b) {
              var sortStatus;
              sortStatus = 0;
              if (a.createdUnixTimestamp < b.createdUnixTimestamp) {
                sortStatus = -1;
              } else {
                if (a.createdUnixTimestamp > b.createdUnixTimestamp) {
                  sortStatus = 1;
                }
              }
              return sortStatus;
            };
            versionList.sort(sortByCreatedTime);
            ticketCloseTime = '';
            ticketOpenTime = versionList[0].createdUnixTimestamp;
            if ($scope.event.state === "closed") {
              ticketCloseTime = versionList[lng - 1].createdUnixTimestamp;
            } else {
              ticketCloseTime = moment().unix();
            }
            ticketDuration = ticketCloseTime - ticketOpenTime;
            splitVersionsByStatus = function(version) {
              var key, tmp;
              tmp = [];
              for (key in versionList) {
                if (versionList[key].status.toLowerCase() === version) {
                  tmp.push(versionList[key]);
                }
              }
              if (tmp.length) {
                return openVersions.push(tmp);
              }
            };
            splitVersionsByStatus('adv');
            if ($scope.event.status.toUpperCase() === "ETR") {
              splitVersionsByStatus('etr');
            }
            i = 1;
            while (i < openVersions.length + 1) {
              j = i - 1;
              if (openVersions[j].length) {
                statusOpenTime = openVersions[j][0].createdUnixTimestamp;
                if (i === openVersions.length) {
                  statusCloseTime = ticketCloseTime;
                } else {
                  if (openVersions[i].length) {
                    statusCloseTime = openVersions[i][0].createdUnixTimestamp;
                  } else {
                    statusCloseTime = ticketCloseTime;
                  }
                }
                statusDuration = statusCloseTime - statusOpenTime;
              }
              i++;
              k = 0;
              while (k < openVersions[j].length) {
                openVersions[j][k].duration = Math.round(statusDuration * 100);
                openVersions[j][k].durationPercentage = Math.round((statusDuration / ticketDuration) * 100);
                k++;
              }
            }
            return $scope.event.versionInfo = openVersions;
          }
        },
        error: function(data, status, headers, config) {}
      };
      $scope.user = {
        loginId: "michael.freeman",
        empId: "00015",
        fullName: "Michael Freeman"
      };
      $scope.commentConfig = {
        user: {
          loginId: $scope.user.loginId,
          empId: $scope.user.empId,
          fullName: $scope.user.fullName
        },
        context: "AOS",
        namespace: "aosuser",
        path: "/api/mx-comment-web/v1/api/namespaces/aosuser/contexts/AOS/comments",
        show: {
          close: false,
          attachments: true,
          visible: true,
          isVisible: function() {
            return this.visible;
          },
          toggle: function() {
            this.visible = !this.visible;
            return this.visible;
          }
        }
      };
      _this.getEventWs = {
        eventWs: function(service) {
          var id;
          id = $stateParams.id;
          return service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error);
        },
        success: function(data, status, headers, config) {
          var event;
          event = data;
          $scope.getElapsedTime(event);
          $scope.event = event;
          $scope.$watch("flightList", function() {
            var flightInfo, flights, flightsKey, tailNbr, _results;
            flights = $scope.flightList;
            _results = [];
            for (flightsKey in flights) {
              tailNbr = flights[flightsKey].tailNbr;
              flightInfo = flights[flightsKey];
              if ($scope.event.tailNbr === tailNbr) {
                $scope.event.flightInfo = flightInfo;
                _results.push(console.log(flightInfo.routes[2]));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
          _this.getEventVersionsWs.eventVersionsWs(EventsService);
          return _this.getStationsWs.stationWs(StationsService);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEventWs.eventWs(EventsService);
      $scope.elapsedTime = '';
      $scope.getElapsedTime = function(event) {
        return $interval(function() {
          if ($scope.toMilliseconds(new Date()) - event.createdUnixTimestamp > 0) {
            return $scope.elapsedTime = $scope.toMilliseconds(new Date()) - event.createdUnixTimestamp;
          } else {
            return $scope.elapsedTime = 0;
          }
        }, 1000);
      };
      _this.getRoadTripWs = {
        roadTripWs: function(service) {
          var id;
          id = $stateParams.id;
          return service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error);
        },
        success: function(data, status, headers, config) {
          var roadTrip;
          roadTrip = data;
          if (roadTrip !== '') {
            console.log(roadTrip.state.toUpperCase());
            if (roadTrip.id.toString() === $scope.event.id.toString() && roadTrip.state.toUpperCase() !== 'CLOSED') {
              return $scope.roadTrip = roadTrip;
            }
          }
        },
        error: function(data, status, headers, config) {}
      };
      _this.getRoadTripWs.roadTripWs(RoadTripService);
      $scope.newComment = {
        "text": null,
        "createdUnixTimestamp": $scope.toMilliseconds($scope.currentTime),
        "createdBy": {
          "loginId": "caitlin.smith",
          "empId": "10593",
          "fullName": "Caitlin Smith"
        },
        "replies": [],
        "attachments": []
      };
      _this.postCommentWs = {
        commentWs: function(service, data) {
          var id;
          id = $stateParams.id;
          return service.postComment(id, data, _this.postCommentWs.success, _this.postCommentWs.error);
        },
        success: function(data, status, headers, config) {},
        error: function(data, status, headers, config) {}
      };
      return $scope.createComment = function() {
        var id;
        _this.postCommentWs.commentWs(EventsService, $scope.newComment);
        id = $stateParams.id;
        return $window.location.reload();
      };
    }
  ]);

}).call(this);

(function() {
  var directives;

  directives = angular.module('g4plus.directives', []);

  directives.directive("g4Routing", function() {
    return {
      restrict: "A",
      scope: {
        listData: "=listData"
      },
      templateUrl: 'src/app/ui_flow/g4plus-directives/src/routing.jade',
      link: function(scope, element, attrs) {
        return scope.$watch("listData", function() {
          var bulletsColor, event, greenBullets, i, _getPercentage;
          if (scope.listData) {
            if (scope.listData.flightInfo) {
              event = scope.listData.flightInfo.routes[2].currentInfo;
              scope.popoverHtml = "<strong class='col-sm-6 text-left'>Code:</strong>\n<div class='col-sm-6 text-left'>" + event.code + "</div>\n<strong class='col-sm-6 text-left'>Flight:</strong>\n<div class='col-sm-6 text-left'>" + event.flightNbr + "</div>\n<strong class='col-sm-6 text-left'>Altitude:</strong>\n<div class='col-sm-6 text-left'>" + event.altitude + " ft</div>\n<strong class='col-sm-6 text-left'>Airspeed:</strong>\n<div class='col-sm-6 text-left'>" + event.airspeed + " mph</div>\n<strong class='col-sm-6 text-left'>ETA:</strong>\n<div class='col-sm-6 text-left'>" + moment.unix(event.ETA).format("HH:MM") + " GMT</div>\n<div class=\"clearfix\"></div>";
              scope.live_flight_data = scope.popoverHtml;
              scope.flightDays = [
                [
                  {
                    station: 'HNL',
                    time: '12:00'
                  }, {
                    station: 'LAS',
                    time: '12:00'
                  }, {
                    station: 'MFE',
                    time: '12:00'
                  }, {
                    station: 'LAS',
                    time: '12:00'
                  }
                ], [
                  {
                    station: 'GFK',
                    time: '08:00'
                  }, {
                    station: 'LAS',
                    time: '11:00'
                  }, {
                    station: 'MFE',
                    time: '16:00'
                  }, {
                    station: 'LAS',
                    time: '18:00'
                  }, {
                    station: 'AUS',
                    time: '20:00'
                  }
                ], [
                  {
                    station: 'LAS',
                    time: '12:00'
                  }, {
                    station: 'MFE',
                    time: '12:00'
                  }, {
                    station: 'LAS',
                    time: '12:00'
                  }, {
                    station: 'IND',
                    time: '12:00'
                  }, {
                    station: 'LAS',
                    time: '12:00'
                  }
                ]
              ];
              scope.currentFlightIndex = 1;
              scope.flightDays[scope.currentFlightIndex].active = true;
              greenBullets = 2;
              bulletsColor = {};
              i = 0;
              while (i < greenBullets) {
                bulletsColor[i] = 'green';
                i++;
              }
              bulletsColor[i] = 'red';
              _getPercentage = function(index, total) {
                return index * (100 / (total - 1)).toFixed(2);
              };
              scope.bulletClass = function(parentIndex, index) {
                if (parentIndex === scope.currentFlightIndex) {
                  if (bulletsColor[index]) {
                    return bulletsColor[index];
                  }
                }
                return "";
              };
              scope.bulletPosition = function(index, total) {
                return {
                  left: _getPercentage(index, total) + "%"
                };
              };
              scope.greenTrackWidth = function(total) {
                return {
                  width: _getPercentage(greenBullets, total) + "%"
                };
              };
              scope.redTrackPosition = function(total) {
                return {
                  left: _getPercentage(greenBullets, total) + "%",
                  width: "56px"
                };
              };
              scope.aircraftPosition = function(total) {
                return {
                  left: (_getPercentage(greenBullets, total) + 5) + "%"
                };
              };
              scope.today = function() {
                scope.dt = new Date();
                return scope.dt2 = new Date();
              };
              scope.today();
              scope.clear = function() {
                scope.dt = null;
                return scope.dt2 = null;
              };
              scope.toggleMin = function() {
                scope.minDate = (scope.minDate ? null : new Date());
              };
              scope.toggleMin();
              scope.open = function($event) {
                $event.preventDefault();
                $event.stopPropagation();
                scope.opened = true;
              };
              scope.dateOptions = {
                formatYear: "yy",
                startingDay: 1
              };
              scope.initDate = new Date("2016-15-20");
              scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "dd.MM.yyyy", "shortDate"];
              return scope.format = scope.formats[0];
            }
          }
        });
      }
    };
  });

  directives.filter("g4DateFormat", function() {
    var format;
    format = function(timestamp, type, formatting) {
      var duration, formattedTime, newMinutes, newSeconds;
      if (type === "duration") {
        duration = moment.duration(timestamp, "seconds")._data;
        newMinutes = duration.minutes;
        newSeconds = duration.seconds;
        if (duration.minutes.toString().length === 1) {
          newMinutes = "0" + duration.minutes.toString();
        }
        if (duration.seconds.toString().length === 1) {
          newSeconds = "0" + duration.seconds.toString();
        }
        formattedTime = "" + duration.hours + ":" + newMinutes + ":" + newSeconds;
        if (duration.days > 0) {
          formattedTime = ("" + duration.days + "d ") + formattedTime;
        }
        if (duration.months > 0) {
          formattedTime = ("" + duration.months + "m ") + formattedTime;
        }
        if (duration.years > 0) {
          formattedTime = ("" + duration.years + "y ") + formattedTime;
        }
        return formattedTime;
      }
      return moment.unix(timestamp).format(formatting);
    };
    return format;
  });

  directives.directive("g4UnixTimestampConverter", function() {
    return {
      restrict: "A",
      scope: {
        formatting: "@formatting",
        durationOrConversion: "@durationOrConversion",
        timestamp: "=timestamp"
      },
      template: "<span>{{ timestamp | g4DateFormat:durationOrConversion:formatting }}</span>",
      link: function(scope, element, attrs) {}
    };
  });

  directives.directive("g4AosIndicators", function() {
    return {
      restrict: "A",
      scope: {
        listData: "=listData"
      },
      link: function(scope, element, attrs) {
        scope.pulse = function(el) {
          return $(el).delay(1200).animate({
            opacity: 0
          }).delay(50).animate({
            opacity: 1
          }, function() {
            return scope.pulse($(el));
          });
        };
        return scope.$watch("listData", function() {
          var advisoryTimeUnix, createdTimeUnix, currentTime, currentTimeUnix, departureTimestamp, durationInMilSec, eighteenHours2mSec, eigthHours2mSec, oneHr2mSec, reasons, tenMin2mSec;
          if (scope.listData) {
            if (scope.listData.flightInfo.routes[2]) {
              reasons = scope.listData.flightInfo.routes[2].departureInfo.status;
              scope.eventType = scope.listData.type;
              currentTimeUnix = currentTime = moment().unix();
              advisoryTimeUnix = parseInt(scope.listData.advisoryUnixTimestamp);
              durationInMilSec = moment.duration(advisoryTimeUnix - currentTimeUnix, 'seconds')._milliseconds;
              tenMin2mSec = 600;
              if (durationInMilSec <= tenMin2mSec) {
                element.append("<i class='indicators time10'></i>");
              }
              createdTimeUnix = scope.listData.createdUnixTimestamp;
              durationInMilSec = moment.duration(currentTimeUnix - createdTimeUnix, 'seconds')._milliseconds;
              eighteenHours2mSec = 64800000;
              eigthHours2mSec = 28800000;
              if (durationInMilSec >= eighteenHours2mSec) {
                element.append("<i class='indicators time18'></i>");
              }
              if (durationInMilSec >= eigthHours2mSec && durationInMilSec < eighteenHours2mSec) {
                element.append("<i class='indicators time8'></i>");
              }
              if (scope.eventType.toUpperCase() === "MCO") {
                element.append("<i class='indicators mco'></i>");
                scope.pulse($('.mco'));
              }
              departureTimestamp = parseInt(scope.listData.flightInfo.routes[2].departureInfo.scheduledDepartureUnixTimestamp);
              oneHr2mSec = 3600;
              if ((departureTimestamp - currentTimeUnix) < oneHr2mSec && departureTimestamp > currentTimeUnix) {
                $(element).parents('.eventList').find('.dashboard_flight_info').prepend('<span>TIME</span><br>');
              }
              if (advisoryTimeUnix >= (departureTimestamp - oneHr2mSec) && advisoryTimeUnix < departureTimestamp) {
                $(element).parents('.eventList').find('.dashboard_flight_info').addClass('alert flashing_flight_info');
                $('.view_flight_info').addClass('alert flashing_flight_info');
                scope.pulse($('.eventList .alert, #view_info .alert.flashing_flight_info'));
              }
              if (advisoryTimeUnix > departureTimestamp) {
                $(element).parents('.eventList').find('.dashboard_adv_time').addClass('alert flashing_adv_time text-center');
                scope.pulse($('.eventList .alert, #view_info .alert.flashing_adv_time'));
              }
              if (scope.listData.flightInfo !== void 0) {
                reasons = scope.listData.flightInfo.routes[2].currentInfo.status;
                if (scope.listData.roadTrip !== void 0) {
                  element.append("<i class='indicators roadTrip'></i>");
                }
                if (reasons.cancellation === true) {
                  element.append("<i class='indicators cancellation'></i>");
                }
                if (reasons.rejectedTakeOff === true) {
                  element.append("<i class='indicators rejectedTakeOff'></i>");
                }
                if (reasons.gateReturn === true) {
                  element.append("<i class='indicators gateReturn'></i>");
                }
                if (reasons.diversion === true) {
                  element.append("<i class='indicators diversion'></i>");
                }
                if (reasons.safetySignificantEvent === true) {
                  return element.append("<i class='indicators safetySignificantEvent'></i>");
                }
              }
            }
          }
        });
      }
    };
  });

  angular.module("template/carousel/carousel.html", []).run([
    "$templateCache", function($templateCache) {
      return $templateCache.put("template/carousel/carousel.html", "<div ng-mouseenter=\"pause()\" ng-mouseleave=\"play()\" class=\"carousel\">\n" + "    <ol class=\"carousel-indicators\" ng-show=\"slides().length > 1\">\n" + "        <li ng-repeat=\"slide in slides()\" ng-class=\"{active: isActive(slide)}\" ng-click=\"select(slide)\"></li>\n" + "    </ol>\n" + "    <div class=\"carousel-inner\" ng-transclude></div>\n" + "    <a class=\"left carousel-control\" ng-click=\"prev()\" ng-show=\"slides().length > 1\">" + "        <span class=\"fa fa-angle-left\"></span></a>\n" + "    <a class=\"right carousel-control\" ng-click=\"next()\" ng-show=\"slides().length > 1\">" + "        <span class=\"fa fa-angle-right\"></span></a>\n" + "</div>\n" + "");
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var ataCodes;

  ataCodes = angular.module("services.employeeDirectory", []);

  ataCodes.factory("EmployeeDirectoryService", [
    "$http", function($http) {
      return {
        getEmployees: function(success, error) {
          return $http({
            method: "GET",
            url: "/api/employeeDirectory"
          }).success(success).error(error);
        }
      };
    }
  ]);

}).call(this);

(function() {
  var employeeLookup;

  employeeLookup = angular.module('g4plus.employee-lookup', ['services.employeeDirectory']);

  employeeLookup.factory("EmployeeLookupService", function() {
    var selectedEmployees, _subscribers;
    _subscribers = [];
    selectedEmployees = [];
    return {
      subscribe: function(cb) {
        return _subscribers.push(cb);
      },
      setCode: function(code) {
        selectedEmployees = code;
        return angular.forEach(_subscribers, function(cb) {
          return cb(selectedEmployees);
        });
      }
    };
  });

  employeeLookup.directive("g4employeeLookup", [
    '$modal', 'EmployeeDirectoryService', 'EmployeeLookupService', function($modal, EmployeeDirectoryService, EmployeeLookupService) {
      return {
        restrict: "A",
        scope: {
          model: "=",
          linkText: "@"
        },
        transclude: true,
        template: "<a ng-click=\"openEmployeesLookup()\">{{linkText}}</a>",
        link: function(scope, element, attrs) {
          scope.$watch('model', function() {
            var code, model, _i, _len, _results;
            model = scope.model;
            if ((model != null ? model.length : void 0) > 0 && (model != null ? model.length : void 0) !== void 0 && model[0].employee.id !== null) {
              _results = [];
              for (_i = 0, _len = model.length; _i < _len; _i++) {
                code = model[_i];
                _results.push(scope.selectedEmployees = model);
              }
              return _results;
            } else {
              console.log('no');
              return scope.selectedEmployees = [];
            }
          });
          EmployeeLookupService.subscribe(function(code) {
            var i, inArray;
            inArray = false;
            i = 0;
            if (scope.selectedEmployees) {
              while (i < scope.selectedEmployees.length) {
                if (scope.selectedEmployees[i].employee.id === code.employee.id) {
                  inArray = true;
                  break;
                }
                i++;
              }
            }
            if (inArray !== true) {
              scope.selectedEmployees.push(code);
              return scope.model = scope.selectedEmployees;
            }
          });
          scope.openEmployeesLookup = function() {
            var modalInstance;
            return modalInstance = $modal.open({
              controller: "EmployeeLookupModalCtrl",
              template: "           <div class=\"employee-lookup-modal\">\n             <div class=\"modal-content\">\n               <div class=\"modal-body\">\n                 <button type=\"button\" data-dismiss=\"modal\" aria-hidden=\"true\" ng-click=\"cancel()\" class=\"close profile-close-button\">\n                   ×\n                 </button>\n                 <h1>Employees</h1>\n               <div ng-if=\"parentCodes.length == 1\">\n                 <table class=\"table-lined table-condensed\">\n                   <thead>\n                     <tr class=\"header_bar\">\n                       <th class=\"narrow\">ID</th>\n                       <th class=\"medium\">Name</th>\n                     </tr>\n                   </thead>\n                   <tbody\nng-repeat=\"employee in employees | orderBy:lastName | startFrom:(pagination.page-1)*10 | limitTo:pagination.pageSize\"\nng-animate=\"{move: 'move-animation'}\">\n                     <tr>\n                       <td class=\"medium\">{{employee.id}}</td>\n                       <td class=\"medium\"><a ng-click=\"getChildCodes(employee)\">{{employee.lastName}}, {{employee.firstName}}</a></td>\n                     </tr>\n                   </tbody>\n                 </table>\n               </div>\n\n               <div g4-pagination-message=\"\" current-page=\"pagination.page\" page-size=\"pagination.totalPage\"\ntotal-items=\"parentEmployees.length\" class=\"col-md-4\"></div>\n               <div g4-pagination-navigation=\"\" current-page=\"pagination.page\" total-pages=\"pagination.totalPage\"\npage-change=\"pagination.pageChange\" class=\"col-md-8 no-right-padding\"></div>\n               <div class=\"clearfix\"></div>\n             </div>\n           </div>"
            });
          };
          return scope.cancel = function() {
            return $modalInstance.close();
          };
        }
      };
    }
  ]);

  employeeLookup.controller("EmployeeLookupModalCtrl", [
    '$scope', '$modalInstance', 'EmployeeDirectoryService', 'EmployeeLookupService', function($scope, $modalInstance, EmployeeDirectoryService, EmployeeLookupService) {
      var _this;
      $scope.cancel = function() {
        return $modalInstance.close();
      };
      $scope.pagination = {
        totalItems: 0,
        totalPages: 0,
        pageSize: 10,
        page: 1,
        pageSizeChange: function(pageSize) {
          $scope.pagination.page = 1;
          return $scope.pagination.pageSize = pageSize;
        },
        pageChange: function(page) {
          return $scope.pagination.page = page;
        }
      };
      $scope.updatePagination = function(total) {
        $scope.pagination.totalItems = total;
        return $scope.pagination.totalPages = Math.ceil(total / $scope.pagination.pageSize);
      };
      $scope.selectedEmployees = [];
      EmployeeLookupService.subscribe(function(code) {
        return $scope.selectedEmployees.push(code);
      });
      _this = this;
      _this.getEmployeeDirectoryWS = {
        employeeWS: function(service) {
          return service.getEmployees(_this.getEmployeeDirectoryWS.success, _this.getEmployeeDirectoryWS.error);
        },
        success: function(data, status, headers, config) {
          $scope.employees = data;
          $scope.parentCodes.push({
            children: data
          });
          return $scope.updatePagination(data.length);
        },
        error: function(data, status, headers, config) {}
      };
      _this.getEmployeeDirectoryWS.employeeWS(EmployeeDirectoryService);
      $scope.parentCodes = [];
      $scope.currentParentCode = {};
      $scope.getChildCodes = function(code) {
        $scope.parentCodes.push(code);
        $scope.currentParentCode = code;
        return $scope.changeEmployeeLookupList(code);
      };
      $scope.loadParentCodes = function() {
        var parent;
        if ($scope.parentCodes.length > 0) {
          if ($scope.parentCodes.length > 1) {
            $scope.parentCodes.pop();
          }
          parent = $scope.parentCodes[$scope.parentCodes.length - 1];
          $scope.currentParentCode = parent;
          return $scope.changeEmployeeLookupList(parent.children);
        } else {
          return $scope.changeEmployeeLookupList(parent);
        }
      };
      $scope.addToSelectedEmployees = function(code) {
        return EmployeeLookupService.setCode(code);
      };
      return $scope.changeEmployeeLookupList = function(data) {
        $scope.addToSelectedEmployees({
          "employee": {
            "firstName": data.firstName,
            "lastName": data.lastName,
            "id": data.id,
            "contact": data.email,
            "base": data.base,
            "DOB": data.dob,
            "gender": data.gender
          },
          "travelInfo": {}
        });
        return $scope.cancel();
      };
    }
  ]);

  employeeLookup.filter("startFrom", function() {
    return function(input, start) {
      if (input !== void 0) {
        start = +start;
        return input.slice(start);
      }
    };
  });

}).call(this);

(function() {
  var listFilter;

  listFilter = angular.module('g4plus.list-filter', ['g4plus.autofocus', 'ngCookies']);

  listFilter.directive("g4ListFilter", [
    "$filter", "$cookieStore", function($filter, $cookieStore) {
      return {
        restrict: "A",
        replace: false,
        scope: {
          options: "=g4FilterOptions",
          filterBy: "=g4FilterBy",
          filter_value: "=g4FilterValue",
          filter_option: "=g4FilterOption"
        },
        template: "\n     <section class=\"row padding-bottom-large input-group search-input\">\n       <input type=\"text\"\n       placeholder=\"Search query\"\n       class=\"pull-left\"\n       ng-model=\"filter_value\"\n       id=\"g4-list-filter-input\"\n       ng-keyup=\"filterByValue($event)\"\n       g4-autofocus\n       />\n       <btn class=\"btn btn-primary btn-rght-rounded btn-search pull-left\">\n         <i class=\"icon-search\" ng-click=\"filterByValue($event)\"> </i>\n       </btn>\n     </section>\n\n     <div class=\"col-md-12 margin-top\">\n       <section class=\"border-top border-bottom padding-top-large filter_box\">\n         <div class=\"col-sm-8\">\n           <p>Filter by:<strong>&nbsp;Stations</strong></p>\n\n           <div class=\"col-sm-4\">\n             <div class=\"row\">\n               <div ng-repeat=\"value in inputs.station | limitTo:5\">\n                 <div>\n                   <label>\n                     {{value}}\n                     <input type=\"checkbox\" ng-model=\"outputs['station'][value]\" ng-checked=\"outputs['station'][value]\"\nvalue=\"value\" ng-click=\"checkboxFilterByValue()\"/>\n                     <span></span>\n                   </label>\n                   <div style=\"clear:both;\"></div>\n                 </div>\n               </div>\n             </div>\n           </div>\n\n           <div class=\"col-sm-4\">\n             <div class=\"row\">\n               <div ng-repeat=\"value in inputs.station\">\n                 <div ng-show=\"$index >= 5 && $index < 10\">\n                   <label>\n                     {{value}}\n                     <input type=\"checkbox\" ng-model=\"outputs['station'][value]\" ng-checked=\"outputs['station'][value]\"\nvalue=\"value\" ng-click=\"checkboxFilterByValue()\"/>\n                     <span></span>\n                   </label>\n                   <div style=\"clear:both;\"></div>\n                 </div>\n               </div>\n             </div>\n           </div>\n\n           <div class=\"col-sm-4\">\n             <div class=\"row\">\n               <div ng-repeat=\"value in inputs.station\">\n                 <div ng-show=\"$index >= 10 && $index < 15\">\n                   <label>\n                     {{value}}\n                     <input type=\"checkbox\" ng-model=\"outputs['station'][value]\" ng-checked=\"outputs['station'][value]\"\nvalue=\"value\" ng-click=\"checkboxFilterByValue()\"/>\n                     <span></span>\n                   </label>\n                   <div style=\"clear:both;\"></div>\n                 </div>\n               </div>\n             </div>\n           </div>\n         </div>\n         <div class=\"col-sm-2 border-right border-left\">\n           <p><strong>Event Code</strong></p>\n           <div class=\"col-sm-12\">\n             <div class=\"row\">\n               <div ng-repeat=\"value in inputs.eventCode | limitTo:5\">\n                 <div>\n                   <label>\n                     {{value}}\n                     <input type=\"checkbox\" ng-model=\"outputs['station'][value]\" ng-checked=\"outputs['station'][value]\"\nvalue=\"value\" ng-click=\"checkboxFilterByValue()\"/>\n                     <span></span>\n                   </label>\n                   <div style=\"clear:both;\"></div>\n                 </div>\n               </div>\n             </div>\n           </div>\n         </div>\n         <div class=\"col-sm-2\">\n           <p><strong>Date</strong></p>\n           <form>\n             <div class=\"row input-group col-sm-12 datetimepicker\">\n               <input type=\"text\"\n               show-button-bar=\"false\"\n               show-weeks=\"false\"\n               datepicker-popup=\"{{format}}\"\n               ng-model=\"dt\"\n               is-open=\"openDate\"\n               min-date=\"minDate\"\n               max-date=\"'2015-06-22'\"\n               datepicker-options=\"dateOptions\"\n               date-disabled=\"disabled(date, mode)\"\n               close-text=\"Close\"\n               placeholder=\"MM/DD/YYYY\"\n               class=\"form-control\"\n               />\n               <span class=\"input-group-addon\", ng-click=\"openDatepicker($event)\"><i class=\"fa fa-calendar\"></i></span>\n             </div>\n             <div class=\"clearfix padding-bottom-medium margin-top col-sm-12\">\n               <a ng-click=\"selectDatRange=true\">Select a Date Range</a>\n             </div>\n             <div class=\"row input-group col-sm-12 datetimepicker\" ng-show=\"selectDatRange\">\n               <input type=\"text\"\n               show-button-bar=\"false\"\n               show-weeks=\"false\"\n               datepicker-popup=\"{{format}}\"\n               ng-model=\"dt2\"\n               is-open=\"openDate2\"\n               min-date=\"minDate\"\n               max-date=\"'2015-06-22'\"\n               datepicker-options=\"dateOptions\"\n               date-disabled=\"disabled(date, mode)\"\n               close-text=\"Close\"\n               placeholder=\"MM/DD/YYYY\"\n               class=\"form-control\"\n               />\n               <span class=\"input-group-addon\", ng-click=\"openDatepicker2($event)\"><i class=\"fa fa-calendar\"></i></span>\n             </div>\n           </form>\n         </div>\n         <div class=\"clearfix\"></div>\n       </section>\n     </div>\n\n\n     <div class=\"clearfix\">\n       <section class=\"col-md-9\">\n         <!-- span.pull-right(g4-pagination-navigation, current-page=\"currentPage\", total-pages=\"pageCount\", page-change=\"total\")-->\n         <!-- span.pull-right.margin-right.pagination-message(g4-pagination-message,\n              current-page=\"currentPage\",\n              page-size=\"pageCount\",\n              total-items=\"total\")-->\n         <div class=\"clearfix\"></div>\n       </section>\n     </div>",
        link: function(scope, element, attrs) {
          scope.filter_timeframe = '';
          scope.changeTimeFilter = function(val) {
            if (val.toLowerCase() === 'all') {
              return scope.filter_timeframe = '';
            } else {
              return scope.filter_timeframe = val;
            }
          };
          scope.mytime = new Date();
          scope.hstep = 1;
          scope.mstep = 15;
          scope.options = {
            hstep: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
            mstep: [1, 5, 10, 15, 25, 30]
          };
          scope.ismeridian = true;
          scope.toggleMode = function() {
            return scope.ismeridian = !scope.ismeridian;
          };
          scope.update = function() {
            var d;
            d = new Date();
            d.setHours(14);
            d.setMinutes(0);
            return scope.mytime = d;
          };
          scope.clear = function() {
            return scope.mytime = null;
          };
          scope.optionToLabel = function(searched_key) {
            var option, _i, _len, _ref;
            _ref = scope.options;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              option = _ref[_i];
              if (option.key === searched_key) {
                return option.label.toUpperCase();
              }
            }
            return '';
          };
          scope.filterByOption = function(new_option) {
            return typeof scope.filterBy === "function" ? scope.filterBy(scope.filter_value, new_option) : void 0;
          };
          scope.filterByValue = function(ev) {
            console.log(ev);
            if (ev.which === 13 || ev.which === 1) {
              return typeof scope.filterBy === "function" ? scope.filterBy(scope.filter_value, scope.filter_option) : void 0;
            }
          };
          scope.outputs = {
            station: {},
            eventCode: {}
          };
          if ($cookieStore.get('checkbox_values') !== void 0) {
            scope.outputs = $cookieStore.get('checkbox_values');
          }
          scope.inputs = {
            station: ['NON', 'EAST', 'WEST', 'HVY', 'SFB', 'PIE', 'FLL', 'PGD', 'LAS', 'LAX', 'ENV', 'AZA', 'HNL', 'BLI'],
            eventCode: ["AOS", "SOS", "HPR"]
          };
          scope.checkboxFilterByValue = function() {
            return scope.filterBy(scope.filter_value, scope.filter_option);
          };
          scope.openDatepicker = function(event) {
            event.preventDefault();
            event.stopPropagation();
            return scope.openDate = true;
          };
          scope.openDatepicker2 = function(event) {
            event.preventDefault();
            event.stopPropagation();
            return scope.openDate2 = true;
          };
          return scope.$watch("outputs", function() {
            return $cookieStore.put('checkbox_values', scope.outputs);
          }, true);
        }
      };
    }
  ]);

}).call(this);

(function() {
  "use strict";
  var listTable;

  listTable = angular.module("g4plus-list-table.directive", ["ui.bootstrap"]);

  listTable.directive("g4plusListTable", [
    "$filter", function($filter) {
      return {
        restrict: "A",
        templateUrl: "g4plus-list-table-template.html",
        transclude: false,
        scope: {
          options: "=g4plusListTable"
        },
        link: function(scope, el, attr) {
          scope.stationValues = [];
          scope.filterByStation = function(input) {
            return jQuery.inArray(input.station.toUpperCase(), scope.filterArr) !== -1;
          };
          scope.parseData = function(item, column) {
            var itemField, multipleColumns;
            if (column.field.indexOf('.') > -1) {
              multipleColumns = column.field.split('.');
              itemField = item[multipleColumns[0]][multipleColumns[1]];
            } else {
              itemField = item[column.field];
            }
            if (column.field.indexOf('ataCode') > -1) {
              itemField = item.ataCode[0].chapter + item.ataCode[0].section;
            }
            if (column.field != null) {
              if (column.filter) {
                if (column.filterData) {
                  return $filter([column.filter])(itemField, column.filterData);
                }
                return $filter(itemField)(itemField);
              } else {
                return itemField;
              }
            } else {
              return "";
            }
          };
          scope.hasAction = function(action) {
            var _ref, _ref1;
            return (_ref = scope.options) != null ? (_ref1 = _ref.actions) != null ? _ref1[action + "Action"] : void 0 : void 0;
          };
          scope.hasState = function(action) {
            var _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
            return ((_ref = scope.options) != null ? (_ref1 = _ref.actions) != null ? _ref1[action + "State"] : void 0 : void 0) && ((_ref2 = scope.options) != null ? (_ref3 = _ref2.actions) != null ? _ref3[action + "StateParam"] : void 0 : void 0) && !((_ref4 = scope.options) != null ? (_ref5 = _ref4.actions) != null ? _ref5[action + "Action"] : void 0 : void 0);
          };
          scope.hasLink = function(action) {
            var _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
            return ((_ref = scope.options) != null ? (_ref1 = _ref.actions) != null ? _ref1[action + "Link"] : void 0 : void 0) && !((_ref2 = scope.options) != null ? (_ref3 = _ref2.actions) != null ? _ref3[action + "Action"] : void 0 : void 0) && !((_ref4 = scope.options) != null ? (_ref5 = _ref4.actions) != null ? _ref5[action + "State"] : void 0 : void 0);
          };
          scope.setSortColumn = function(column) {
            var _ref, _ref1, _ref2;
            if ((scope != null ? (_ref = scope.options) != null ? _ref.sortColumn : void 0 : void 0) && (scope != null ? (_ref1 = scope.options) != null ? _ref1.sortColumn : void 0 : void 0) === column.field) {
              scope.options.sortDirection = (scope.options.sortDirection === "-" ? "" : "-");
            }
            scope.options.sortColumn = column.field;
            return (_ref2 = scope.options) != null ? typeof _ref2.onSortColumn === "function" ? _ref2.onSortColumn(scope.options.sortColumn, scope.options.sortDirection) : void 0 : void 0;
          };
          scope.hasSorting = function(column) {
            return column.sorting;
          };
          scope.getSortingClass = function(column) {
            if (((column != null ? column.field : void 0) != null) && scope.options.sortColumn === column.field) {
              return "icon-sort-" + (scope.options.sortDirection === "-" ? "down" : "up");
            } else {
              return "icon-sort";
            }
          };
          return scope.getColumnClass = function(column) {
            var columnClass;
            columnClass = (((column != null ? column.columnClass : void 0) != null) ? column.columnClass : "");
            if ((column != null ? column.sorting : void 0) && scope.options.sortColumn === column.field) {
              columnClass += ' col-control';
            }
            return columnClass;
          };
        }
      };
    }
  ]);

  listTable.run([
    "$templateCache", function($templateCache) {
      return $templateCache.put("g4plus-list-table-template.html", "<table ng-class=\"options.tableClass\" ng-show=\"options.items.length\">\n  <thead>\n    <tr class=\"header_bar\">\n      <th ng-repeat=\"column in options.columns\" ng-class=\"getColumnClass(column)\" scope=\"col\">{{ column.title }}\n        <a href=\"javascript:void(0);\" ng-if=\"hasSorting(column)\" ng-click=\"setSortColumn(column)\">\n          <i ng-class=\"getSortingClass(column)\"></i>\n        </a>\n      </th>\n      <th ng-if=\"options.actions\" class=\"actions medium\" scope=\"col\"></th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr ng-repeat=\"item in options.items\">\n      <td ng-repeat=\"column in options.columns\" ng-class=\"column.cellClass\">\n        <a ng-click, href=\"/#/view/{{item.id}}\">{{ parseData(item, column) }}</a>\n      </td>\n      <td ng-if=\"options.actions\" class=\"actions\">\n        <div class=\"clearfix\">\n          <a class=\"pull-right margin-left text-muted text-delete\"\n             ng-if=\"hasAction('delete')\"\n             ng-click=\"options.actions.deleteAction(item)\">\n            <i class=\"fa g4-icon-trash\"></i> Delete\n          </a>\n          <a class=\"pull-right margin-left text-muted text-delete\"\n             ng-if=\"hasLink('delete')\"\n             ng-href=\"{{ options.actions.deleteLink + item.id }}\">\n            <i class=\"fa g4-icon-trash\"></i> Delete\n          </a>\n          <a class=\"pull-right margin-left text-muted text-delete\"\n             ng-if=\"hasState('delete')\"\n             ui-sref=\"{{ options.actions.deleteState + '({' + options.actions.deleteStateParam + ': item.id })' }}\">\n            <i class=\"fa g4-icon-trash\"></i> Delete\n          </a>\n          <a class=\"pull-right primary margin-left\"\n             ng-if=\"hasAction('edit')\"\n             ng-click=\"options.actions.editAction(item)\">\n            <i class=\"fa g4-icon-edit\"></i> Edit\n          </a>\n          <a class=\"pull-right primary margin-left\"\n             ng-if=\"hasLink('edit')\"\n             ng-href=\"{{ options.actions.editLink + item.id }}\">\n            <i class=\"fa g4-icon-edit\"></i> Edit\n          </a>\n          <a class=\"pull-right primary margin-left\"\n             ng-if=\"hasState('edit')\"\n             ui-sref=\"{{ options.actions.editState + '({' + options.actions.editStateParam + ': item.id })' }}\">\n            <i class=\"fa g4-icon-edit\"></i> Edit\n          </a>\n          <a class=\"pull-right margin-left text-muted text-view\"\n             ng-if=\"hasAction('view')\"\n             ng-click=\"options.actions.viewAction(item)\">\n            <i class=\"fa g4-icon-view\"></i> View\n          </a>\n          <a class=\"pull-right margin-left text-muted text-view\"\n             ng-if=\"hasLink('view')\"\n             ng-href=\"{{ options.actions.viewLink + item.id }}\">\n            <i class=\"fa g4-icon-view\"></i> View\n          </a>\n          <a class=\"pull-right margin-left text-muted text-view\"\n             ng-if=\"hasState('view')\"\n             ui-sref=\"{{ options.actions.viewState + '({' + options.actions.viewStateParam + ': item.id })' }}\">\n            <i class=\"fa g4-icon-view\"></i> View\n          </a>\n        </div>\n      </td>\n    </tr>\n  </tbody>\n</table>\n<p class=\"clearfix alert alert-warning margin-left margin-right margin-top\"\n   ng-show=\"!options.items.length && options.noItemsFoundMessage\">\n  {{ options.noItemsFoundMessage }}\n  <a href=\"javascript:void(0);\" ng-click=\"options.resetFilter()\" ng-show=\"options.resetFilter\">\n   clear filter <i class=\"icon-remove\"></i>\n  </a>\n</p>");
    }
  ]);

}).call(this);

(function() {
  'use strict';
  var superList;

  superList = angular.module('g4plus-super-list', ['ui.bootstrap', 'g4plus-list-table.directive', 'g4plus.pagination', 'g4plus.list-filter', 'g4plus.autofocus', 'g4plus.load-component']);

  superList.directive('g4plusSuperList', [
    '$filter', '$timeout', '$compile', '$cookieStore', function($filter, $timeout, $compile, $cookieStore) {
      return {
        restrict: 'A',
        templateUrl: 'g4plus-super-list.html',
        transclude: true,
        scope: {
          service: '=g4Service',
          actions: '=g4Actions',
          columns: '=g4Columns',
          filters: '=g4Filters',
          params: '=g4Params',
          updateUrl: '=g4UpdateUrl',
          successCall: '=g4Success',
          errorCall: '=g4Error'
        },
        link: function(scope, element, attrs) {
          var elm, loadId, loadType, _ref, _ref1, _ref2;
          loadId = scope != null ? (_ref = scope.service) != null ? _ref.loadId : void 0 : void 0;
          loadType = (scope != null ? (_ref1 = scope.service) != null ? _ref1.loadType : void 0 : void 0) ? scope.service.loadType : 'progress';
          if (scope != null ? (_ref2 = scope.service) != null ? _ref2.loadId : void 0 : void 0) {
            elm = $compile('<div load-component load-id="' + loadId + '" load-type="' + loadType + '"></div>')(scope);
            return element.append(elm);
          }
        },
        controller: function($scope) {
          var _error, _filterItems, _getQueryPrams, _loadList, _loadListHttp, _loadListPromise, _loadListResource, _loadListSimple, _serviceTypes, _setSorting, _success, _updateUrl, _validateParams;
          _serviceTypes = ['array', 'promise', 'resource', 'http'];
          if (!$scope.service) {
            $scope.service = {
              type: _serviceTypes[0]
            };
          }
          $scope.queryInProgress = true;
          _updateUrl = function() {
            if (angular.isFunction($scope.updateUrl)) {
              return $scope.updateUrl();
            }
          };
          _validateParams = function() {
            var col, filter, sortColumn, sortDirection, sorting, _before, _i, _j, _len, _len1, _pagination, _ref, _ref1, _results;
            _before = angular.copy($scope.params);
            if (!$scope.params) {
              $scope.params = {};
            }
            if (!$scope.params.pagination) {
              $scope.params.pagination = {};
            }
            _pagination = $scope.params.pagination;
            if (isNaN(parseInt(_pagination.page, 10))) {
              _pagination.page = 1;
            }
            if (isNaN(parseInt(_pagination.pageSize, 10))) {
              _pagination.pageSize = 10;
            }
            _pagination.page = Math.max(1, _pagination.page);
            _pagination.pageSize = Math.max(10, _pagination.pageSize);
            if (!angular.equals(_before, $scope.params)) {
              _updateUrl();
            }
            sorting = $scope.params.sorting;
            sortColumn = '';
            sortDirection = '';
            if (sorting) {
              if (sorting[0] === '-') {
                sortColumn = sorting.substring(1);
                sortDirection = '-';
              } else {
                sortColumn = sorting;
                sortDirection = '';
              }
            }
            _ref = $scope.columns;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              col = _ref[_i];
              if (col.sorting && col.sortingField && col.sortingField === sortColumn) {
                sortColumn = col.field;
                break;
              }
            }
            $scope.tableOptions.sortColumn = sortColumn;
            $scope.tableOptions.sortDirection = sortDirection;
            $scope.filterState.optionList = [];
            _ref1 = $scope.filters;
            _results = [];
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              filter = _ref1[_j];
              if (filter.visible && filter.key && filter.label) {
                _results.push($scope.filterState.optionList.push({
                  key: filter.key,
                  label: filter.label
                }));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          };
          _setSorting = function(column, direction) {
            var col, sortField, _i, _len, _ref;
            sortField = column;
            _ref = $scope.columns;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              col = _ref[_i];
              if (col.sorting && col.sortingField && col.field && col.field === column) {
                sortField = col.sortingField;
                break;
              }
            }
            $scope.params.sorting = direction + sortField;
            $scope.params.pagination.page = 1;
            return _updateUrl();
          };
          $scope.filterState = {
            optionList: [],
            filterBy: function(value, option) {
              $scope.params.filters.filter_value = value;
              $scope.params.filters.filter_option = option;
              _updateUrl();
              return _loadList();
            },
            resetFilter: function() {
              var checkboxFilters, key;
              angular.forEach($scope.params.filters, function(value, key) {
                return $scope.params.filters[key] = '';
              });
              $scope.params.filters.filter_option = '_all';
              $scope.params.pagination.page = 1;
              checkboxFilters = $cookieStore.get('checkbox_values');
              for (key in checkboxFilters) {
                checkboxFilters[key] = {};
              }
              $cookieStore.put('checkbox_values', checkboxFilters);
              console.log($cookieStore.get('checkbox_values'));
              return _updateUrl();
            }
          };
          $scope.tableOptions = {
            items: [],
            noItemsFoundMessage: 'There are no entries that matched the filter.',
            resetFilter: $scope.filterState.resetFilter,
            tableClass: 'table-lined',
            actions: $scope.actions,
            columns: $scope.columns,
            onSortColumn: _setSorting
          };
          $scope.pagination = {
            totalItems: 0,
            totalPages: 0,
            pageSizeChange: function(pageSize) {
              $scope.params.pagination.page = 1;
              $scope.params.pagination.pageSize = pageSize;
              return $scope.updateUrl();
            },
            pageChange: function(page) {
              $scope.params.pagination.page = page;
              return $scope.updateUrl();
            }
          };
          _filterItems = function(input, value, option) {
            var checkbox_values, checkbox_values_match, checkbox_values_selected, each_value, filter_checkbox, filter_column, filteredOutput, i, key, newOutput, output, sub_key, textfieldOutput;
            output = input;
            if (value && value.length) {
              if (option && option !== '_all') {
                filter_column = {};
                filter_column[option] = value;
                output = $filter('filter')(input, filter_column);
              } else {
                output = $filter('filter')(input, value);
              }
            }
            checkbox_values = $cookieStore.get('checkbox_values');
            textfieldOutput = output;
            for (key in checkbox_values) {
              filter_checkbox = {};
              each_value = checkbox_values[key];
              newOutput = [];
              for (sub_key in each_value) {
                checkbox_values_selected = false;
                if (each_value[sub_key] === true) {
                  checkbox_values_match = false;
                  checkbox_values_selected = true;
                  filter_checkbox[key] = sub_key;
                  filteredOutput = $filter('filter')(textfieldOutput, filter_checkbox);
                  i = 0;
                  while (i < filteredOutput.length) {
                    if (newOutput.indexOf(filteredOutput[i]) === -1) {
                      newOutput.push(filteredOutput[i]);
                      checkbox_values_match = true;
                    }
                    i++;
                  }
                }
              }
              if (newOutput.length === 0 && checkbox_values_match !== false) {
                newOutput = textfieldOutput;
              }
              textfieldOutput = newOutput;
              output = newOutput;
            }
            return output;
          };
          _success = function(data, status, header, config) {
            var fromItem, items, sortColumn, sortDirection, toItem, total, visibleItems, _filters, _ref;
            items = [];
            visibleItems = [];
            total = 0;
            if (angular.isArray(data != null ? data.items : void 0)) {
              items = data.items;
              total = data.total;
            } else if (angular.isArray(data)) {
              items = data;
              total = data.length;
            }
            if (items && !$scope.service.hasSorting) {
              sortColumn = $scope.tableOptions.sortColumn;
              sortDirection = (((_ref = $scope.tableOptions) != null ? _ref.sortDirection : void 0) === '-' ? true : false);
              if ($scope.tableOptions.sortColumn) {
                items = $filter('orderBy')(items, sortColumn, sortDirection);
              }
            }
            if (items && !$scope.service.hasFiltering) {
              _filters = $scope.params.filters;
              angular.forEach($scope.filters, function(filter) {
                var filter_data;
                if (filter.key) {
                  if ((filter.type === 'strict' || filter.type === 'field') && (_filters != null ? _filters[filter.key] : void 0)) {
                    filter_data = {};
                    filter_data[filter.key] = _filters[filter.key];
                    return items = $filter('filter')(items, filter_data, 'strict');
                  } else if (filter.type === 'keyword' && (_filters != null ? _filters.filter_option : void 0) === filter.key) {
                    return items = _filterItems(items, _filters.filter_value, _filters.filter_option);
                  }
                }
              });
              total = items.length;
            }
            if (items && !$scope.service.hasPagination) {
              fromItem = ($scope.params.pagination.page - 1) * $scope.params.pagination.pageSize;
              toItem = $scope.params.pagination.page * $scope.params.pagination.pageSize;
              items = items.slice(fromItem, toItem);
            }
            $scope.tableOptions.items = items;
            $scope.pagination.totalItems = total;
            $scope.pagination.totalPages = Math.ceil(total / $scope.params.pagination.pageSize);
            if ($scope.params.pagination.page > 1 && $scope.params.pagination.page > $scope.pagination.totalPages) {
              $scope.params.pagination.page = $scope.pagination.totalPages;
              $scope.updateUrl();
            }
            $scope.queryInProgress = false;
            if (angular.isFunction($scope.successCall)) {
              return $scope.successCall(data, status, header, config);
            }
          };
          _error = function(data, status, header, config) {
            $scope.queryInProgress = false;
            $scope.tableOptions.items = [];
            $scope.pagination.totalItems = 0;
            $scope.pagination.totalPages = 0;
            if (angular.isFunction($scope.errorCall)) {
              return $scope.errorCall(data, status, header, config);
            }
          };
          _loadListSimple = function(data) {
            return _success(data);
          };
          _loadListPromise = function(promise) {
            if (promise) {
              return promise.then(_success, _error);
            }
          };
          _getQueryPrams = function() {
            var params, _filters;
            params = {};
            if ($scope.service.hasFiltering) {
              params.filter = '';
              _filters = $scope.params.filters;
              angular.forEach($scope.filters, function(filter) {
                if (filter.key) {
                  if (filter.type === 'strict' && (_filters != null ? _filters[filter.key] : void 0)) {
                    if (filter.prefix) {
                      return params.filter += filter.prefix + (_filters != null ? _filters[filter.key] : void 0);
                    } else {
                      return params.filter += '|' + filter.key + '::' + (_filters != null ? _filters[filter.key] : void 0);
                    }
                  } else if (filter.type === 'field' && (_filters != null ? _filters[filter.key] : void 0)) {
                    return params[filter.key] = _filters[filter.key];
                  } else if (filter.type === 'keyword' && _filters.filter_option === filter.key && _filters.filter_value) {
                    if (filter.prefix) {
                      return params.filter += filter.prefix + _filters.filter_value;
                    } else {
                      return params.filter += '|' + filter.key + '::' + _filters.filter_value;
                    }
                  }
                }
              });
            }
            if ($scope.service.hasSorting && $scope.params.sorting) {
              params.sort = $scope.params.sorting;
            }
            if ($scope.service.hasPagination) {
              params.page = $scope.params.pagination.page;
              params.limit = $scope.params.pagination.pageSize;
            }
            return params;
          };
          _loadListResource = function(resource) {
            var params, _ref;
            params = _getQueryPrams();
            return _loadListPromise(typeof resource === "function" ? (_ref = resource(params)) != null ? _ref.$promise : void 0 : void 0);
          };
          _loadListHttp = function(httpCall) {
            var params;
            params = _getQueryPrams();
            return httpCall(params, _success, _error);
          };
          _loadList = function() {
            var data, _ref;
            $scope.queryInProgress = true;
            _validateParams();
            data = (_ref = $scope.service) != null ? _ref.data : void 0;
            switch ($scope.service.type) {
              case 'array':
                return _loadListSimple(data);
              case 'promise':
                return _loadListPromise(data != null ? data.$promise : void 0);
              case 'resource':
                return _loadListResource(data);
              case 'http':
                return _loadListHttp(data);
              default:
                return _loadListSimple(data);
            }
          };
          $scope.$on('SuperList:reload', function(event, e) {
            return _loadList();
          });
          return _loadList();
        }
      };
    }
  ]);

  superList.run([
    '$templateCache', function($templateCache) {
      return $templateCache.put('g4plus-super-list.html', '<form class="table-tools form-horizontal row no-left-padding no-right-padding">\n  <fieldset>\n    <div class="pull-right margin-right"\n         g4-list-filter=""\n         g4-filter-options="filterState.optionList"\n         g4-filter-by="filterState.filterBy"\n         g4-filter-value="params.filters.filter_value"\n         g4-filter-option="params.filters.filter_option">\n    </div>\n  </fieldset>\n</form>\n\n<button class="btn btn-action btn-solid btn_export">\n  <i class="fa fa-download">&nbsp;&nbsp;</i><span>Export Results</span>\n</button>\n\n<div class="pagination row pad-left pad-right pull-right col-md-4" ng-hide="queryInProgress">\n  <div class="col-md-6 pull-right"\n       g4-pagination-message=""\n       current-page="params.pagination.page"\n       page-size="params.pagination.pageSize"\n       total-items="pagination.totalItems">\n  </div>\n  <div class="col-md-6"\n       g4-pagination-navigation=""\n       current-page="params.pagination.page"\n       total-pages="pagination.totalPages"\n       page-change="pagination.pageChange">\n  </div>\n</div>\n\n<div g4plus-list-table="tableOptions" ng-hide="queryInProgress"></div>\n\n<div class="pagination row pad-left pad-right pull-right col-md-4" ng-hide="queryInProgress">\n  <div class="col-md-6 pull-right"\n       g4-pagination-message=""\n       current-page="params.pagination.page"\n       page-size="params.pagination.pageSize"\n       total-items="pagination.totalItems">\n  </div>\n  <div class="pagination col-md-6"\n       g4-pagination-navigation=""\n       current-page="params.pagination.page"\n       total-pages="pagination.totalPages"\n       page-change="pagination.pageChange">\n  </div>\n</div>');
    }
  ]);

}).call(this);
var version = "0.0.1";var appCode ="os"