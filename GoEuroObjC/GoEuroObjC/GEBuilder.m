//
//  GEBuilder.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GEBuilder.h"
#import "GEQuery.h"
#import "GEIdentifiers.h"
#import "GELocation.h"
@import CoreLocation;

@implementation GEBuilder

- (nonnull NSDictionary *)buildParamentersFromQuery:(nonnull GEQuery *)query {
    return @{
             kLocale:query.locale,
             kTerm:query.term
             };
}

- (nullable NSArray *)buildServerResponse:(nonnull NSArray *)response {
    NSMutableArray *locations = [[NSMutableArray alloc]init];
    
    for (id location in response){
        NSParameterAssert([location isKindOfClass:[NSDictionary class]]);
        NSString *identifier = location[kId];
        NSString *country = location[kCountry];
        BOOL coreCountry = [location[kCoreCountry] boolValue];
        NSString *countryCode = location[kCountryCode];
        NSNumber *distance;
        
        if (location[kDistance] != [NSNull null]) {
            distance = @([location[kDistance] integerValue]);
        } else {
            distance = @(0);
        }
        
        NSString *fullname = location[kFullName];
        
        NSParameterAssert([location[kCoordinate] isKindOfClass:[NSDictionary class]]);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[location[kCoordinate] valueForKey:kLatitude] floatValue], [[location[kCoordinate] valueForKey:kLongitude] floatValue]);
        
        NSString *airPortCode = location[kAirportCode];
        BOOL inEurope = [location[kInEurope] boolValue];
        NSString *key = location[kKey];
        
        NSNumber *locationId;
        if (location[kLocationId] != [NSNull null]) {
            locationId = @([location[kLocationId] integerValue]);
        } else {
            locationId = @(0);
        }
        
        NSString *name = location[kName];
        GELocationType type = [self locationTypeWithString:location[kType]];
        
        GELocation *aLocation = [[GELocation alloc]initWithIdentifier:identifier
                                                          coreCountry:coreCountry
                                                              country:country
                                                          countryCode:countryCode
                                                             distance:distance
                                                             fullname:fullname
                                                           coordinate:coordinate
                                                          airportCode:airPortCode
                                                             inEurope:inEurope
                                                                  key:key
                                                           locationId:locationId
                                                                 name:name
                                                                 type:type];
        [locations addObject:aLocation];
    }
    
    return [NSArray arrayWithArray:locations];
}

- (GELocationType)locationTypeWithString:(NSString *)type {
    if ([type isEqualToString:kTypeLocationString]) {
        return GELocationTypeLocation;
    } else if ([type isEqualToString:kTypeAirportString]) {
        return GELocationTypeAirPort;
    } else if ([type isEqualToString:kTypeStationString]) {
        return GELocationTypeStation;
    }
    return GELocationTypeUnKnown;
}

@end
