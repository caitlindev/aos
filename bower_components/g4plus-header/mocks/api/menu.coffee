express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



menuObj = [
  {
    "items": [
      {
        "id": 1,
        "code": "ac_root",
        "title": "AC",
        "parentId": null,
        "sort": 10,
        "application": null,
        "children": []
      },
      {
        "id": 2,
        "code": "mx_root",
        "title": "MX",
        "parentId": null,
        "sort": 10,
        "application": null,
        "children": []
      },
      {
        "id": 3,
        "code": "ac_aircraft",
        "title": "Aircraft",
        "parentId": 1,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_aircraft",
          "name":"Aircraft",
          "url":"mx/admin/aircraft/tails/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 4,
        "code": "mx_admin",
        "title": "Admin",
        "parentId": 2,
        "sort": 10,
        "application": null,
        "children": []
      },
      {
        "id": 5,
        "code": "ac_rules",
        "title": "AC Rules",
        "parentId": 3,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_rules",
          "name":"AC Rules",
          "url":"mx/admin/aircraft/rules/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 6,
        "code": "ac_tails",
        "title": "AC Tails",
        "parentId": 3,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_tails",
          "name":"AC Tails",
          "url":"mx/admin/aircraft/tails/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 7,
        "code": "ac_types",
        "title": "AC Types",
        "parentId": 3,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_types",
          "name":"AC Types",
          "url":"mx/admin/aircraft/types/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 8,
        "code": "mx_aircraft_panels",
        "title": "AC Panels",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_aircraft_panels",
          "name":"AC Panels",
          "url":"mx/admin/aircraft/panels/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 9,
        "code": "mx_aircraft_zones",
        "title": "AC Zones",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"ac_aircraft_zones",
          "name":"AC Zones",
          "url":"mx/admin/aircraft/zones/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 10,
        "code": "mx_discovery_codes",
        "title": "Discovery Zones",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_discovery_codes",
          "name":"Discovery Codes",
          "url":"mx/admin/discovery/codes/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 11,
        "code": "mx_dmi",
        "title": "DMI",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_dmi",
          "name":"DMI",
          "url":"mx/admin/dmi/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 12,
        "code": "mx_failure_effect_codes",
        "title": "Failure Effect Codes",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_failure_effect_codes",
          "name":"Failure Effect Codes",
          "url":"mx/admin/failure/effect/codes/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 13,
        "code": "mx_inspection_checkset",
        "title": "Inspection Checkset",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_inspection_checkset",
          "name":"Inspection Checkset",
          "url":"mx/admin/inspection/checkset/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 14,
        "code": "mx_mi_nature",
        "title": "MI Nature",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_mi_nature",
          "name":"Aircraft",
          "url":"mx/admin/mi/nature/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 15,
        "code": "mx_mi_procedure",
        "title": "MI Procedure",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_mi_procedure",
          "name":"MI Procedure",
          "url":"mx/admin/mi/procedure/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 16,
        "code": "mx_mi_stage",
        "title": "MI Stage",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_mi_stage",
          "name":"MI Stage",
          "url":"mx/admin/mi/stage/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 17,
        "code": "mx_oil_configuration",
        "title": "Oil Configuration",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_oil_configuration",
          "name":"Oil Configuration",
          "url":"mx/admin/oil/configuration/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 18,
        "code": "mx_oil_input_settings",
        "title": "Oil Input Settings",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_oil_input_settings",
          "name":"Oil Input Settings",
          "url":"mx/admin/oil/input/settings/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 19,
        "code": "mx_oil_types",
        "title": "Oil Types",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_oil_types",
          "name":"Oil Types",
          "url":"mx/admin/oil/types/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 20,
        "code": "mx_originator_code",
        "title": "Originator Code",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_originator_code",
          "name":"Originator Code",
          "url":"mx/admin/originator/code/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 21,
        "code": "mx_skill_codes",
        "title": "Skill Codes",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_skill_codes",
          "name":"Skill Codes",
          "url":"mx/admin/skill/codes/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 22,
        "code": "mx_source_documents",
        "title": "Source Documents",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_source_documents",
          "name":"Source Documents",
          "url":"mx/admin/source/documents/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 23,
        "code": "mx_source_document_issuer",
        "title": "Source Document Issuer",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_source_document_issuer",
          "name":"Source Document Issuer",
          "url":"mx/admin/source/document/issuer/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 24,
        "code": "mx_source_document_type",
        "title": "Source Document Type",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_source_document_type",
          "name":"Source Document Type",
          "url":"mx/admin/source/document/type/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 25,
        "code": "mx_task_cards",
        "title": "Task Cards",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_task_cards",
          "name":"Aircraft",
          "url":"mx/admin/task/cards/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 26,
        "code": "mx_task_category",
        "title": "Task Category",
        "parentId": 25,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_task_category",
          "name":"Aircraft",
          "url":"mx/admin/task/category/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 27,
        "code": "mx_task_card_reference_types",
        "title": "Task Card Reference Type",
        "parentId": 25,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_task_card_reference_types",
          "name":"Task Card Reference Type",
          "url":"mx/admin/task/card/reference/type/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      },
      {
        "id": 28,
        "code": "mx_unit_of_measure",
        "title": "Unit of Measure",
        "parentId": 4,
        "sort": 10,
        "application": {
          "id":1,
          "code":"mx_unit_of_measure",
          "name":"Unit of Measure",
          "url":"mx/admin/uom/index.html",
          "description":"",
          "menuId":8
        },
        "children": []
      }
    ],
    "total": 28,
    "sorts": [],
    "filters": [],
    "limit": null,
    "page": null
  }
]




# GET MENU
router.get '/', (req, res, next) ->
  responseObj = menuObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router