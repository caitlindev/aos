directives = angular.module 'g4plus.directives', []

directives.directive "g4Routing", () ->
  restrict: "A"
  scope:
    listData:"=listData"
  templateUrl: 'src/app/ui_flow/g4plus-directives/src/routing.jade'
  link: (scope, element, attrs) ->
    scope.$watch "listData", () ->
      if scope.listData
        if scope.listData.flightInfo
          event = scope.listData.flightInfo.routes[2].currentInfo

          scope.popoverHtml = """
          <strong class='col-sm-6 text-left'>Code:</strong>
          <div class='col-sm-6 text-left'>""" + event.code + """</div>
          <strong class='col-sm-6 text-left'>Flight:</strong>
          <div class='col-sm-6 text-left'>""" + event.flightNbr + """</div>
          <strong class='col-sm-6 text-left'>Altitude:</strong>
          <div class='col-sm-6 text-left'>""" + event.altitude + """ ft</div>
          <strong class='col-sm-6 text-left'>Airspeed:</strong>
          <div class='col-sm-6 text-left'>""" + event.airspeed + """ mph</div>
          <strong class='col-sm-6 text-left'>ETA:</strong>
          <div class='col-sm-6 text-left'>""" + moment.unix(event.ETA).format("HH:MM") + """ GMT</div>
          <div class="clearfix"></div>
          """

          scope.live_flight_data = scope.popoverHtml

          # Fligh days (14 days before, 14 days after) - for now 1 day before, 1 day after
          scope.flightDays = [
            [
              {
                station: 'HNL'
                time: '12:00'
              }
              {
                station: 'LAS'
                time: '12:00'
              }
              {
                station: 'MFE'
                time: '12:00'
              }
              {
                station: 'LAS'
                time: '12:00'
              }
            ]
            [
              {
                station: 'GFK'
                time: '08:00'
              }
              {
                station: 'LAS'
                time: '11:00'
              }
              {
                station: 'MFE'
                time: '16:00'
              }
              {
                station: 'LAS'
                time: '18:00'
              }
              {
                station: 'AUS'
                time: '20:00'
              }
            ]
            [
              {
                station: 'LAS'
                time: '12:00'
              }
              {
                station: 'MFE'
                time: '12:00'
              }
              {
                station: 'LAS'
                time: '12:00'
              }
              {
                station: 'IND'
                time: '12:00'
              }
              {
                station: 'LAS'
                time: '12:00'
              }
            ]
          ]

          # set current day active
          scope.currentFlightIndex = 1 # to be determined dynamically
          scope.flightDays[scope.currentFlightIndex].active = true

          # determine how many green bullets are
          greenBullets = 2 # to be determined dynamically
          bulletsColor = {}
          i = 0
          while (i < greenBullets)
            bulletsColor[i] = 'green'
            i++
          # after green bullets there is the red one
          bulletsColor[i] = 'red'

          _getPercentage = (index, total) ->
            return index * (100 / (total-1)).toFixed(2)

          # set bullet classes only for current day
          scope.bulletClass = (parentIndex, index) ->
            if parentIndex == scope.currentFlightIndex
              if bulletsColor[index]
                return bulletsColor[index]
            return ""

          # set bullet positions
          scope.bulletPosition = (index, total) ->
            return { left: _getPercentage(index, total) + "%"}

          scope.greenTrackWidth = (total) ->
            return { width: _getPercentage(greenBullets, total) + "%"}

          scope.redTrackPosition = (total) ->
            return { left: _getPercentage(greenBullets, total) + "%", width: "56px"}

          scope.aircraftPosition = (total) ->
            return { left: (_getPercentage(greenBullets, total) + 5) + "%"}

          scope.today = () ->
            scope.dt = new Date()
            scope.dt2 = new Date()

          scope.today()
          scope.clear = () ->
            scope.dt = null
            scope.dt2 = null

      #
      #    # Disable weekend selection
      #    scope.disabled = (date, mode) ->
      #      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

          scope.toggleMin = ->
            scope.minDate = (if scope.minDate then null else new Date())
            return

          scope.toggleMin()
          scope.open = ($event) ->
            $event.preventDefault()
            $event.stopPropagation()
            scope.opened = true
            return

          scope.dateOptions =
            formatYear: "yy"
            startingDay: 1

          scope.initDate = new Date("2016-15-20")
          scope.formats = [
            "dd-MMMM-yyyy"
            "yyyy/MM/dd"
            "dd.MM.yyyy"
            "shortDate"
          ]
          scope.format = scope.formats[0]






directives.filter "g4DateFormat", () ->

  format = (timestamp, type, formatting) ->
    if type == "duration"

      duration = moment.duration(timestamp, "seconds")._data

      newMinutes = duration.minutes
      newSeconds = duration.seconds
      if duration.minutes.toString().length == 1
        newMinutes = "0" + duration.minutes.toString()

      if duration.seconds.toString().length == 1
        newSeconds = "0" + duration.seconds.toString()


      formattedTime = "#{duration.hours}:#{newMinutes}:#{newSeconds}"
      if duration.days > 0
        formattedTime = "#{duration.days}d " + formattedTime

      if duration.months > 0
        formattedTime = "#{duration.months}m " + formattedTime

      if duration.years > 0
        formattedTime = "#{duration.years}y " + formattedTime

