//
//  GEIdentifiers.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GEIdentifiers.h"

@implementation GEIdentifiers

#pragma mark - Search Paths 

NSString *const kSearchPathLocale = @"{locale}";
NSString *const kSearchPathTerm = @"{term}";

#pragma mark - NSDictionary keys

NSString *const kLocale = @"locale";
NSString *const kTerm = @"term";

#pragma mark - GELocation keys

NSString *const kId = @"_id";
NSString *const kCoreCountry = @"coreCountry";
NSString *const kCountry = @"country";
NSString *const kCountryCode = @"countryCode";
NSString *const kDistance = @"distance";
NSString *const kFullName = @"fullName";
NSString *const kCoordinate = @"geo_position";
NSString *const kLatitude = @"latitude";
NSString *const kLongitude = @"longitude";
NSString *const kAirportCode = @"iata_airport_code";
NSString *const kInEurope = @"inEurope";
NSString *const kKey = @"key";
NSString *const kLocationId = @"locationId";
NSString *const kName = @"name";
NSString *const kType = @"type";
NSString *const kTypeLocationString = @"location";
NSString *const kTypeAirportString = @"airport";
NSString *const kTypeStationString = @"station";

#pragma mark - TableViewCell identifers

NSString *const kGELocationsCell = @"GELocationsCell";

#pragma mark - Unwind segues + Segues

NSString *const kLocationsTableViewControllerSegue = @"LocationsTableViewControllerSegue";
NSString *const kUnwindFromLocationsTableViewController = @"UnwindFromLocationsTableViewControllerSegue";
@end
