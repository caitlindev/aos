express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



eventObj = [
  {
    id: 1
    type: "spr"
    tailNbr: "904NV-E"
    station: "hnl"
    location: "Gate 19"
    description: "LR tire is flat. Needs replacement"
    advisoryUnixTimestamp: null
    etrUnixTimestamp: null
    eventCode: "spr"
    rootCause: "d"
    ataCode: [{
      chapter: "03"
      aircraft: "MD80"
      section: "14"
    }]
    status: "rdy"
    state: "closed"
    createdUnixTimestamp: 1412111700
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1412164800
    modifiedBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    parts: [
      {
        id: 1000
        part: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
        status: "In Stock"
      }
      {
        id: 2000
        part: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
        status: "On Order"
      }
      {
        id: 3000
        part: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
        status: "In Stock"
      }
      {
        id: 4000
        part: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
        status: "In Stock"
      }
    ]
    comments: [
      id: 1
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ornare risus. Morbi pharetra faucibus faucibus. Fusce nisl tortor, tempor sed purus non, dictum dignissim quam. Sed nulla orci, sodales ac egestas sed, lacinia non velit. Morbi pretium rutrum eros ut convallis. Phasellus a commodo risus. Nunc tempor, odio ac suscipit convallis, augue augue rhoncus nulla, et mattis elit nisi id magna. Duis nec felis in orci tristique ultrices. Pellentesque in nulla ac est elementum egestas. Cras vitae ante rhoncus, fringilla tortor sit amet, suscipit lorem. "
      createdUnixTimestamp: 1412112700
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      ref: "ABCD1234"
      name: "SomeDocument.pdf"
      path: "SomeDocument.pdf"
      createdUnixTimestamp: "1404140644"
    ]
  }
  {
    id: 2
    type: "hpr"
    tailNbr: "215NV"
    station: "sfb"
    location: "Gate 6"
    description: "Wash and wax"
    advisoryUnixTimestamp: null
    etrUnixTimestamp: 1411056000
    eventCode: "hpr"
    rootCause: "s"
    ataCode: [{
      chapter: "18"
      aircraft: "MD80"
      section: "21"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1412141400
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1412141400
    modifiedBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    parts: [
      {
        id: 1000
        part: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
        status: "In Stock"
      }
      {
        id: 2000
        part: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
        status: "On Order"
      }
      {
        id: 3000
        part: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
        status: "In Stock"
      }
      {
        id: 4000
        part: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
        status: "In Stock"
      }
    ]
    comments: [
      id: 1
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ornare risus. Morbi pharetra faucibus faucibus. Fusce nisl tortor, tempor sed purus non, dictum dignissim quam. Sed nulla orci, sodales ac egestas sed, lacinia non velit. Morbi pretium rutrum eros ut convallis. Phasellus a commodo risus. Nunc tempor, odio ac suscipit convallis, augue augue rhoncus nulla, et mattis elit nisi id magna. Duis nec felis in orci tristique ultrices. Pellentesque in nulla ac est elementum egestas. Cras vitae ante rhoncus, fringilla tortor sit amet, suscipit lorem. "
      createdUnixTimestamp: 1412151400
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: [
        ref: "C1234"
        name: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
      ]
    ]
    documents: [
      ref: "ABCD1234"
      name: "SomeDocument.pdf"
      path: "SomeDocument.pdf"
      createdUnixTimestamp: "1404140644"
    ]
  }
  {
    id: 3
    type: "aos"
    tailNbr: "414NV"
    station: "iwa"
    location: "Gate 1"
    description: "Oil leak RH engine valve"
    advisoryUnixTimestamp: 1412146500
    etrUnixTimestamp: null
    eventCode: "aos"
    rootCause: "e"
    ataCode: [{
      chapter: "42"
      aircraft: "MD80"
      section: "59"
    }]
    status: "adv"
    state: "open"
    createdUnixTimestamp: 1412131800
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1412131800
    modifiedBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    parts: [
      {
        id: 1000
        part: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
        status: "In Stock"
      }
      {
        id: 2000
        part: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
        status: "On Order"
      }
      {
        id: 3000
        part: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
        status: "In Stock"
      }
      {
        id: 4000
        part: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
        status: "In Stock"
      }
    ]
    comments: [
      id: 1
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ornare risus. Morbi pharetra faucibus faucibus. Fusce nisl tortor, tempor sed purus non, dictum dignissim quam. Sed nulla orci, sodales ac egestas sed, lacinia non velit. Morbi pretium rutrum eros ut convallis. Phasellus a commodo risus. Nunc tempor, odio ac suscipit convallis, augue augue rhoncus nulla, et mattis elit nisi id magna. Duis nec felis in orci tristique ultrices. Pellentesque in nulla ac est elementum egestas. Cras vitae ante rhoncus, fringilla tortor sit amet, suscipit lorem. "
      createdUnixTimestamp: 1412131800
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      ref: "ABCD1234"
      name: "SomeDocument.pdf"
      path: "SomeDocument.pdf"
      createdUnixTimestamp: "1404140644"
    ]
  }
  {
    id: 4
    type: "sos"
    tailNbr: "410NV"
    station: "okc"
    location: "MRO"
    description: "In for Heavy Check for 1 month. Back on 10/10/14"
    advisoryUnixTimestamp: 1412874000
    etrUnixTimestamp: null
    eventCode: "sos"
    rootCause: "hck"
    ataCode: [{
      chapter: "74"
      aircraft: "MD80"
      section: "19"
    }]
    status: "adv"
    state: "open"
    createdUnixTimestamp: 1411398000
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1411398000
    modifiedBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    parts: [
      {
        id: 1000
        part: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
        status: "In Stock"
      }
      {
        id: 2000
        part: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
        status: "On Order"
      }
      {
        id: 3000
        part: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
        status: "In Stock"
      }
      {
        id: 4000
        part: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
        status: "In Stock"
      }
    ]
    comments: [
      id: 1
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ornare risus. Morbi pharetra faucibus faucibus. Fusce nisl tortor, tempor sed purus non, dictum dignissim quam. Sed nulla orci, sodales ac egestas sed, lacinia non velit. Morbi pretium rutrum eros ut convallis. Phasellus a commodo risus. Nunc tempor, odio ac suscipit convallis, augue augue rhoncus nulla, et mattis elit nisi id magna. Duis nec felis in orci tristique ultrices. Pellentesque in nulla ac est elementum egestas. Cras vitae ante rhoncus, fringilla tortor sit amet, suscipit lorem. "
      createdUnixTimestamp: 1411398000
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      ref: "ABCD1234"
      name: "SomeDocument.pdf"
      path: "SomeDocument.pdf"
      createdUnixTimestamp: "1404140644"
    ]
  }
  {
    id: 5
    type: "aos"
    tailNbr: "412NV"
    station: "pia"
    location: "Pad 5"
    description: "Damage LR flap"
    advisoryUnixTimestamp: 1412201700
    etrUnixTimestamp: null
    eventCode: "aos"
    rootCause: "fod"
    ataCode: [{
      chapter: "10"
      aircraft: "MD80"
      section: "03"
    }]
    status: "adv"
    state: "open"
    createdUnixTimestamp: 1412060400
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1412060400
    modifiedBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    parts: [
      {
        id: 1000
        part: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
        status: "In Stock"
      }
      {
        id: 2000
        part: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
        status: "On Order"
      }
      {
        id: 3000
        part: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
        status: "In Stock"
      }
      {
        id: 4000
        part: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
        status: "In Stock"
      }
    ]
    comments: [
      id: 1
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ornare risus. Morbi pharetra faucibus faucibus. Fusce nisl tortor, tempor sed purus non, dictum dignissim quam. Sed nulla orci, sodales ac egestas sed, lacinia non velit. Morbi pretium rutrum eros ut convallis. Phasellus a commodo risus. Nunc tempor, odio ac suscipit convallis, augue augue rhoncus nulla, et mattis elit nisi id magna. Duis nec felis in orci tristique ultrices. Pellentesque in nulla ac est elementum egestas. Cras vitae ante rhoncus, fringilla tortor sit amet, suscipit lorem. "
      createdUnixTimestamp: 1412060400
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      ref: "ABCD1234"
      name: "SomeDocument.pdf"
      path: "SomeDocument.pdf"
      createdUnixTimestamp: "1404140644"
    ]
  }
]



eventVersionObj = [
  {
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 1,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 2,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 3,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 4,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 5,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 6,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412111700,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Consectetur adipiscing elit",
    "createdUnixTimestamp": 1412111895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Nulla rutrum arcu eu vestibulum",
    "createdUnixTimestamp": 1412121895,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Proin lectus odio",
    "createdUnixTimestamp": 1412124999,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Porta eu pretium quis",
    "createdUnixTimestamp": 1412125807,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Sed in nisl eget justo scelerisque imperdiet",
    "createdUnixTimestamp": 1412126307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  },{
    "eventId": 7,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Lorem ipsum dolor sit amet",
    "createdUnixTimestamp": 1412186307,
    "createdBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    },
    "modifiedBy": {
      "loginId": "john.smith",
      "empId": "123456",
      "fullName": "John Smith"
    }
  }
]







# GET EVENTS
router.get '/', (req, res, next) ->
  responseObj = eventObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))






