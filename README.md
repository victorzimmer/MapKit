# MapKit
## Current Version: 0.0.2

New version of MapKit (there seem to be lots of older versions around). Currently iOS-only, but will support iOS, Android and Windows Phone.

MapKit is a plugin designed to provide Cordova/PhoneGap apps with the ability to create, modify, use and destroy mapViews that are separate from

MapKit uses Apple Maps on iOS, Google Maps on Android and Bing Maps on Windows Phone.
API tries to be consistent over all platforms and will automatically figure out the current platform and react appropriately.

## Installation

Installation is done thru Cordova/PhoneGap CLI.

For Cordova:
`$ cordova plugin add https://github.com/victorzimmer/MapKit.git`

For PhoneGap:
`$ phonegap plugin add https://github.com/victorzimmer/MapKit.git`

MapKit uses the identifier `no.hotdot.mapkit`

## Usage

MapKit exposes itself thru the global object `MKInterface` that is attached to the `window` object.
This can be accessed globally as just `MKInterface`.

### Example
```
var map = new MKInterface.MKMap('testMap')  //Creates a new map with ID "testMap"
map.setBounds(500, 250)                     //Sets the map to be 500 high and 250 wide
map.setPosition(50,200)                     //Sets the maps position to be 50 from the left and 200 from the top
map.createMap()                             //Creates the MapView and shows it on the screen
```


### Full Documentation

`MKInterface` contains several different MapKit related functions.

#### Functions

`MKInterface.getMapByArrayId(arrayId)` Recieves a numeric ID and returns the appropriate MKMap object. ArrayID is set by MapKit.

`MKInterface.getMapByMapId(mapId)` Recieves a string ID and returns the appropriate MKMap object. MapID can be set manually.

#### Objects

