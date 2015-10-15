//
//  GEIdentifiers.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;

@interface GEIdentifiers : NSObject
/**
 GESearchPathLocale a path used for searching within the string and replaced with the original locale.
 Country to be precised. for example DE which stands for germany or ES which stands for spain.
 */
FOUNDATION_EXPORT NSString *__nonnull const kSearchPathLocale;
/**
 GESearchPathTerm is the search string entered by the user. Hopefully a City. e.g. Berlin, Rome
 */
FOUNDATION_EXPORT NSString *__nonnull const kSearchPathTerm;
/**
 GEKeyLocale holds the NSDictionary key for user current locale
 */
FOUNDATION_EXPORT NSString *__nonnull const kLocale;
/**
 GEKeyTerm holds the NSDictiornary key for user search string.
 */
FOUNDATION_EXPORT NSString *__nonnull const kTerm;

/**
 GELocation server response keys
 */
FOUNDATION_EXPORT NSString *__nonnull const kId;
FOUNDATION_EXPORT NSString *__nonnull const kCoreCountry;
FOUNDATION_EXPORT NSString *__nonnull const kCountry;
FOUNDATION_EXPORT NSString *__nonnull const kCountryCode;
FOUNDATION_EXPORT NSString *__nonnull const kDistance;
FOUNDATION_EXPORT NSString *__nonnull const kFullName;
FOUNDATION_EXPORT NSString *__nonnull const kCoordinate;
FOUNDATION_EXPORT NSString *__nonnull const kLatitude;
FOUNDATION_EXPORT NSString *__nonnull const kLongitude;
FOUNDATION_EXPORT NSString *__nonnull const kAirportCode;
FOUNDATION_EXPORT NSString *__nonnull const kInEurope;
FOUNDATION_EXPORT NSString *__nonnull const kKey;
FOUNDATION_EXPORT NSString *__nonnull const kLocationId;
FOUNDATION_EXPORT NSString *__nonnull const kName;
FOUNDATION_EXPORT NSString *__nonnull const kType;
FOUNDATION_EXPORT NSString *__nonnull const kTypeLocationString;
FOUNDATION_EXPORT NSString *__nonnull const kTypeAirportString;
FOUNDATION_EXPORT NSString *__nonnull const kTypeStationString;


@end
