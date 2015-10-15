//
//  GEBuilder.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;

@class GEQuery;

@interface GEBuilder : NSObject
/**
 Builds parameter for the server request from a GEQuery type.
 */
- (nonnull NSDictionary*)buildParamentersFromQuery:(nonnull GEQuery *)query;
/**
 Builds the server response and returns an array
 */
- (nullable NSArray *)buildServerResponse:(nonnull NSArray *)response;

@end
