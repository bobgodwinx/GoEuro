//
//  GELocationManagerDelegate.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@protocol GELocationManagerDelegate <NSObject>
/**
  Method called when the location is found to update the Location
 */
- (void)locationDidFindCurrentLocality:(NSString *)locality;
/**
  Method called when the location is not found
 */
- (void)locationDidFailFindinglocalityWithError:(NSError *)error;
/**
 Method called when the authorization status is changed.
 */
- (void)locationDidChangeAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus;
@end