# CREATE EVENTS
router.post '/', (req, res, next) ->
  count = eventObj.length + 1
  req.body.id = count
  eventObj.push(req.body)
  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)






# GET SINGLE EVENT
router.get '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < eventObj.length
    event = eventObj[i]
    if event.id.toString() == requestedId.toString()
      responseObj = event
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))



# UPDATE EVENT BY ID
router.put '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0
  while i < eventObj.length
    event = eventObj[i]
    if event.id.toString() == requestedId.toString()
      eventObj[i] = req.body
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)






# GET EVENT VERSION
router.get '/:id/versions', (req, res, next) ->
  requestedId = req.params.id

  i = 0
  responseObj = []
  while i < eventVersionObj.length
    event = eventVersionObj[i]
    if event.eventId.toString() == requestedId.toString()
      responseObj.push(event)

    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))





# GET EVENT VERSION BY TAIL NUMBER
router.get '/versions/:tailNbr', (req, res, next) ->
  requestedTailNbr = req.params.tailNbr

  i = 0
  responseObj = []
  while i < eventVersionObj.length
    event = eventVersionObj[i]
    console.log(event.tailNbr.toString() == requestedTailNbr.toString())
    if event.tailNbr.toString() == requestedTailNbr.toString()
      responseObj.push(event)

    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))






# CREATE COMMENT FOR EVENT
router.post '/:id/comments', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < eventObj.length
    event = eventObj[i]
    if event.id.toString() == requestedId.toString()
      responseObj = event
    i++

  responseObj.comments.push(req.body)
  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)









module.exports = router