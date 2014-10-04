express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })


responseObj = [
  {
    id: 1
    tailNbr: "904NV-E"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SCK"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SCK"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "HNL"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "HNL"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAX"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAX"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "HNL"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "HNL"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "HNL"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "HNL"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "FAT"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  },
  {
    id: 2
    tailNbr: "215NV"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "ROA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "ROA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SFB"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LYH"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LYH"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SFB"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "ROA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "ROA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SFB"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LYH"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  },
  {
    id: 3
    tailNbr: "414NV"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "IWA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "RAP"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "RAP"
          scheduledDepartureUnixTimestamp: "1411781614"

        arrivalInfo:
          scheduledArrivalAirportCode: "IWA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "IWA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "BIL"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "BIL"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "IWA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "IWA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "GRI"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "GRI"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "IWA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "IWA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "MLI"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  },
  {
    id: 4
    tailNbr: "410NV"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "ENV"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SAN"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SAN"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "ENV"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "ENV"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "OKC"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  },
  {
    id: 5
    tailNbr: "412NV"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "IND"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETA: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "IND"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SFB"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "PIA"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "PIA"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "SFB"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "SFB"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "IND"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "IND"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "PIE"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  },
  {
    id: 6
    tailNbr: "905NV"
    routes:[
      {
        departureInfo:
          scheduledDepartureAirportCode: "MFE"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "AVS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "AVS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "MFE"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "MFE"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "LAS"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      },
      {
        departureInfo:
          scheduledDepartureAirportCode: "LAS"
          scheduledDepartureUnixTimestamp: "1412318305"

        arrivalInfo:
          scheduledArrivalAirportCode: "HNL"
          scheduledArrivalUnixTimestamp: "1412319305"

        currentInfo:
          flightNbr: "AAY528"
          lat: "37.423697"
          long: "-118.500151"
          code: "X98765"
          altitude: "20000"
          airspeed: "375"
          ETR: "1411781614"
          status:
            rejectedTakeOff: true
            cancellation: true
            gateReturn: true
            diversion: true
            safetySignificantEvent: false
      }
    ]
  }
]




# GET TAIL ROUTE INFO
router.get '/', (req, res, next) ->
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))


module.exports = router
