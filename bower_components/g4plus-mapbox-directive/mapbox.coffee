mapbox = angular.module 'g4plus-mapbox.directive', [ ]

mapbox.directive "g4Mapbox", () ->
  scope: {
    refreshMap: "=?"
    stationRoutes: "=?"
    flightData: "=?"
#    testData: [
#      {
#        id: 1000
#        tailNbr: "ZF2245"
#        description: "Lorem ipsum..."
#        departureInfo:
#          scheduledDepartureAirportCode: "LAS"
#          airportLat: "36.083970"
#          airportLong: "-115.153444"
#          scheduledDepartureUnixTimestamp: "1411171895"
#          weather:
#            fahrenheit: "95"
#            celcius: "35"
#            precipitation: "0"
#            humidity: "4"
#            wind: "13"
#            description: "Cloudy"
#
#        arrivalInfo:
#          scheduledArrivalAirportCode: "SCK"
#          airportLat: "37.896708"
#          airportLong: "-121.248789"
#          scheduledArrivalUnixTimestamp: "1411182695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "22"
#            wind: "5"
#            description: "Partly cloudy"
#
#        currentInfo:
#          flightNbr: "AAY528"
#          lat: "37.423697"
#          long: "-118.500151"
#          code: "X98765"
#          altitude: "20000"
#          airspeed: "375"
#          ETA: "1411182695"
#          status: "Rejected Take Off"
#          currentUnixTimestamp: "1411172695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "23"
#            wind: "4"
#            description: "Sunny"
#      }
#      {
#        id: 1001
#        tailNbr: "FF2044"
#        description: "Lorem ipsum..."
#        departureInfo:
#          scheduledDepartureAirportCode: "LAS"
#          airportLat: "36.083970"
#          airportLong: "-115.153444"
#          scheduledDepartureUnixTimestamp: "1411171895"
#          weather:
#            fahrenheit: "95"
#            celcius: "35"
#            precipitation: "0"
#            humidity: "4"
#            wind: "13"
#            description: "Cloudy"
#
#        arrivalInfo:
#          scheduledArrivalAirportCode: "SCK"
#          airportLat: "37.896708"
#          airportLong: "-121.248789"
#          scheduledArrivalUnixTimestamp: "1411182695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "22"
#            wind: "5"
#            description: "Partly cloudy"
#
#        currentInfo:
#          flightNbr: "AAY528"
#          lat: "37.423697"
#          long: "-118.500151"
#          code: "X98765"
#          altitude: "20000"
#          airspeed: "375"
#          ETA: "1411182695"
#          status: "Cancellation"
#          currentUnixTimestamp: "1411172695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "23"
#            wind: "4"
#            description: "Sunny"
#      }
#      {
#        id: 1002
#        tailNbr: "FE3309"
#        description: "Lorem ipsum..."
#        departureInfo:
#          scheduledDepartureAirportCode: "LAS"
#          airportLat: "36.083970"
#          airportLong: "-115.153444"
#          scheduledDepartureUnixTimestamp: "1411171895"
#          weather:
#            fahrenheit: "95"
#            celcius: "35"
#            precipitation: "0"
#            humidity: "4"
#            wind: "13"
#            description: "Cloudy"
#
#        arrivalInfo:
#          scheduledArrivalAirportCode: "XNA"
#          airportLat: "36.278659"
#          airportLong: "-94.304294"
#          scheduledArrivalUnixTimestamp: "1411182695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "80"
#            wind: "5"
#            description: "Partly cloudy"
#
#        currentInfo:
#          flightNbr: "AAY528"
#          lat: "37.423697"
#          long: "-110.000"
#          code: "X98765"
#          altitude: "20000"
#          airspeed: "375"
#          ETA: "1411182695"
#          status: "Gate Return, Diversion"
#          currentUnixTimestamp: "1411172695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "23"
#            wind: "4"
#            description: "Sunny"
#      }
#      {
#        id: 1003
#        tailNbr: "S13242"
#        description: "Lorem ipsum..."
#        departureInfo:
#          scheduledDepartureAirportCode: "LAS"
#          airportLat: "36.083970"
#          airportLong: "-115.153444"
#          scheduledDepartureUnixTimestamp: "1411171895"
#          weather:
#            fahrenheit: "95"
#            celcius: "35"
#            precipitation: "0"
#            humidity: "4"
#            wind: "13"
#            description: "Cloudy"
#
#        arrivalInfo:
#          scheduledArrivalAirportCode: "COS"
#          airportLat: "38.8023714"
#          airportLong: "-104.7012331"
#          scheduledArrivalUnixTimestamp: "1411182695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "22"
#            wind: "5"
#            description: "Partly cloudy"
#
#        currentInfo:
#          flightNbr: "AAY528"
#          lat: "37.423697"
#          long: "-110.500151"
#          code: "X98765"
#          altitude: "20000"
#          airspeed: "375"
#          ETA: "1411182695"
#          status: "Gate Return, Diversion"
#          currentUnixTimestamp: "1411172695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "23"
#            wind: "4"
#            description: "Sunny"
#      }
#      {
#        id: 1004
#        tailNbr: "LL2345"
#        description: "Lorem ipsum..."
#        departureInfo:
#          scheduledDepartureAirportCode: "AZA"
#          airportLat: "33.309876"
#          airportLong: "-111.656895"
#          scheduledDepartureUnixTimestamp: "1411171895"
#          weather:
#            fahrenheit: "95"
#            celcius: "35"
#            precipitation: "0"
#            humidity: "4"
#            wind: "13"
#            description: "Cloudy"
#
#        arrivalInfo:
#          scheduledArrivalAirportCode: "COS"
#          airportLat: "38.8023714"
#          airportLong: "-104.7012331"
#          scheduledArrivalUnixTimestamp: "1411182695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "22"
#            wind: "5"
#            description: "Partly cloudy"
#
#        currentInfo:
#          flightNbr: "AAY528"
#          lat: "37.423697"
#          long: "-110.500151"
#          code: "X98765"
#          altitude: "20000"
#          airspeed: "375"
#          ETA: "1411182695"
#          status: "Safety Significant Event"
#          currentUnixTimestamp: "1411172695"
#          weather:
#            fahrenheit: "90"
#            celcius: "32"
#            precipitation: "0"
#            humidity: "23"
#            wind: "4"
#            description: "Sunny"
#      }
#    ]
  }
  restrict: "A"
  template: '
    <div id="customLegend">
      <div class="stationFilters container-fluid">
        <div class="stationsWrap form-group col-xs-6">
          <div class="legendTitle">Station</div>
          <ul>
            <li class="checkbox"><input type="checkbox" id="station-LAS" class="input-sm" ng-model="stationRoutes" ng-true-value="LAS" /><label for="station-LAS">LAS</label></li>
            <li class="checkbox"><input type="checkbox" id="station-LAX" class="input-sm" ng-model="stationRoutes" ng-true-value="LAX" /><label for="station-LAX">LAX</label></li>
            <li class="checkbox"><input type="checkbox" id="station-AZA" class="input-sm" ng-model="stationRoutes" ng-true-value="AZA" /><label for="station-AZA">AZA</label></li>
            <li class="checkbox"><input type="checkbox" id="station-MDT" class="input-sm" ng-model="stationRoutes" ng-true-value="MDT" /><label for="station-MDT">MDT</label></li>
            <li class="checkbox"><input type="checkbox" id="station-SFB" class="input-sm" ng-model="stationRoutes" ng-true-value="SFB" /><label for="station-SFB">SFB</label></li>
            <li class="checkbox"><input type="checkbox" id="station-XNA" class="input-sm" ng-model="stationRoutes" ng-true-value="XNA" /><label for="station-XNA">XNA</label></li>
          </ul>
        </div>
      </div>
    </div>
    <div id="dashboard_map"></div>
  '
  link: (scope, element, attrs) ->
    # Add Map
    scope.mapMetadataUrl = "http://maps.localhost/airports.json"
    scope.tileJSON = scope.map = []
    metadataJSON = $.getJSON(scope.mapMetadataUrl, (data) ->
      metadataJSON["legend"] = data["legend"]
      metadataJSON["legendControl"] = position: "topleft"
      metadataJSON["zoomControl"] = position: "bottomright"
      metadataJSON["template"] = data["template"]
      metadataJSON["minzoom"] = data["minzoom"]
      metadataJSON["maxzoom"] = data["maxzoom"]
      metadataJSON["tiles"] = [
        "http://a.tiles.localhost/airports/{z}/{x}/{y}.png"
        "http://b.tiles.localhost/airports/{z}/{x}/{y}.png"
      ]
      metadataJSON["grids"] = [
        "http://a.tiles.localhost/airports/{z}/{x}/{y}.grid.json"
        "http://b.tiles.localhost/airports/{z}/{x}/{y}.grid.json"
      ]
      metadataJSON["tilejson"] = "2.0.0"
    )
    scope.tileJSON = metadataJSON

    # filterRoutes
    # ------------
    # Filter Routes List to the Short Code as a departure or destination airport
    # * @param {string}   shortcode Airport Short Code to filter by
    filterRoutes = (shortcode) ->
      scope.routesList = []
      scope.shortcode = shortcode
      console.log("Shortcode filtering on: " + shortcode)

      angular.forEach scope.flightData, (v, k) ->
        if v.departureInfo.scheduledDepartureAirportCode is scope.shortcode or v.arrivalInfo.scheduledArrivalAirportCode is scope.shortcode
          route = {
            type: "FeatureCollection"
            features: [
              {
                type: "Feature"
                properties:
                  name: "Flight: " + v.currentInfo.flightNbr
                  description: "Route: " + v.departureInfo.scheduledDepartureAirportCode + " -> " + v.arrivalInfo.scheduledArrivalAirportCode
                geometry:
                  type: "LineString"
                  coordinates: [
                    [
                      v.departureInfo.airportLong
                      v.departureInfo.airportLat
                    ]
                  ,
                    [
                      v.currentInfo.long
                      v.currentInfo.lat
                    ]
                  ,
                    [
                      v.arrivalInfo.airportLong
                      v.arrivalInfo.airportLat
                    ]
                  ]
              }
              {
                type: "Feature"
                properties:
                  name: "Tail: " + v.currentInfo.tailNbr
                  description: "Flying " + v.currentInfo.flightNbr + " from " + v.departureInfo.scheduledDepartureAirportCode + " to " + v.arrivalInfo.scheduledArrivalAirportCode
                geometry:
                  type: "Point"
                  coordinates: [
                    v.currentInfo.long
                    v.currentInfo.lat
                  ]
              }
            ]
          }
          scope.routesList.push(route)
        return

      return

    # FeatureLayerPopups
    # ------------------
    # Function to pass to the onEachFeature callback so we can popup the info for the planes
    FeatureLayerPopups = (feature, layer) ->
      layer.bindPopup feature.properties.description
      return

    # LoadTestData
    # ------------
    # Simple Function to setup some test data for the map
    LoadTestData = () ->
      scope.flightData = [
        {
          id: 1000
          tailNbr: "ZF2245"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celcius: "35"
              precipitation: "0"
              humidity: "4"
              wind: "13"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "SCK"
            airportLat: "37.896708"
            airportLong: "-121.248789"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "22"
              wind: "5"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-118.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status: "Rejected Take Off"
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "23"
              wind: "4"
              description: "Sunny"
        }
        {
          id: 1001
          tailNbr: "FF2044"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celcius: "35"
              precipitation: "0"
              humidity: "4"
              wind: "13"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "SCK"
            airportLat: "37.896708"
            airportLong: "-121.248789"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "22"
              wind: "5"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-118.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status: "Cancellation"
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "23"
              wind: "4"
              description: "Sunny"
        }
        {
          id: 1002
          tailNbr: "FE3309"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celcius: "35"
              precipitation: "0"
              humidity: "4"
              wind: "13"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "XNA"
            airportLat: "36.278659"
            airportLong: "-94.304294"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "80"
              wind: "5"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.000"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status: "Gate Return, Diversion"
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "23"
              wind: "4"
              description: "Sunny"
        }
        {
          id: 1003
          tailNbr: "S13242"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "LAS"
            airportLat: "36.083970"
            airportLong: "-115.153444"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celcius: "35"
              precipitation: "0"
              humidity: "4"
              wind: "13"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "COS"
            airportLat: "38.8023714"
            airportLong: "-104.7012331"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "22"
              wind: "5"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status: "Gate Return, Diversion"
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "23"
              wind: "4"
              description: "Sunny"
        }
        {
          id: 1004
          tailNbr: "LL2345"
          description: "Lorem ipsum..."
          departureInfo:
            scheduledDepartureAirportCode: "AZA"
            airportLat: "33.309876"
            airportLong: "-111.656895"
            scheduledDepartureUnixTimestamp: "1411171895"
            weather:
              fahrenheit: "95"
              celcius: "35"
              precipitation: "0"
              humidity: "4"
              wind: "13"
              description: "Cloudy"

          arrivalInfo:
            scheduledArrivalAirportCode: "COS"
            airportLat: "38.8023714"
            airportLong: "-104.7012331"
            scheduledArrivalUnixTimestamp: "1411182695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "22"
              wind: "5"
              description: "Partly cloudy"

          currentInfo:
            flightNbr: "AAY528"
            lat: "37.423697"
            long: "-110.500151"
            code: "X98765"
            altitude: "20000"
            airspeed: "375"
            ETA: "1411182695"
            status: "Safety Significant Event"
            currentUnixTimestamp: "1411172695"
            weather:
              fahrenheit: "90"
              celcius: "32"
              precipitation: "0"
              humidity: "23"
              wind: "4"
              description: "Sunny"
        }
      ]
      return

    window.setTimeout(() ->
      scope.mapDefaultCenter = [
        36.086
        -115.147
      ]
      scope.mapDefaultZoom = 4
      scope.map = L.mapbox.map("dashboard_map", scope.tileJSON).setView(scope.mapDefaultCenter, scope.mapDefaultZoom)

      scope.map.legendControl.setPosition("topleft")
      scope.map.zoomControl.setPosition("bottomright")
      scope.selectedRoutes = L.geoJson([],
        onEachFeature: FeatureLayerPopups
      ).addTo(scope.map)

      scope.$watch "refreshMap", (value) ->
        if value
          scope.map.invalidateSize()
        return

      scope.$watch "stationRoutes", (value) ->
        if value
          # Fallback if flightdata is missing.
          if scope.flightData.length < 1
            LoadTestData()
          console.log(scope.flightData.length)
          filterRoutes(value)
          scope.map.removeLayer(scope.selectedRoutes)
          scope.selectedRoutes = L.geoJson(scope.routesList,
            onEachFeature: FeatureLayerPopups
          ).addTo(scope.map)
          scope.map.fitBounds(scope.selectedRoutes.getBounds())
        else
          scope.map.removeLayer(scope.selectedRoutes)
          scope.map.setView(scope.mapDefaultCenter, scope.mapDefaultZoom)
        return

    , 1000)

