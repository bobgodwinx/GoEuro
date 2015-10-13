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
    GECommunicatorTimeoutError
};

extern NSString *const GECommunicatorErrorDomain;

@interface GECommunicator : NSObject <NSURLSessionDelegate>

- (instancetype)initWithBaseURL:(NSURL *)baseURL;

- (void)fetchContentsWith:(NSDictionary *)parameters
                  success:(void (^)(NSDictionary *response))success
                  failure:(void (^)(NSError *error))failure;

@end
