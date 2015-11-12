//
//  MapKit.m
//
//
//  Created by Victor Zimmer on 09/11/15.
//
//

#import "MapKit.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//@interface ViewController : UIViewController <MKMapViewDelegate>

@implementation MapKit

CLLocationManager* locationManager;
UIWebView* webView;


- (id)init
{

}

- (void)test:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"MapKit, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];



    [self success:result callbackId:callbackId];
}

- (void)checkLocationAuthStatus:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];

    CLAuthorizationStatus* authStatus = [CLLocationManager authorizationStatus];

    NSString* resultString;

    if (authStatus == kCLAuthorizationStatusAuthorized) {
        resultString = @"LOCATION_AUTH_AUTHORIZED";
    }
    else if (authStatus == kCLAuthorizationStatusAuthorizedAlways) {
        resultString = @"LOCATION_AUTH_AUTHORIZED_ALWAYS";
    }
    else if (authStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        resultString = @"LOCATION_AUTH_AUTHORIZED_WHEN_IN_USE";
    }
    else if (authStatus == kCLAuthorizationStatusNotDetermined) {
        resultString = @"LOCATION_AUTH_NOT_DETERMINED";
    }
    else if (authStatus == kCLAuthorizationStatusRestricted) {
        resultString = @"LOCATION_AUTH_RESTRICTED";
    }
    else if (authStatus == kCLAuthorizationStatusDenied) {
        resultString = @"LOCATION_AUTH_DENIED";
    }


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:resultString];



    [self success:result callbackId:callbackId];
}

- (void)requestLocationWhenInUsePermission:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];




    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:@"OK"];

    [self success:result callbackId:callbackId];
}


- (void)requestLocationAlwaysPermission:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];




    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:@"OK"];

    [self success:result callbackId:callbackId];

}


- (void)createMapView:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat height = [[[command arguments] objectAtIndex:1]floatValue];
    CGFloat width = [[[command arguments] objectAtIndex:2]floatValue];
    CGFloat xPos = [[[command arguments] objectAtIndex:3]floatValue];
    CGFloat yPos = [[[command arguments] objectAtIndex:4]floatValue];

    webView = self.webView;

    MKMapView* mapView = [[MKMapView alloc]initWithFrame:CGRectMake(xPos, yPos, width, height)];
    mapView.tag = mapId;
    mapView.delegate = self;
    [webView addSubview:mapView];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];
}


- (void)removeMapView:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [webView viewWithTag:mapId];
    [mapView removeFromSuperview];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)changeMapHeight:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat height = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(mapView.frame.origin.x, mapView.frame.origin.y, mapView.frame.size.width, height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}

- (void)changeMapWidth:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat width = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(mapView.frame.origin.x, mapView.frame.origin.y, width, mapView.frame.size.height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}

- (void)changeMapBounds:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat height = [[[command arguments] objectAtIndex:1]floatValue];
    CGFloat width = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(mapView.frame.origin.x, mapView.frame.origin.y, width, height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}

- (void)changeMapXPos:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat XPos = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(XPos, mapView.frame.origin.y, mapView.frame.size.width, mapView.frame.size.height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}

- (void)changeMapYPos:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat YPos = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(mapView.frame.origin.x, YPos, mapView.frame.size.width, mapView.frame.size.height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}

- (void)changeMapPosition:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    CGFloat XPos = [[[command arguments] objectAtIndex:1]floatValue];
    CGFloat YPos = [[[command arguments] objectAtIndex:1]floatValue];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    [mapView setFrame:CGRectMake(XPos, YPos, mapView.frame.size.width, mapView.frame.size.height)];


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];


}



- (void)isShowingUserLocation:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [webView viewWithTag:mapId];

    NSString* stringRes;

    if (mapView.userLocationVisible) {
        stringRes = @"true";
    }
    else
    {
        stringRes = @"false";
    }

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:stringRes];

    [self success:result callbackId:callbackId];

}


- (void)showMapScale:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    // MKMapView* mapView = [webView viewWithTag:mapId];

    UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
    MKMapView* mapView = [mainWindow viewWithTag:mapId];


    NSLog(@"%@", mapView);

    mapView.showsScale = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapScale:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsScale = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)showMapUserLocation:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsUserLocation = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapUserLocation:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsUserLocation = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)showMapCompass:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsCompass = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapCompass:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsCompass = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)showMapPointsOfInterest:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsPointsOfInterest = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapPointsOfInterest:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsPointsOfInterest = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)showMapBuildings:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsBuildings = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapBuildings:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsBuildings = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)showMapTraffic:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsTraffic = YES;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}

- (void)hideMapTraffic:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* mapId = [[command arguments] objectAtIndex:0];
    MKMapView* mapView = [self.webView viewWithTag:mapId];

    mapView.showsTraffic = NO;


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:mapId];

    [self success:result callbackId:callbackId];

}





@end
