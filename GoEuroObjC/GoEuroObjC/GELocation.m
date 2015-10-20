//
//  GELocation.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocation.h"

@interface GELocation()

@property (nonatomic, assign) BOOL inEurope;
@property (nonatomic, assign) BOOL coreCountry;

@end

@implementation GELocation

/**
 Convenience Initializer
 */
- (nonnull instancetype)init {
    return [self initWithIdentifier:nil
                        coreCountry:NO
                            country:nil
                        countryCode:nil
                           distance:@(0)
                           fullname:nil
                         coordinate:CLLocationCoordinate2DMake([@"00.0000000" floatValue], [@"00.0000000" floatValue])
                        airportCode:nil
                           inEurope:NO
                                key:nil
                         locationId:@(0)
                               name:nil
                               type:GELocationTypeUnKnown];
}

- (nonnull instancetype)initWithIdentifier:(NSString *)identifier
                               coreCountry:(BOOL)coreCountry
                                   country:(NSString *)country
                               countryCode:(nullable NSString *)countryCode
                                  distance:(NSNumber *)distance
                                  fullname:(NSString *)fullname
                                coordinate:(CLLocationCoordinate2D)coordinate
                               airportCode:(NSString *)airportCode
                                  inEurope:(BOOL)inEurope
                                       key:(NSString *)key
                                locationId:(NSNumber *)locationId
                                      name:(NSString *)name
                                      type:(GELocationType)type {
    self = [super init];
    if(self){
        _identifier = [identifier copy];
        _coreCountry = coreCountry;
        _country = [country copy];
        _countryCode = [countryCode copy];
        _distance = [distance copy];
        _fullName = [fullname copy];
        _coordinate = coordinate;
        _airportCode = [airportCode copy];
        _inEurope = inEurope;
        _key = [key copy];
        _locationId = [locationId copy];
        _name = [name copy];
        _type = type;
    }
    return self;

}

- (nullable NSString *)descriptionWithType:(GELocationType)type {
    NSString *description;
    switch (type) {
        case GELocationTypeAirPort:
            description = @"Airport";
            break;
        case GELocationTypeLocation:
            description = @"Location";
            break;
        case GELocationTypeStation:
            description = @"station";
            break;
        case GELocationTypeUnKnown:
        default:break;
    }
    return description;
}

- (nonnull instancetype)copyWithZone:(__unused NSZone *)zone {
    return self;
}

@end
