"use strict"

chart = angular.module "g4plus.chart", [
  'services.chart'
  'g4plus.flash-messages'

]

chart.controller 'ChartCtrl', [
  '$scope'
  'Chart'
  'FlashStorage'
  ($scope, Chart, FlashStorage) ->

    # Chart Data WS
    # -------------
    # Get data for chart
    Chart.query([]).$promise.then (chartResults) ->
      $scope.list = chartResults
]

chart.directive "dashboardChart", () ->
  restrict: 'EA'
  controller: 'ChartCtrl'
  replace: true
  scope:
    myValue: '=chartData'
  link: (scope, element, attrs) ->

    # Variables
    # -------------
    # Station Filter Arrays
    scope.allStations = ['SFB', 'PIE', 'FLL', 'PGD', 'MYR', 'IWA', 'AZA', 'LAS', 'LAX', 'ENV', 'OAK', 'BLI', 'HNL', 'OKC', 'TUS', 'SBD']
    scope.eastStation = ['SFB', 'PIE', 'FLL', 'PGD', 'MYR']
    scope.westStation = ['IWA', 'AZA', 'LAS', 'LAX', 'ENV', 'OAK', 'BLI', 'HNL']
    scope.hvyStation = ['OKC', 'TUS', 'SBD']
    scope.baseStation = ['SFB', 'IWA', 'AZA', 'LAS']


    type = (d) ->
      d.flights = +d.flights
      d

    scope.$watch 'list', (newValue) ->
      myList = newValue
      scope.$watch 'myValue', (newValue) ->
        filteredStation = newValue

        newList = []
        chartData = []

        # Create Chart Data Array
        i = 0
        j = 0
        while i < 24

          newObj = {
            id: null
            time: null
            flights: null
          }

          doubleDigit = ("0" + i).slice(-2)
          convertedTime = doubleDigit + ":00"
          newObj.id = i
          newObj.time = convertedTime
          chartData.push newObj
          i++

        i = 0
        j = 0
        while i < scope.list.length
          newObj = {
            id: null
            time: null
            flights: null
            station: null
            hour: null
            month: null
            date: null
            year: null
            eventCode: null
          }

          list = scope.list[i]

          date = new Date(list.createdUnixTimestamp * 1000)


          convertedHour = date.getHours()
          convertedMonth = date.getMonth() + 1    # Months are indexed from 0 - 11
          convertedDate = date.getDate()
          convertedYear = date.getFullYear()

          newObj.id = j
          newObj.time = convertedHour
          newObj.flights = list.tailNbr
          newObj.station = list.station
          newObj.state = list.state
          newObj.hour = convertedHour
          newObj.month = convertedMonth
          newObj.date = convertedDate
          newObj.year = convertedYear
          newObj.eventCode = list.eventCode


          listStation = list.station.toUpperCase()
          switch filteredStation
            when ''
              indexCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.allStations.length
                  allStations = scope.allStations[indexCount]
                  if listStation is allStations
                    newList.push newObj
                  indexCount++
            when 'NON'
              indexCount = 0
              nonCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.allStations.length
                  allStations = scope.allStations[indexCount]
                  if listStation is allStations
                    nonCount++
                  indexCount++
                if nonCount is 0
                  newList.push newObj
            when 'EAST'
              indexCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.eastStation.length
                  eastStation = scope.eastStation[indexCount]
                  if listStation is eastStation
                    newList.push newObj
                  indexCount++
            when 'WEST'
              indexCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.westStation.length
                  westStation = scope.westStation[indexCount]
                  if listStation is westStation
                    newList.push newObj
                  indexCount++
            when 'HVY'
              indexCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.hvyStation.length
                  hvyStation = scope.hvyStation[indexCount]
                  if listStation is hvyStation
                    newList.push newObj
                  indexCount++
            when 'BASE'
              indexCount = 0
              if list.eventCode is 'aos'
                while indexCount < scope.baseStation.length
                  baseStation = scope.baseStation[indexCount]
                  if listStation is baseStation
                    newList.push newObj
                  indexCount++
            when 'IWA/AZA'
              if list.eventCode is 'aos'
                if list.eventCode is 'IWA' or 'AZA'
                  newList.push newObj
            else
              if listStation is filteredStation and list.eventCode is 'aos'
                newList.push newObj


          i++
          j++


        updatedData = []
        i = 0
        countTime = 0
        while i < 24
          currentIndex = i
          data = chartData[i]
          countTime = 0

          j = 0
          while j < newList.length

            list = newList[j]

            currentHour = moment().hour()
            currentMonth = moment().month() + 1     # Months are indexed from 0 - 11
            currentDate = moment().date()
            currentYear = moment().year()


            if list.time <= i and list.state is "open" and list.year <= currentYear and list.month <= currentMonth
              countTime++

            j++
          data.flights = countTime
          updatedData.push data
          i++

        scope.updatedData = updatedData


    # Bar Chart
    # -------------
    # Builds out bar chart
    margin =
      top: 60
      right: 80
      bottom: 80
      left: 60

    width = parseInt(d3.select("body").style("width"), 10)
    width = width - margin.left - margin.right
    height = 76

    # Line Generator
    line = d3.svg.line()
    x = d3.scale.ordinal()
      .rangeRoundBands([0, width], .6)

    y0 = d3.scale.linear().domain([
      0
      0
    ]).range([
      height
      0
    ])
    y1 = d3.scale.linear().domain([
      0
      0
    ]).range([
      height
      0
    ])

    xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom")

    # Creates Left yAxis
    yAxisLeft = d3.svg.axis().scale(y0).ticks(3).orient("left").tickFormat(d3.format("d"))

    # Creates Right yAxis
    chart = d3.select("#dashboard_chart").append("svg")

      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("class", "graph")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


    # Tooltip on bar hover
    tip = d3.tip()
      .attr("class", "d3-tip")
      .offset([-10, 0])
      .html((d) ->
          "<strong>AOS Status:</strong> <span style='color: #428bca'>" + d.flights + "</span>")


    # Calls tooltip function
    chart.call tip

    # Watch data for changes
    scope.$watch "updatedData", (data) ->
      if data?
        chart.selectAll("*").remove()
        draw data


    # Draw data
    # -------------
    # Loads chart and is called when changes are made to data
    draw = (data) ->

      x.domain data.map((d) ->
        d.time
      )
      y0.domain [
        0
        d3.max(data, (d) ->
          d.flights
        )
      ]

      # Time on x-axis
      chart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")

        .call xAxis

      # AOS status on y-axis
      chart.append("g")
        .transition()
        .duration(800)
        .attr("class", "y axis axisLeft")
        .attr("transform", "translate(0,0)")
        .call yAxisLeft

      # Horizontal Grids
      chart.selectAll("line.y0")
        .data(y0.ticks(3))
        .enter().append("line")
        .attr("class", "horizontal-grid")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", y0)
        .attr("y2", y0)

      bars = chart.selectAll(".bar").data(data).enter()

      # Bars
      bars.append("svg:rect")

        .attr("class", "bar")
        .attr("x", (d) -> x(d.time))
        .attr("width", x.rangeBand())
        .on("mouseover", tip.show)
        .on("click", tip.show)
        .on("mouseout", tip.hide)
        .transition()
        .ease("linear")
        .attr("y", (d) -> y0(d.flights))
        .transition()
        .ease("linear")
          .attr("height", (d, i, j) ->
            height - y0(d.flights))


      # Bar tooltip rectangles
      bars.append("svg:rect")
        .transition()
        .attr("class", "little-rect")
        .attr("x", (d) ->
            x(d.time))
        .attr("width", x.rangeBand())
        .attr("y", (d) ->
            y0(d.flights))
        .transition()
        .duration(800)
          .attr "height", (d) ->
            "2px" unless (d.flights) is 0

      # Values on top of bar
      bars.append("svg:text")
        .transition()
        .attr("class", "bar-text")
        .attr("x", (d) ->
            x(d.time) + x.rangeBand()/2)
        .attr("y", (d) ->
            y0(d.flights) - 12)
        .transition()
        .duration(800)
          .text (d) ->
            d.flights unless d.flights is 0


    # Resize Chart
    # -------------
    # Makes chart responsive on window resize
    window.onresize = ->
      width = parseInt(d3.select("body").style("width"))
      width = width - margin.left - margin.right
      x.rangeRoundBands [
        0
        width
      ], .6
      chart.selectAll("g").attr "graph", width
      chart.selectAll("rect.bar").attr("x", (d) ->
        x d.time
      ).attr "width", x.rangeBand()
      chart.selectAll("rect.little-rect").attr("x", (d) ->
        x d.time
      ).attr "width", x.rangeBand()
      chart.selectAll(".horizontal-grid").attr("x1", 0).attr("x2", width).attr("y1", y0).attr "y2", y0
      chart.select(".x.axis").call xAxis
      chart.selectAll(".bar-text").attr "x", (d) ->
        x(d.time) + (x.rangeBand() / 2)

      return






