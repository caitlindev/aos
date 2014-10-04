express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



eventObj = [
  {
    id: 1000
    type: "aos"
    tailNbr: "ZF2245"
    station: "env"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1411168295
    eventCode: "sos"
    rootCause: "C"
    ataCode: [{
      chapter: "03"
      aircraft: "MD80"
      section: "14"
    }]
    status: "adv"
    state: "open"
    createdUnixTimestamp: 1399593600
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 2000
    type: "mco"
    tailNbr: "A1234"
    station: "las"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1411169295
    eventCode: "spr"
    rootCause: "ENG"
    ataCode: [{
      chapter: "18"
      aircraft: "MD80"
      section: "21"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1409904000
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 3000
    type: "hpr"
    tailNbr: "FF2044"
    station: "bli"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1411169295
    eventCode: "sos"
    rootCause: "A"
    ataCode: [{
      chapter: "42"
      aircraft: "MD80"
      section: "59"
    }]
    status: "rdy"
    state: "open"
    createdUnixTimestamp: 1409907600
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1400624140
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
    id: 8000
    type: "mco"
    tailNbr: "FF2044"
    station: "env"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1411169295
    eventCode: "hpr"
    rootCause: "E"
    ataCode: [{
      chapter: "74"
      aircraft: "MD80"
      section: "19"
    }]
    status: "rdy"
    state: "open"
    createdUnixTimestamp: 1409911200
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 7000
    type: "mco"
    tailNbr: "FE3309"
    station: "aza"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "hpr"
    rootCause: "D"
    ataCode: [{
      chapter: "10"
      aircraft: "MD80"
      section: "03"
    }]
    status: "etr"
    state: "closed"
    createdUnixTimestamp: 1409918400
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 6000
    type: "mco"
    tailNbr: "BN3765"
    station: "las"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "sos"
    rootCause: "CK"
    ataCode: [{
      chapter: "35"
      aircraft: "MD80"
      section: "65"
    }]
    status: "adv"
    state: "closed"
    createdUnixTimestamp: 1409918400
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 5000
    type: "aos"
    tailNbr: "GT4467"
    station: "las"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "aos"
    rootCause: "F"
    ataCode: [{
      chapter: "98"
      aircraft: "MD80"
      section: "34"
    }]
    status: "adv"
    state: "open"
    createdUnixTimestamp: 1409918400
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
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
    id: 17000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "spr"
    rootCause: "FCD"
    ataCode: [{
      chapter: "54"
      aircraft: "MD80"
      section: "28"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 18000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "hpr"
    rootCause: "FOD"
    ataCode: [{
      chapter: "37"
      aircraft: "MD80"
      section: "99"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 19000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "hpr"
    rootCause: "G"
    ataCode: [{
      chapter: "64"
      aircraft: "MD80"
      section: "22"
    }]
    status: "etr"
    state: "closed"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 15000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "hpr"
    rootCause: "HCK"
    ataCode: [{
      chapter: "06"
      aircraft: "MD80"
      section: "51"
    }]
    status: "etr"
    state: "closed"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 13000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "aos"
    rootCause: "K"
    ataCode: [{
      chapter: "81"
      aircraft: "MD80"
      section: "02"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 41000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "hpr"
    rootCause: "FCD"
    ataCode: [{
      chapter: "71"
      aircraft: "MD80"
      section: "49"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
  {
    id: 4000
    type: "sos"
    tailNbr: "KH045"
    station: "lax"
    location: "1"
    description: "Lorem ipsum..."
    advisoryUnixTimestamp: 1404419682
    eventCode: "spr"
    rootCause: "FOD"
    ataCode: [{
      chapter: "63"
      aircraft: "MD80"
      section: "13"
    }]
    status: "etr"
    state: "open"
    createdUnixTimestamp: 1404140644
    createdBy:
      loginId: "john.smith"
      empId: "123456"
      fullName: "John Smith"

    modifiedUnixTimestamp: 1404250644
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
      createdUnixTimestamp: 1404140644
      createdBy:
        loginId: "john.smith"
        empId: "123456"
        fullName: "John Smith"

      replies: []
      attachments: []
    ]
    documents: [
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "http://www.lekiuk.com/cd-images/RESIZED/MISC.%20Safety%20and%20diverse/MD80-MD90/md80%20interior%208.jpg"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
      {
        ref: "ABCD1234"
        name: "SomeDocument.pdf"
        path: "SomeDocument.pdf"
        createdUnixTimestamp: "1404140644"
      }
    ]
  }
]



eventVersionObj = [
  {
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "sos",
    "status": "adv",
    "description": "Event created",
    "createdUnixTimestamp": 1404140644,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Changed event code",
    "createdUnixTimestamp": 1404150644,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Added a new part",
    "createdUnixTimestamp": 1404170644,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "adv",
    "description": "Changed station",
    "createdUnixTimestamp": 1404220644,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Changed status to ETR",
    "createdUnixTimestamp": 1404230009,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "etr",
    "description": "Change ATA code",
    "createdUnixTimestamp": 1404245803,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Changed status to RDY",
    "createdUnixTimestamp": 1404251928,
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
    "eventId": 7000,
    "tailNbr": "KH045",
    "eventCode": "aos",
    "status": "rdy",
    "description": "Closed event",
    "createdUnixTimestamp": 1404372253,
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




count = 1

# CREATE EVENTS
router.post '/', (req, res, next) ->
  req.body.id = count
  count++
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