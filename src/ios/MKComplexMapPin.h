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
    CGFloat pinColor;
    BOOL draggable;
    BOOL canShowCallout;
    BOOL showInfoButton;
    BOOL customImage;
    NSString* imageLocation;
}

@property(nonatomic, readwrite) CGFloat pinColor;
@property(nonatomic, readwrite) BOOL draggable;
@property(nonatomic, readwrite) BOOL canShowCallout;
@property(nonatomic, readwrite) BOOL showInfoButton;
@property(nonatomic, readwrite) BOOL customImage;
@property(nonatomic, readwrite) NSString* imageLocation;

@end
