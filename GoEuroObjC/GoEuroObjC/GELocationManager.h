//
//  GElocationManager.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreLocation;

@protocol GELocationManagerDelegate;

typedef NS_ENUM(NSInteger, GELocationManagerError){
    GELocationManagerUnknownError,
    GELocationManagerFailFindingLocalityError,
    GELocationManagerAuthorizationError
};

FOUNDATION_EXPORT NSString *__nonnull const GELocationManagerErrorDomain;

@interface GELocationManager : NSObject <CLLocationManagerDelegate>
/**
 Designated initializer that takes a GELocationManagerDelegate.
 */
- (nonnull instancetype)initWithDelegate:(__nullable id <GELocationManagerDelegate>)aDelegate NS_DESIGNATED_INITIALIZER;
/**
 Starts a location request.
 */
- (void)requestCurrentLocation;

@end
