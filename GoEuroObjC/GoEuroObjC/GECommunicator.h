//
//  GECommunicator.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSInteger, GECommunicatorError){
    GECommunicatorUnknownError = 0,
    GECommunicatorNetworkingError,
    GECommunicatorSerializationError,
    GECommunicatorInvalidResponseError,
    GECommunicatorNULLResponseError,
    GECommunicatorInvalidError,
    GECommunicatorTimeoutError
};


FOUNDATION_EXPORT NSString *__nonnull const GECommunicatorErrorDomain;
/**
 The communicator class is reponsible to make request to the API. Can only be called by the manager.
 */
@interface GECommunicator : NSObject
/**
 Fetch locations based on the user locale and search input.
 */
- (void)fetchLocationsWith:(nonnull NSDictionary *)parameters
                  success:(void (^__nonnull)(NSArray *_Nullable response))success
                  failure:(void (^__nonnull)(NSError *_Nullable error))failure;

@end
