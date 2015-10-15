//
//  GELocation.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import CoreLocation;

typedef NS_ENUM(NSInteger, GELocationType){
    GELocationTypeUnKnown,
    GELocationTypeLocation,
    GELocationTypeStation,
    GELocationTypeAirPort
};

@interface GELocation : NSObject<NSCopying>

@property (nonatomic, readonly, nullable) NSString *identifier;
@property (nonatomic, readonly) BOOL coreCountry;
@property (nonatomic, readonly, nullable) NSString *country;
@property (nonatomic, readonly, nullable) NSString *countryCode;
@property (nonatomic, readonly, nonnull) NSNumber *distance;
@property (nonatomic, readonly, nullable) NSString *fullName;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, nullable) NSString *airportCode;
@property (nonatomic, readonly) BOOL inEurope;
@property (nonatomic, readonly, nullable) NSString *key;
@property (nonatomic, readonly, nullable) NSNumber *locationId;
@property (nonatomic, readonly, nullable) NSString *name;
@property (nonatomic, readonly,) GELocationType type;

/**
 Designated initializer for a location object.
 */
- (nonnull instancetype)initWithIdentifier:(nullable NSString *)identifier
                               coreCountry:(BOOL)coreCountry
                                   country:(nullable NSString *)country
                               countryCode:(nullable NSString *)countryCode
                                  distance:(nonnull NSNumber *)distance
                                  fullname:(nullable NSString *)fullname
                                coordinate:(CLLocationCoordinate2D)coordinate
                               airportCode:(nullable NSString *)airportCode
                                  inEurope:(BOOL)inEurope
                                       key:(nullable NSString *)key
                                locationId:(nonnull NSNumber*)locationId
                                      name:(nullable NSString *)name
                                      type:(GELocationType)type NS_DESIGNATED_INITIALIZER;
/**
 Returns the description in relation to the type of location.
 */
- (nullable NSString *)descriptionWithType:(GELocationType)type;

@end