#      spinTime(timestamp, type, formatting)

      return formattedTime

    return moment.unix(timestamp).format(formatting)

  return format

directives.directive "g4UnixTimestampConverter", () ->
  restrict: "A"
  scope: {
    formatting: "@formatting"
    durationOrConversion: "@durationOrConversion"
    timestamp: "=timestamp"
  }
  template:  "<span>{{ timestamp | g4DateFormat:durationOrConversion:formatting }}</span>"
  link: (scope, element, attrs) ->







directives.directive "g4AosIndicators", () ->
  restrict: "A"
  scope: {
    listData: "=listData"
  }
  link: (scope, element, attrs) ->

    scope.pulse = (el) ->
      $(el).delay(1200).animate({opacity:0}).delay(50).animate({opacity:1}, () ->
        scope.pulse($(el))
      )

    scope.$watch "listData", () ->
      if scope.listData
        if scope.listData.flightInfo.routes[2]

          reasons = scope.listData.flightInfo.routes[2].departureInfo.status
          scope.eventType = scope.listData.type

          currentTimeUnix = currentTime = moment().unix()
          advisoryTimeUnix = parseInt scope.listData.advisoryUnixTimestamp

          durationInMilSec = moment.duration(advisoryTimeUnix - currentTimeUnix, 'seconds')._milliseconds
          tenMin2mSec = 600

          if durationInMilSec <= tenMin2mSec
            element.append("<i class='indicators time10'></i>")

          createdTimeUnix = scope.listData.createdUnixTimestamp
          durationInMilSec = moment.duration(currentTimeUnix - createdTimeUnix, 'seconds')._milliseconds
          eighteenHours2mSec = 64800000
          eigthHours2mSec = 28800000

          if durationInMilSec >= eighteenHours2mSec
            element.append("<i class='indicators time18'></i>")

          if durationInMilSec >= eigthHours2mSec && durationInMilSec < eighteenHours2mSec
            element.append("<i class='indicators time8'></i>")

          if scope.eventType.toUpperCase()=="MCO"

            element.append("<i class='indicators mco'></i>")

            scope.pulse($('.mco'))

          #check advisory time is within 1 hour of next flight departure
          departureTimestamp = parseInt scope.listData.flightInfo.routes[2].departureInfo.scheduledDepartureUnixTimestamp
          oneHr2mSec = 3600

          if (departureTimestamp - currentTimeUnix) < oneHr2mSec && departureTimestamp > currentTimeUnix
            $(element).parents('.eventList').find('.dashboard_flight_info').prepend('<span>TIME</span><br>')

          if advisoryTimeUnix >= (departureTimestamp - oneHr2mSec) && advisoryTimeUnix < departureTimestamp
            $(element).parents('.eventList').find('.dashboard_flight_info').addClass('alert flashing_flight_info')
            $('.view_flight_info').addClass('alert flashing_flight_info')

            scope.pulse($('.eventList .alert, #view_info .alert.flashing_flight_info'))

          if advisoryTimeUnix > departureTimestamp
            $(element).parents('.eventList').find('.dashboard_adv_time').addClass('alert flashing_adv_time text-center')

            scope.pulse($('.eventList .alert, #view_info .alert.flashing_adv_time'))


          if scope.listData.flightInfo != undefined
            reasons = scope.listData.flightInfo.routes[2].currentInfo.status

            if scope.listData.roadTrip != undefined
              element.append("<i class='indicators roadTrip'></i>")

            if reasons.cancellation==true
              element.append("<i class='indicators cancellation'></i>")

            if reasons.rejectedTakeOff==true
              element.append("<i class='indicators rejectedTakeOff'></i>")

            if reasons.gateReturn==true
              element.append("<i class='indicators gateReturn'></i>")

            if reasons.diversion==true
              element.append("<i class='indicators diversion'></i>")

            if reasons.safetySignificantEvent==true
              element.append("<i class='indicators safetySignificantEvent'></i>")



angular.module("template/carousel/carousel.html", []).run [
  "$templateCache"
  ($templateCache) ->
    $templateCache.put "template/carousel/carousel.html",
      "<div ng-mouseenter=\"pause()\" ng-mouseleave=\"play()\" class=\"carousel\">\n" +
      "    <ol class=\"carousel-indicators\" ng-show=\"slides().length > 1\">\n" +
      "        <li ng-repeat=\"slide in slides()\" ng-class=\"{active: isActive(slide)}\" ng-click=\"select(slide)\"></li>\n" +
      "    </ol>\n" +
      "    <div class=\"carousel-inner\" ng-transclude></div>\n" +
      "    <a class=\"left carousel-control\" ng-click=\"prev()\" ng-show=\"slides().length > 1\">" +
      "        <span class=\"fa fa-angle-left\"></span></a>\n" +
      "    <a class=\"right carousel-control\" ng-click=\"next()\" ng-show=\"slides().length > 1\">" +
      "        <span class=\"fa fa-angle-right\"></span></a>\n" +
      "</div>\n" +
      ""
]


