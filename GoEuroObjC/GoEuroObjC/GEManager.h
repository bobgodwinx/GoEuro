//
//  GEManager.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import UIKit;

@class GEQuery;
@protocol GEManagerDelegate;
/**
 The manager is a semi facede pattern that masks the communicator totally from other controllers.
 */
@interface GEManager : NSObject

@property (nonnull, nonatomic) UIColor *geRoyalBlueColor;
@property (nonnull, nonatomic) UIColor *geAliceBlueColor;

/**
 Designated Initializer method. Needs a Delegate that conforms to GEManagerDelegate protocol.
 */
- (nonnull instancetype)initWithDelegate:(__nullable id <GEManagerDelegate>)aDelegate NS_DESIGNATED_INITIALIZER;
/**
 fetchLocationsWithQuery makes request to the API for locations
 */
- (void)fetchLocationsWithQuery:(nonnull GEQuery *)query;

@end
