//
//  GoEuroObjCTests.m
//  GoEuroObjCTests
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "GEManager.h"
#import "GEQuery.h"
#import "GELocation.h"
#import "GEManagerDelegate.h"
#import "GESearchViewController.h"
#import "GEBuilder.h"
#import "GEIdentifiers.h"

@interface GoEuroObjCTests : XCTestCase

@property (nonatomic) GEManager *manager;
@property (nonatomic) GEBuilder *builder;
@property (nonatomic) GEQuery *query;
@property (nonatomic) id <GEManagerDelegate> delegate;
@property (nonatomic) GESearchViewController *searchViewController;

@end

@implementation GoEuroObjCTests

- (void)setUp {
    [super setUp];
    self.manager = [[GEManager alloc]init];
    self.delegate = [[GESearchViewController alloc]init];
    self.builder = [[GEBuilder alloc]init];
    self.query = [[GEQuery alloc]initWithLocale:@"DE" term:@"Berlin"];
}

- (void)tearDown {
    self.manager = nil;
    self.delegate = nil;
    [super tearDown];
}

- (void)testThatQueryReturnsValidObject {
    XCTAssertEqual(self.query.locale, @"DE", "Invalid locale for query object");
    XCTAssertEqual(self.query.term, @"Berlin", "Invalid term for query object");
}

- (void)testThatBuilderRespondsToSelector {
    XCTAssertTrue([self.builder respondsToSelector:@selector(buildParamentersFromQuery:)], "Builder needs method buildParamentersFromQuery");
    XCTAssertTrue([self.builder respondsToSelector:@selector(buildServerResponse:)], "Builder needs method buildServerResponse");
}

- (void)testThatBuilderReturnsValidArrayForLocations {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"responseFile" ofType:@"json"]];
    NSError *error;
    NSJSONSerialization *JSONSerialization = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSArray *locations = [self.builder buildServerResponse:(NSArray *)JSONSerialization];
    XCTAssertTrue([locations[0] isKindOfClass:[GELocation class]], "Invalid type for location returned from buildServerResponse");
    GELocation *location = locations[0];
    XCTAssertTrue([location.fullName isEqualToString:@"Berlin, Germany"], "Invalid data fund in location.fullName property");
    XCTAssertTrue([location.country isEqualToString:@"Germany"], "Invalid data fund in location.country property");
    XCTAssertEqual(location.type, GELocationTypeLocation, "Invalid data fund in location.type property");
    XCTAssertTrue([location.name isEqualToString:@"Berlin"], "Invalid data fund in location.name property");
    XCTAssertTrue([location.countryCode isEqualToString:@"DE"], "Invalid data fund in location.countryCode property");
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 52.524368286132813;
    coordinate.longitude = 13.410530090332031;
    
    XCTAssertEqual(location.coordinate.latitude, coordinate.latitude, @"Invalid coordinate latitude returned in location.coordinate");
    XCTAssertEqual(location.coordinate.longitude, coordinate.longitude, @"Invalid coordinate returned in location.coordinate");
}

- (void)testThatBuilderReturnsValidDictionaryForQuery {
    NSDictionary *dictionary = [self.builder buildParamentersFromQuery:self.query];
    XCTAssertEqual(dictionary[kLocale], @"DE", "Invalid property generated from buildParamentersFromQuery method");
    XCTAssertEqual(dictionary[kTerm], @"Berlin", "Invalid property generated from buildParamentersFromQuery method");
}

- (void)testThatManagerHasMethodFetchLocationsWithQuery {
    XCTAssertTrue([self.manager respondsToSelector:@selector(fetchLocationsWithQuery:)], @"fetchLocationsWithQuery is missing from the manager");
}

- (void)testThatManagerHasRoyalBlueColorProperty {
    objc_property_t geRoyalBlueColor = class_getProperty([GEManager class], "geRoyalBlueColor");
    XCTAssertTrue(geRoyalBlueColor != NULL, @"geRoyalBlueColor UIColor is missing from the manager");
}

- (void)testThatManagerHasGrayColorProperty {
    objc_property_t geGrayColor = class_getProperty([GEManager class], "geGrayColor");
    XCTAssertTrue(geGrayColor != NULL, @"geGrayColor UIColor is missing from the manager");
}

- (void)testThatManagerHasAliceBlueColorProperty {
    objc_property_t geAliceBlueColor = class_getProperty([GEManager class], "geAliceBlueColor");
    XCTAssertTrue(geAliceBlueColor != NULL, @"geAliceBlueColor UIColor is missing from the manager");
}

- (void)testThatManagerHasDateFormatterProperty {
    objc_property_t dateFormatter = class_getProperty([GEManager class], "dateFormatter");
    XCTAssertTrue(dateFormatter != NULL, @"dateFormatter NSDateFormatter is missing from the manager");
}

- (void)testThatAliceBlueColorIsKindOfUIColorClass {
    XCTAssertTrue([self.manager.geAliceBlueColor isKindOfClass:[UIColor class]], @"wrong class type used for geAliceBlueColor");
}

- (void)testThatGrayColorIsKindOfUIColorClass {
    XCTAssertTrue([self.manager.geGrayColor isKindOfClass:[UIColor class]], @"wrong class type used for geGrayColor");
}

- (void)testThatRoyalBlueColorIsKindOfUIColorClass{
    XCTAssertTrue([self.manager.geRoyalBlueColor isKindOfClass:[UIColor class]], @"wrong class type used for geRoyalBlueColor");
}

- (void)testThatRoyalBlueColorIsKindOfNSDateFormatterClass{
    XCTAssertTrue([self.manager.dateFormatter isKindOfClass:[NSDateFormatter class]], @"wrong class type used for dateFormatter");
}


@end
