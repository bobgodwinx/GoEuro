//
//  GoEuroObjCUITests.m
//  GoEuroObjCUITests
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import <XCTest/XCTest.h>
@import UIKit;
@import Foundation;

@interface GoEuroObjCUITests : XCTestCase

@property (nonatomic) XCUIApplication *app;

@end

NSString *const kDepartureTextField = @"Departure Text Field";
NSString *const kArrivalTextField = @"Arrival Text Field";
NSString *const kDateTextField = @"Date Text Field";

@implementation GoEuroObjCUITests

- (void)setUp {
    [super setUp];
    self.app = [[XCUIApplication alloc] init];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    self.app = nil;
    [super tearDown];
}

- (void)testThatDepartureTextFieldChanges {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *departureTextFieldTextField = app.textFields[kDepartureTextField];
    [departureTextFieldTextField tap];
    [departureTextFieldTextField typeText:@"Berlin"];
    NSString *departureString = (NSString *)departureTextFieldTextField.value;
    XCTAssertTrue(departureString.length > 0, "Can't type into departure textField");
}

- (void)testThatArrivaTextFieldWasTapped {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *arrivalTextFieldTextField = app.textFields[kArrivalTextField];
    [arrivalTextFieldTextField tap];
    NSString *locationsTitle = (NSString *)app.navigationBars.element.identifier;
    XCTAssertTrue([locationsTitle isEqualToString:@"Locations"], "Error on arrival TextField. Please check that perfomSegue is called for locationsTableViewController");
    [app.navigationBars[locationsTitle].buttons[@"Search"] tap];
}

- (void)testThatDatePickerDidAppear {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *dateTextFieldTextField = app.textFields[kDateTextField];
    [dateTextFieldTextField tap];
    XCUIElementQuery *datePickersQuery = app.datePickers;
    [datePickersQuery.pickerWheels[@"Today"] swipeUp];
    NSString *dateString = (NSString *)dateTextFieldTextField.value;
    XCTAssertNotNil(dateString, "Error on date change. Please check datePickerValueDidChange");
    [dateTextFieldTextField tap];
}
@end
