mapbox = angular.module 'g4plus-mapbox.directive', [ ]

mapbox.directive "g4Mapbox", ( $timeout ) ->
  scope: {
    mapFilters: "=?"
    refreshMap: "=?"
    stationRoutes: "=?"
    stationFilters: "=?"
    flightData: "=?"
    eventCodes: "=?"
    eventFilters: "=?"
    dateTimeFilters: "=?"
    tailNumbers: "=?"
    mapHost: "=?"
  }
  restrict: "A"
  template: '<div id="dashboard_map"></div>'
  link: (scope, element, attrs, ctrl, transclude) ->
    # Add Map
#    scope.host = "http://lhq001devap03.001.allegiantair.com:3000"
    scope.host = (if typeof scope.mapHost is 'undefined' or scope.mapHost is null then 'http://localhost:3333' else scope.mapHost)
    # console.log(scope.host)
    scope.mapMetadataUrl = scope.host + "/api/mapbox/airports.json"
    scope.tileJSON = scope.map = []
    metadataJSON = $.getJSON(scope.mapMetadataUrl, (data) ->
      metadataJSON["legend"] = data["legend"]
      metadataJSON["legendControl"] = position: "topleft"
      metadataJSON["zoomControl"] = position: "bottomright"
      metadataJSON["template"] = data["template"]
      metadataJSON["minzoom"] = data["minzoom"]
      metadataJSON["maxzoom"] = data["maxzoom"]
      metadataJSON["tiles"] = [
          scope.host + "/api/mapbox/airports/{z}/{x}/{y}.png"
      ]
      metadataJSON["grids"] = [
          scope.host + "/api/mapbox/airports/{z}/{x}/{y}.grid.json"
      ]
      metadataJSON["tilejson"] = "2.0.0"
    )
    scope.tileJSON = metadataJSON

