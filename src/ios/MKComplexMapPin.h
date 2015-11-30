//
//  MKComplexMapPin.h
//  HelloCordova
//
//  Created by Victor Zimmer on 13/11/15.
//
//

#import <MapKit/MapKit.h>

@interface MKComplexMapPin : MKPointAnnotation
{
    CGFloat mapId;
    CGFloat pinColor;
    BOOL customImage;
    NSString* pinImage;
    CGFloat pinImageOffsetX;
    CGFloat pinImageOffsetY;
    BOOL draggable;
    BOOL canShowCallout;
    BOOL showInfoButton;
}

@property(nonatomic, readwrite) CGFloat mapId;
@property(nonatomic, readwrite) CGFloat pinColor;
@property(nonatomic, readwrite) BOOL customImage;
@property(nonatomic, readwrite) NSString* pinImage;
@property(nonatomic, readwrite) CGFloat pinImageOffsetX;
@property(nonatomic, readwrite) CGFloat pinImageOffsetY;
@property(nonatomic, readwrite) BOOL draggable;
@property(nonatomic, readwrite) BOOL canShowCallout;
@property(nonatomic, readwrite) BOOL showInfoButton;

@end
