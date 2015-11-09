//
//  MapKit.m
//  
//
//  Created by Victor Zimmer on 09/11/15.
//
//

#import "MapKit"

@implementation MapKit

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

@end