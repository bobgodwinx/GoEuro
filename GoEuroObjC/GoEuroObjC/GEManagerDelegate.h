//
//  GEManagerDelegate.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//
@import Foundation;

@protocol GEManagerDelegate <NSObject>
/**
 A method that notifies the controller that locations were successfully returned
 */
- (void)managerDidFinishFetchingLocations:(NSArray *)locations;
/**
 A method that notifies the controller that locations request failed
 */
- (void)managerDidFailFetchingLocationsWithError:(NSError *)error;

//@property (nonatomic) NSString *protocolProperty;

@end
