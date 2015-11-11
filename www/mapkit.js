var cordovaRef = window.PhoneGap || window.Cordova || window.cordova;

var MapArray = []

var MKMap = function (mapId) {
  if (mapId != undefined)
  {
    this.mapId = mapId
    this.mapArrayId = MapArray.push(this)
  }
  else
  {
    this.mapArrayId = MapArray.push(this)
    this.mapId = "map_" + this.mapArrayId
  }
  this.created = false
  this.options = {}
  this.options.xPos = 0
  this.options.yPos = 0
  this.options.height = 0
  this.options.width = 0
  this.options.mapScale = false
  this.options.mapTraffic = false
  this.options.mapCompass = false
  this.options.mapBuildings = false
  this.options.mapPointsOfInterest = false
  this.options.mapUserLocation = false
  this.setBounds = function (height, width) {
    if (this.created)
    {

    }
    else
    {
      this.options.height = height
      this.options.width = width
    }
  }
  this.setPosition = function (x, y) {
    if (this.created)
    {

    }
    else
    {
      this.options.xPos = x
      this.options.yPos = y
    }
  }
  this.execSuccess = function (data) {
    console.log("Executed native command successfully")
    console.log(data)
  }
  this.execFailure = function (err) {
    console.warn("MapKit failed to execute native command:")
    console.warn(err)
  }
  this.createMap = function (c) {
    console.log('Creating map')
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'createMapView', [this.mapId, this.options.height, this.options.width, this.options.xPos, this.options.yPos])
  }
  this.destroyMap = function () {

  }
  this.showMap = function () {

  }
  this.hideMap = function () {

  }

  this.showMapScale = function () {
    this.options.mapScale = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapScale', [this.mapId])
  }
  this.hideMapScale = function () {
    this.options.mapScale = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapScale', [this.mapId])
  }

  this.showMapCompass = function () {
    this.options.mapCompass = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapCompass', [this.mapId])
  }
  this.hideMapCompass = function () {

  }

  this.showMapTraffic = function () {
    this.options.mapTraffic = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapTraffic', [this.mapId])
  }
  this.hideMapTraffic = function () {

  }

  this.showMapBuildings = function () {

  }
  this.hideMapBuildings = function () {

  }

  this.showMapUserLocation = function () {

  }
  this.hideMapUserLocation = function () {

  }

  this.showMapPointsOfInterest = function () {

  }
  this.hideMapPointsOfInterest = function () {

  }

}

window.MKMap = MKMap
