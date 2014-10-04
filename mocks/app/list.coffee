express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



fullObj = [
   {
      "code":"ac-admin-aircraft-panels",
      "name":"ac-admin-aircraft-panels",
      "url":"/ac/admin/aircraft/panels/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-admin-aircraft-type",
      "name":"ac-admin-aircraft-type",
      "url":"/ac/admin/aircraft/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-admin-aircraft-zones",
      "name":"ac-admin-aircraft-zones",
      "url":"/ac/admin/aircraft/zones/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-portal",
      "name":"ac-portal",
      "url":"/ac/portal/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"mx-admin-component",
      "name":"mx-admin-component",
      "url":"/mx/admin/component/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[
         {
            "code":"mx-admin-component-category",
            "name":"mx-admin-component-category",
            "url":"/mx/admin/component/category/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-component",
            "children":[

            ]
         },
         {
            "code":"mx-admin-component-type",
            "name":"mx-admin-component-type",
            "url":"/mx/admin/component/type/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-component",
            "children":[

            ]
         }
      ]
   },
   {
      "code":"mx-admin-component-category",
      "name":"mx-admin-component-category",
      "url":"/mx/admin/component/category/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-component",
      "children":[

      ]
   },
   {
      "code":"mx-admin-component-type",
      "name":"mx-admin-component-type",
      "url":"/mx/admin/component/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-component",
      "children":[

      ]
   },
   {
      "code":"mx-admin-manufacturer",
      "name":"mx-admin-manufacturer",
      "url":"/mx/admin/manufacturer/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"mx-admin-menu-configuration",
      "name":"mx-admin-menu-configuration",
      "url":"/mx/admin/menu/configuration/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc",
      "name":"mx-admin-sourcedoc",
      "url":"/mx/admin/sourcedoc/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[
         {
            "code":"mx-admin-sourcedoc-disposition",
            "name":"mx-admin-sourcedoc-disposition",
            "url":"/mx/admin/sourcedoc/disposition/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-issuer",
            "name":"mx-admin-sourcedoc-issuer",
            "url":"/mx/admin/sourcedoc/issuer/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-template-analysis",
            "name":"mx-admin-sourcedoc-template-analysis",
            "url":"/mx/admin/sourcedoc/template/analysis/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-type",
            "name":"mx-admin-sourcedoc-type",
            "url":"/mx/admin/sourcedoc/type/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         }
      ]
   },
   {
      "code":"mx-admin-sourcedoc-disposition",
      "name":"mx-admin-sourcedoc-disposition",
      "url":"/mx/admin/sourcedoc/disposition/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-issuer",
      "name":"mx-admin-sourcedoc-issuer",
      "url":"/mx/admin/sourcedoc/issuer/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-template-analysis",
      "name":"mx-admin-sourcedoc-template-analysis",
      "url":"/mx/admin/sourcedoc/template/analysis/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-type",
      "name":"mx-admin-sourcedoc-type",
      "url":"/mx/admin/sourcedoc/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-ata-administration",
      "name":"mx-ata-administration",
      "url":"/mx/ata/administration/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   }
]



mxObj = [
   {
      "code":"mx-admin-component",
      "name":"mx-admin-component",
      "url":"/mx/admin/component/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[
         {
            "code":"mx-admin-component-category",
            "name":"mx-admin-component-category",
            "url":"/mx/admin/component/category/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-component",
            "children":[

            ]
         },
         {
            "code":"mx-admin-component-type",
            "name":"mx-admin-component-type",
            "url":"/mx/admin/component/type/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-component",
            "children":[

            ]
         }
      ]
   },
   {
      "code":"mx-admin-component-category",
      "name":"mx-admin-component-category",
      "url":"/mx/admin/component/category/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-component",
      "children":[

      ]
   },
   {
      "code":"mx-admin-component-type",
      "name":"mx-admin-component-type",
      "url":"/mx/admin/component/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-component",
      "children":[

      ]
   },
   {
      "code":"mx-admin-manufacturer",
      "name":"mx-admin-manufacturer",
      "url":"/mx/admin/manufacturer/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"mx-admin-menu-configuration",
      "name":"mx-admin-menu-configuration",
      "url":"/mx/admin/menu/configuration/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc",
      "name":"mx-admin-sourcedoc",
      "url":"/mx/admin/sourcedoc/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[
         {
            "code":"mx-admin-sourcedoc-disposition",
            "name":"mx-admin-sourcedoc-disposition",
            "url":"/mx/admin/sourcedoc/disposition/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-issuer",
            "name":"mx-admin-sourcedoc-issuer",
            "url":"/mx/admin/sourcedoc/issuer/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-template-analysis",
            "name":"mx-admin-sourcedoc-template-analysis",
            "url":"/mx/admin/sourcedoc/template/analysis/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         },
         {
            "code":"mx-admin-sourcedoc-type",
            "name":"mx-admin-sourcedoc-type",
            "url":"/mx/admin/sourcedoc/type/index.html",
            "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
            "parentCode":"mx-admin-sourcedoc",
            "children":[

            ]
         }
      ]
   },
   {
      "code":"mx-admin-sourcedoc-disposition",
      "name":"mx-admin-sourcedoc-disposition",
      "url":"/mx/admin/sourcedoc/disposition/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-issuer",
      "name":"mx-admin-sourcedoc-issuer",
      "url":"/mx/admin/sourcedoc/issuer/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-template-analysis",
      "name":"mx-admin-sourcedoc-template-analysis",
      "url":"/mx/admin/sourcedoc/template/analysis/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-admin-sourcedoc-type",
      "name":"mx-admin-sourcedoc-type",
      "url":"/mx/admin/sourcedoc/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":"mx-admin-sourcedoc",
      "children":[

      ]
   },
   {
      "code":"mx-ata-administration",
      "name":"mx-ata-administration",
      "url":"/mx/ata/administration/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   }
]



acObj = [
   {
      "code":"ac-admin-aircraft-panels",
      "name":"ac-admin-aircraft-panels",
      "url":"/ac/admin/aircraft/panels/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-admin-aircraft-type",
      "name":"ac-admin-aircraft-type",
      "url":"/ac/admin/aircraft/type/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-admin-aircraft-zones",
      "name":"ac-admin-aircraft-zones",
      "url":"/ac/admin/aircraft/zones/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   },
   {
      "code":"ac-portal",
      "name":"ac-portal",
      "url":"/ac/portal/index.html",
      "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed elit a magna tempor pretium at quis nisl.",
      "parentCode":null,
      "children":[

      ]
   }
]




# GET MENU
router.get '/', (req, res, next) ->
  prefix = req.query.prefix or ''

  if req.query.prefix=='mx'
    responseObj = mxObj

  if req.query.prefix=='ac'
    responseObj = acObj

  console.log req.query.prefix
  if req.query.prefix==undefined
    responseObj = fullObj

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))



module.exports = router