#    # legendFilterGen
#    # ---------------
#    # Generate Filter Boxes for inclusion in the Legend.
#    # * @param {obj}  jsondict stationFilters
#    legendFilterGen = (obj, modelName, idName) ->
#      filterFragment = ''
#      for item in obj
#        filterFragment += '''
#          <li class="checkbox"><input type="checkbox" id="''' + idName + '''-''' + item.name + '''" class="input-sm" ng-model="''' + modelName + '''" ng-true-value="''' + item.name + '''" />
#          <label for="''' + idName + '''-''' + item.name + '''">''' + item.name + '''</label></li>'''
#      console.log filterFragment
#      return filterFragment


    # aircraftBearing
    # ---------------
    # Will calculate the bearing and angle between src and dst airports based on lat and long
    # * @param {x1}  destination airport latitude
    # * @param {y1}  destination airport longitude
    # * @param {x2}  source airport latitude
    # * @param {y2}  source airport longitude
    aircraftBearing = (x1,y1,x2,y2) ->
      radians = Math.atan2((y1 - y2), (x1 - x2))
      compassReading = radians * (180 / Math.PI)
      coordNames = [ "N","NE","E","SE","S","SW","W","NW","N" ]
      coordIndex = Math.round(compassReading / 45)
      coordIndex = coordIndex + 8  if coordIndex < 0
      bearing: coordNames[coordIndex]
      angle: compassReading

    # arcifyRoute
    # -----------
    # Takes in a flightData JSON object and returns a set of coordinates for drawing an arc
    # * @param {obj}  jsondict flightData JSON object to generate an arc from
    arcifyRoute = (jsondict) ->
      v = jsondict
      # Build start, middle, end coordinate sets
      start = { x: v.departureInfo.airportLong, y: v.departureInfo.airportLat }
      middle = { x: v.currentInfo.long, y: v.currentInfo.lat }
      end = { x: v.arrivalInfo.airportLong, y: v.arrivalInfo.airportLat }

      # Generate start to midpoint
      genCompleted = new GreatCircle(start, middle, { name: 'Route completed' })
      genCompletedArc = genCompleted.Arc(20, { offset: 10 })
      routeCompleted = genCompletedArc.geometries[0].coords

      # Generate midpoint to end
      genToGo = new GreatCircle(middle, end, { name: 'Route to go' })
      genToGoArc = genToGo.Arc(20, { offset: 10 })
      routeToGo = genToGoArc.geometries[0].coords

      # Put 2 halves of route together
      routeAsCurve = routeCompleted.concat routeToGo

      return routeAsCurve



    # toGeoJSON
    # ---------
    # Takes in a flightData JSON object and produces a GeoJSON formatted object
    # * @param {obj}  jsondict flightData JSON object to convert
    toGeoJSON = (jsondict) ->
      v = jsondict

      routeAsCurve = arcifyRoute(v)

      return {
      type: "FeatureCollection"
      features: [
        {
          type: "Feature"
          properties:
            name: "Flight: " + v.currentInfo.flightNbr
            description: "Route: " + v.departureInfo.scheduledDepartureAirportCode + " -> " + v.arrivalInfo.scheduledArrivalAirportCode
            stroke: "#008000"
          geometry:
            type: "LineString"
            properties:
              stroke: "#008000"
            coordinates: routeAsCurve
        }
        {
          type: "Feature"
          properties:
            name: "Tail: " + v.currentInfo.tailNbr
            code: v.currentInfo.code
            flightNbr: v.currentInfo.flightNbr
            scheduledDepartureAirportCode: v.departureInfo.scheduledDepartureAirportCode
            scheduledArrivalAirportCode: v.arrivalInfo.scheduledArrivalAirportCode
            scheduledDepartureUnixTimestamp: v.departureInfo.scheduledDepartureUnixTimestamp
            scheduledArrivalUnixTimestamp: v.arrivalInfo.scheduledArrivalUnixTimestamp
            altitude: v.currentInfo.altitude
            airspeed: v.currentInfo.airspeed
            ETA: v.currentInfo.ETA
            heading: aircraftBearing(v.currentInfo.lat, v.currentInfo.long, v.arrivalInfo.airportLat, v.arrivalInfo.airportLong)
            description: "Flying " + v.currentInfo.flightNbr + " from " + v.departureInfo.scheduledDepartureAirportCode + " to " + v.arrivalInfo.scheduledArrivalAirportCode
            icon:
              iconUrl: "/img/airplane-marker.png"
              iconSize: [44, 44]
              iconAnchor: [25, 25]
              popupAnchor: [0, -30]
              className: "tailMarker"
          geometry:
            type: "Point"
            coordinates: [
              v.currentInfo.long
              v.currentInfo.lat
            ]
        }
      ]
      }

    # filterRoutes
    # ------------
    # Filter Routes List to the Short Code as a departure or destination airport
    # * @param {string}   shortcode Airport Short Code to filter by
    filterRoutes = (shortcode, date) ->
      scope.routesList = []
      scope.shortcode = shortcode
      # console.log("Shortcode filtering on: " + shortcode)

      if date
        angular.forEach scope.flightData, (v, k) ->
          if ((moment.unix(v.arrivalInfo.scheduledArrivalUnixTimestamp).format("YYYY-MM-DD").toString() is moment(date).format("YYYY-MM-DD").toString() or moment.unix(v.departureInfo.scheduledDepartureUnixTimestamp).format("YYYY-MM-DD").toString() is moment(date).format("YYYY-MM-DD").toString()) and
          (v.departureInfo.scheduledDepartureAirportCode is scope.shortcode or v.arrivalInfo.scheduledArrivalAirportCode is scope.shortcode))
            route = toGeoJSON(v)
            scope.routesList.push(route)
          return

      else
        angular.forEach scope.flightData, (v, k) ->
          if v.departureInfo.scheduledDepartureAirportCode is scope.shortcode or v.arrivalInfo.scheduledArrivalAirportCode is scope.shortcode
            route = toGeoJSON(v)
            scope.routesList.push(route)
          return
      return

    # filterEvents
    # ------------
    # Filter Routes List to the Event Code
    # * @param {string}   eventcode Event Code to filter by
    filterEvents = (eventcode, date) ->
      scope.routesList = []
      scope.eventcode = eventcode.toLowerCase()
      # console.log("Filtering on eventcode: " + eventcode)

      if date
        angular.forEach scope.flightData, (v, k) ->
          if ((moment.unix(v.arrivalInfo.scheduledArrivalUnixTimestamp).format("YYYY-MM-DD").toString() is moment(date).format("YYYY-MM-DD").toString() or moment.unix(v.departureInfo.scheduledDepartureUnixTimestamp).format("YYYY-MM-DD").toString() is moment(date).format("YYYY-MM-DD").toString()) and
          (v.eventCode.toLowerCase() is scope.eventcode))
            route = toGeoJSON(v)
            scope.routesList.push(route)
          return
      else
        angular.forEach scope.flightData, (v, k) ->
          if v.eventCode.toLowerCase() is scope.eventcode
            route = toGeoJSON(v)
            scope.routesList.push(route)
          return
      return

    # filterPlanes
    # ------------
    # Filter Routes by tailNbr
    # * @param {string}   tailnumber Airplane Tail Number to filter by
    filterPlanes = (tailnumber) ->
      scope.routesList = []
      scope.tailnumber = tailnumber.toLowerCase()
      # console.log("Filtering on tailnumber: " + tailnumber)

      angular.forEach scope.flightData, (v, k) ->
        if v.tailNbr.toLowerCase() is scope.tailnumber
          route = toGeoJSON(v)
          scope.routesList.push(route)
        return

      return

    # renderRoutesToMap
    # -----------------
    # Render the Given Routes to the Map
    renderRoutesToMap = (value, routetype) ->
      if value
        # Fallback if flightdata is missing.
        if scope.flightData.length < 1
          LoadTestData()
        if routetype == "stations"
          filterRoutes(value, scope.dt)
        else if routetype == "tails"
          filterPlanes(value, scope.dt)
        else if routetype == "codes"
          filterEvents(value, scope.dt)
        # Reset Map
        bounds = scope.map.getBounds()
        mapRefresh(true, bounds)
        # Remove existing layer of routes/planes
        scope.map.removeLayer(scope.selectedRoutes)
        if scope.routesList.length
          # Add new layer using geoJSON object generated earlier
          scope.selectedRoutes = L.geoJson(scope.routesList,
            onEachFeature: FeatureLayerPopups
          ).addTo(scope.map)
          # Zoom Map to Routes on display
          scope.map.fitBounds(scope.selectedRoutes.getBounds())
      else
        # Clear all route/plane layers
        scope.map.removeLayer(scope.selectedRoutes)
        # Reset map to default view
        scope.map.setView(scope.mapDefaultCenter, scope.mapDefaultZoom)
      return


    # mapRefresh
    # ----------
    # Refresh the map, if the map loads in a hidden element, you need this
    mapRefresh = (value, bounds) ->
      if value
        $timeout(() ->
          scope.map.invalidateSize()
        , 0)
        if bounds
          $timeout(() ->
            scope.map.fitBounds(bounds)
          , 10)
        else
          $timeout(() ->
            scope.map.setView(scope.mapDefaultCenter, scope.mapDefaultZoom)
          , 10)
        scope.refreshMap = value




    # FeatureLayerPopups
    # ------------------
    # Function to pass to the onEachFeature callback so we can popup the info for the planes
    FeatureLayerPopups = (feature, layer) ->
      # Default to description of route, override if an airplane
      popupContent = '<div class="popupWrap"><h3>' + feature.properties.name + '</h3>' +
        '<p>' + feature.properties.description + '</p></div>'
      if feature.properties.icon
        layer.options.icon = L.icon(feature.properties.icon)

        popupContent = '<div class="popupWrap"><ul>' +
          '<li>Airline Code: ' + feature.properties.code + '</li>' +
          '<li>Flight Number: ' + feature.properties.flightNbr + '</li>' +
          '<li>Departure City: ' + feature.properties.scheduledDepartureAirportCode + '</li>' +
          '<li>Arrival City: ' + feature.properties.scheduledArrivalAirportCode + '</li>' +
          '<li>Current Altitude: ' + feature.properties.altitude + '</li>' +
          '<li>Current Airspeed: ' + feature.properties.airspeed + '</li>' +
          '<li>ETA: ' + feature.properties.ETA + '</li>' +
          '</ul></div>'
      layer.bindPopup popupContent
      return



    # LoadTestData
    # ------------
    # Simple Function to setup some test data for the map
    LoadTestData = () ->
      scope.flightData = [
        {
          id: 1000
          tailNbr: "ZF2245"
          eventCode: "aos"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celsius: "35"
              precipitation: "0"
              humidity: "4"
              windSpeed: "13"
              windDirection: "NE"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "SCK"
            airportLat: "37.896708"
            airportLong: "-121.248789"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "22"
              windSpeed: "5"
              windDirection: "N"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-118.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status:
              rejectedTakeOff: true
              cancellation: true
              gateReturn: true
              diversion: true
              safetySignificantEvent: false
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "23"
              windSpeed: "4"
              windDirection: "SW"
              description: "Sunny"
        }
        {
          id: 1001
          tailNbr: "FF2044"
          eventCode: "aos"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1408068127"
            weather:
              fahrenheit: "95"
              celsius: "35"
              precipitation: "0"
              humidity: "4"
              windSpeed: "13"
              windDirection: "NE"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "SCK"
            airportLat: "37.896708"
            airportLong: "-121.248789"
            scheduledArrivalUnixTimestamp: "1408104127"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "22"
              windSpeed: "5"
              windDirection: "N"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-118.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status:
              rejectedTakeOff: true
              cancellation: true
              gateReturn: true
              diversion: true
              safetySignificantEvent: false
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "23"
              windSpeed: "4"
              windDirection: "SW"
              description: "Sunny"
        }
        {
          id: 1002
          tailNbr: "FE3309"
          eventCode: "sos"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1408276927"
            weather:
              fahrenheit: "95"
              celsius: "35"
              precipitation: "0"
              humidity: "4"
              windSpeed: "13"
              windDirection: "NE"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "XNA"
            airportLat: "36.278659"
            airportLong: "-94.304294"
            scheduledArrivalUnixTimestamp: "1408294927"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "80"
              windSpeed: "5"
              windDirection: "N"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.000"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1408294927"
            status:
              rejectedTakeOff: true
              cancellation: true
              gateReturn: true
              diversion: true
              safetySignificantEvent: false
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "23"
              windSpeed: "4"
              windDirection: "SW"
              description: "Sunny"
        }
        {
          id: 1003
          tailNbr: "S13242"
          eventCode: "hpr"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1408467727"
            weather:
              fahrenheit: "95"
              celsius: "35"
              precipitation: "0"
              humidity: "4"
              windSpeed: "13"
              windDirection: "NE"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "COS"
            airportLat: "38.8023714"
            airportLong: "-104.7012331"
            scheduledArrivalUnixTimestamp: "1408478527"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "22"
              windSpeed: "5"
              windDirection: "N"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status:
              rejectedTakeOff: true
              cancellation: true
              gateReturn: true
              diversion: true
              safetySignificantEvent: false
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "23"
              windSpeed: "4"
              windDirection: "SW"
              description: "Sunny"
        }
        {
          id: 1004
          tailNbr: "LL2345"
          eventCode: "sos"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "AZA"
            airportLat: "33.309876"
            airportLong: "-111.656895"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celsius: "35"
              precipitation: "0"
              humidity: "4"
              windSpeed: "13"
              windDirection: "NE"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "COS"
            airportLat: "38.8023714"
            airportLong: "-104.7012331"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "22"
              windSpeed: "5"
              windDirection: "N"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status:
              rejectedTakeOff: true
              cancellation: true
              gateReturn: true
              diversion: true
              safetySignificantEvent: false
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celsius: "32"
              precipitation: "0"
              humidity: "23"
              windSpeed: "4"
              windDirection: "SW"
              description: "Sunny"
        }
      ]
      return

    $timeout (->
      scope.mapDefaultCenter = [
        36.086
        -115.147
      ]
      scope.mapDefaultZoom = 4
      scope.map = L.mapbox.map("dashboard_map", scope.tileJSON).setView(scope.mapDefaultCenter, scope.mapDefaultZoom)

      scope.map.legendControl.setPosition("topleft")
      scope.map.zoomControl.setPosition("bottomright")
      scope.selectedRoutes = L.mapbox.featureLayer().addTo(scope.map)

      scope.changeDate = () ->
        if @stationRoutes
          renderRoutesToMap(@stationRoutes, "stations")
        else if @eventCodes
          renderRoutesToMap(@eventCodes, "codes")

      scope.changeStation = () ->
        renderRoutesToMap(@stationRoutes, "stations")

      scope.changeEvent = () ->
        renderRoutesToMap(@eventCodes, "codes")

      scope.$watch "refreshMap", (value) ->
        mapRefresh(value)

      scope.$watch "tailNumbers", (value) ->
        renderRoutesToMap(value, "tails")

      # Rotate the plane icons based on their respective route heading
      scope.map.on "viewreset", (e) ->
        scope.selectedRoutes.eachLayer (layer) ->
          if layer._icon isnt `undefined` and layer._icon isnt null
            if layer._icon.style.cssText.indexOf("rotate") is -1
              angleToRotate  = 90 + layer.feature.properties.heading.angle
              $timeout (->
                iconElem = L.DomUtil.get(layer._icon);

                if L.DomUtil.TRANSFORM
                  # use the CSS transform rule if available
                  iconElem.style[L.DomUtil.TRANSFORM] += " rotate(" + angleToRotate + "deg)"
                else if L.Browser.ie
                  # fallback for IE6, IE7, IE8
                  rad = angleToRotate * L.LatLng.DEG_TO_RAD
                  costheta = Math.cos(rad)
                  sintheta = Math.sin(rad)
                  iconElem.style.filter += " progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand', M11=" + costheta + ", M12=" + (-sintheta) + ", M21=" + sintheta + ", M22=" + costheta + ")"
                return
              ), 50
          return
      return
    ), 1000
