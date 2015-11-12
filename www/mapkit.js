var cordovaRef = window.PhoneGap || window.Cordova || window.cordova || window.phonegap;

var MapArray = []
var MapDict = {}

var that;

var MKLocationManager = function () {
  this.locationAuthStatus = "LOCATION_AUTH_NOT_CHECKED"
  this.canUseLocation = false

  this.execSuccess = function (data) {
    console.log("#MKLocationManager() Executed native command successfully")
    console.log(data)
  }
  this.execFailure = function (err) {
    console.warn("#MKLocationManager() MapKit failed to execute native command:")
    console.warn(err)
  }

  this.handleLocationAuthStatus = function (locationAuthStatus) {
    console.log(locationAuthStatus)
    console.log(that)

    that.locationAuthStatus = locationAuthStatus

    if (locationAuthStatus == "LOCATION_AUTH_AUTHORIZED" || locationAuthStatus == "LOCATION_AUTH_AUTHORIZED_ALWAYS" || locationAuthStatus == "LOCATION_AUTH_AUTHORIZED_WHEN_IN_USE")
    {
      that.canUseLocation = true
    }
    else
    {
      that.canUseLocation = false
    }
  }
  this.checkLocationAuthStatus = function () {
    that = this; //Fix for this inside callback
    cordovaRef.exec(this.handleLocationAuthStatus, this.execFailure, 'MapKit', 'checkLocationAuthStatus')
  }
  this.requestLocationAlwaysPermission = function () {
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'requestLocationAlwaysPermission')
  }
  this.requestLocationWhenInUsePermission = function () {
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'requestLocationWhenInUsePermission')
  }
}

var locationManager = new MKLocationManager()
locationManager.checkLocationAuthStatus()

var MKMap = function (mapId) {
  if (mapId != undefined)
  {

    this.mapId = mapId
    // this.mapArrayId = MapArray.push(this)
  }
  else
  {
    this.mapId = "map_" + MapArray.length
    // this.mapId = "map_" + this.mapArrayId
  }

  if (MapDict[mapId] != undefined)
  {
    MapDict[mapId].destroyMap()
  }

  MapDict[mapId] = this;
  this.mapArrayId = MapArray.push(this) - 1

  this.locationManager = locationManager;

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
  this.options.mapPointsOfInterest = true
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
    console.log(`#MKMap(${this.mapId}) Executed native command successfully`)
    console.log(data)
  }
  this.execFailure = function (err) {
    console.warn(`#MKMap(${this.mapId}) MapKit failed to execute native command:`)
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
    if (!this.locationManager.canUseLocation)
    {
      console.warn("Attempt was made to use Location#Compass without system location access. MapKit will automatically attempt to ask for WhenInUse authorization.")
      this.locationManager.requestLocationWhenInUsePermission()
    }
    this.options.mapCompass = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapCompass', [this.mapId])
  }
  this.hideMapCompass = function () {
    this.options.mapCompass = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapCompass', [this.mapId])
  }

  this.showMapTraffic = function () {
    this.options.mapTraffic = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapTraffic', [this.mapId])
  }
  this.hideMapTraffic = function () {
    this.options.mapTraffic = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapTraffic', [this.mapId])
  }

  this.showMapBuildings = function () {
    this.options.mapBuildings = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapBuildings', [this.mapId])
  }
  this.hideMapBuildings = function () {
    this.options.mapBuildings = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapBuildings', [this.mapId])
  }

  this.showMapUserLocation = function () {
    if (!this.locationManager.canUseLocation)
    {
      console.warn("Attempt was made to use Location#UserLocation without system location access. MapKit will automatically attempt to ask for WhenInUse authorization.")
      this.locationManager.requestLocationWhenInUsePermission()
    }
    this.options.mapUserLocation = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapUserLocation', [this.mapId])
  }
  this.hideMapUserLocation = function () {
    this.options.mapUserLocation = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapUserLocation', [this.mapId])
  }

  this.showMapPointsOfInterest = function () {
    this.options.mapPointsOfInterest = true
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'showMapPointsOfInterest', [this.mapId])
  }
  this.hideMapPointsOfInterest = function () {
    this.options.mapPointsOfInterest = false
    cordovaRef.exec(this.execSuccess, this.execFailure, 'MapKit', 'hideMapPointsOfInterest', [this.mapId])
  }



  this.destroyMap = function () {

  }

}

window.MKInterface = {}
window.MKInterface.MKMap = MKMap
window.MKInterface.locationManager = locationManager
window.MKInterface.getMapByArrayId = function (aid) { return MapArray[aid] }
window.MKInterface.getMapByMapId = function (mid) { return MapDict[mid] }
