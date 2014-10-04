express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })




# GET EVENTS
router.get '/', (req, res, next) ->
  responseObj = [
        {
          name: 'sbd'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'tus'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'okc'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'sfb'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'pie'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'fll'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'pgd'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'myr'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'las'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'lax'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'env'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'iwa'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'hnl'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'bli'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'oak'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        },{
          name: 'pia'
          stationManager: {
            firstName:"Stacy",
            lastName:"Peralta",
            phone:"(523) 823-2300 Ext. 78",
            address:"342 Airport Rd."
            city:"Duluth",
            state:"MN",
            zip:" 92734"
          },
          stationOnCall: {
            firstName:"Lucy",
            lastName:"Dredge",
            phone:"(723) 728-7261 Ext. 7239"
          },
          mxVendor: [{
            name:"Ray's Machine Co.",
            contactFirstName:"Ray",
            contactLastName:"Verguenca",
            phone:"(523) 823-2300 Ext. 78",
            fax:"(723) 728-7261",
            address:"342 Airport Rd.",
            city:"Duluth",
            state:"MN",
            zip:"92734",
            contract:"AW67890"
          }]
        }
      ]

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router