`MKInterface.locationManager` Unique instance of `MKLocationManager` (You can't create any more of these). Manages the users location for all maps, especially location access.

`MKInterface.locationManager.canUseLocation` (read-only Boolean) representing wether or not the app's authorization for location usage is high enough to use the map-related location functions (UserLocation & Compass).

`MKInterface.locationManager.locationAuthStatus` (read-only String) representing the current authorization level. Possible values: `LOCATION_AUTH_AUTHORIZED, LOCATION_AUTH_AUTHORIZED_ALWAYS, LOCATION_AUTH_AUTHORIZED_WHEN_IN_USE, LOCATION_AUTH_NOT_DETERMINED, LOCATION_AUTH_RESTRICTED, LOCATION_AUTH_DENIED, LOCATION_AUTH_NOT_CHECKED`

`MKInterface.locationManager.checkLocationAuthStatus(callback)` (method) Will cause the locationManager to re-check the current authorization. Callback function is optional, if passed it will recieve one parameter containing the new authorization level. Wether a callback is passed or not `MKInterface.locationManager.locationAuthStatus` will be updated with the new value.

`MKInterface.locationManager.requestLocationWhenInUsePermission` (method) Will cause the locationManager to promt the user for location access when the app is in use (Enough for all MapKit functionality).
Note: Currently this requires you to manually edit the info.plist for iOS and add `NSLocationWhenInUseUsageDescription`. Value should be a string defining why your app want to use the users location. If this is not done iOS will not prompt the user and you app will not get location access.

`MKInterface.locationManager.requestLocationAlwaysPermission` (method) Will cause the locationManager to promt the user for location access whenever the app wants to.
Note: Currently this requires you to manually edit the info.plist for iOS and add `NSLocationAlwaysUsageDescription`. Value should be a string defining why your app want to use the users location. If this is not done iOS will not prompt the user and you app will not get location access.

#### Prototype Functions (Classes)

##### MKMap

`MKInterface.MKMap` (Prototype Function / Class) Initialized as `yourMapVariable = new MKInterface.MKMap(mapId)`. There is no limit to the amount of maps that can be created and when created it can be treated as any other object. `mapId` is optional, if not set MapKit will automatically assign a unique id formatted like "map_someNumber".

Returns a new object of the type `MKMap`.



###### Variables

`MKMap.locationManager` (Object) a reference to the same locationManager you can access thru `MKInterface.locationManager`.

`MKMap.created` (read-only Boolean) Whether or not the MapView has been created.

`MKMap.mapId` (read-only String) Alphanumeric unique ID for the map.

`MKMap.mapArrayId` (read-only Number) Numeric unique ID for the map. Counts from zero, increasing by one for every map initialized.

`MKMap.options` (read-only Object)

| Value  | Description |
| ------------- | ------------- |
| `MKMap.options.xPos` Number  | The current x position of the MapView.  |
| `MKMap.options.yPos` Number  | The current y position of the MapView.  |
| `MKMap.options.height` Number  | The current height of the MapView.  |
| `MKMap.options.mapScale` Boolean  | Whether or not scale is shown on the map.  |
| `MKMap.options.mapBuildings` Boolean  | Whether or not buidings are shown on the map.  |
| `MKMap.options.mapPointsOfInterest` Boolean  | Whether or not Points of Interest (shops, etc) are shown on the map.
| `MKMap.options.mapTraffic` Boolean  | Whether or not traffic is shown on the map.  ||
| `MKMap.options.mapUserLocation` Boolean  | Whether or not the users location is shown on the map.  |
| `MKMap.options.mapCompass` Boolean  | Whether or not a digital compass is shown on the map.  |

`MKMap.setBounds(height, width)` (Method) Used to set the height and width of the map. Can be called both before and after map creation. Accepts two numeric parameters e.g `(height, width)` or one object e.g `({height: height, width: width})`.



###### View-Manipulation Methods

`MKMap.setSize(height, width)` (Method) Alias of `MKMap.setBounds()`.

`MKMap.setPosition` (Method) Used to set the x and y position of the map. Can be called both before and after map creation. Accepts two numeric parameters e.g `(x, y)` or one object e.g `({x: x, y: y})`.

`MKMap.createMap()` (Method) Used to create the MapView for the map. Only needs to be called once, any call after that will be ignored.

`MKMap.showMap()` (Method) Used to show the map. (View is automatically shown when created).

`MKMap.hideMap()` (Method) Used to hide the map. Hidden maps do in interact with the user and touch events will not be captured.

`MKMap.destroyMap()` (Method) Used to destroy the map. This will remove the map entirely. In most cases hiding the map would make more sense. Destroyed maps CAN NOT be reused or recreated, you'll have to create a new map.  



###### Map-Manipulation Methods

`MKMap.showMapScale()` (Method) Shows the distance scale on the map.

`MKMap.hideMapScale()` (Method) Hides the distance scale from the map.


`MKMap.showMapBuildings()` (Method) Shows buildings on the map.

`MKMap.hideMapBuildings()` (Method) Hides buildings from the map.


`MKMap.showMapTraffic()` (Method) Shows traffic on the map.

`MKMap.hideMapTraffic()` (Method) Hides traffic from the map.


`MKMap.showMapPointsOfInterest()` (Method) Shows Points of Interest on the map.

`MKMap.hideMapPointsOfInterest()` (Method) Hides Points of Interest from the map.


`MKMap.showMapCompass()` (Method) Shows the compass on the map. _Requires authorization to use the users current location. If authorization is not already given MapKit will automatically try to prompt the user for authorization. Compass will be activated whether authorization is given or not, but will only be visible if authorized._

`MKMap.hideMapCompass()` (Method) Hides the compass from the map.


`MKMap.showMapUserLocation()` (Method) Shows the users location on the map. _Requires authorization to use the users current location. If authorization is not already given MapKit will automatically try to prompt the user for authorization. User location will be activated whether authorization is given or not, but will only be visible if authorized._

`MKMap.hideMapUserLocation()` (Method) Hides the users location from the map.

`MKMap.userLocationVisible(callback)` (Method) Returns a Boolean representing the visibility of the users current location. If _true_ the users location IS showing on the map, if _false_ its not. If it's enabled and not showing its either because the system is unable to get its current location or because your app is not authorized to recieve location. Callback is **required** or the method call will be ignored.

## Upcoming Features

* Map pins [Since v0.0.2 you can create standard red pins]
* Map and pin click events with JavaScript callback
* Implementation of Polygons
* Ability to place HTML elements on top of WebView
* Android support
* Windows Phone support

## Samples

Sample applications are avaliable in their own repository: [MapKit Samples](https://github.com/victorzimmer/MapKit-Samples)

## License

MapKit is licensed under the HotDot Open Source License. [HotDot Open Source License](http://hotdot.no/hotdot_open-source_license.txt).

In short, you can use MapKit however you want both privately and commerically. You may modify and redistribute MapKit (or if you really want to just redistribute it). If you make useful changes or fix bugs reporting them here is appriciated, but not required.

You may earn 1$ by using it and be nice and credit me or become the next big app-hit and never mention my name (Though I would really appreciate if you do!).

## Credits

* [This MapKit Plugin](https://github.com/imhotep/MapKit) for inspiration (No code borrowed though)
* [Politikontroller](http://www.politikontroller.no) (A Norwegian app) Some of the time devoted to MapKit was done in hours I worked for them. They kindly let me keep all MapKit related code for all purposes.
* Caffeine.
* Uhm Victor Zimmer (Me) @ [HotDot](http://www.hotdot.no) (For making this thing I guess)

Just a few more I want to give a huge "Thank You"
* GitHub for this repo and their Mac Apps ([Atom Editor](https://atom.io) & [GitHub Desktop](https://desktop.github.com))
* [Brackets Editor](http://brackets.io)

_MapKit as a name is somewhat copied of Apple's name for their map integration, same applies to the 'MK'-prefix._
