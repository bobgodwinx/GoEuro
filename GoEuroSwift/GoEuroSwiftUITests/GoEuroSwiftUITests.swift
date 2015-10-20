//
//  GoEuroSwiftUITests.swift
//  GoEuroSwiftUITests
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import XCTest

class GoEuroSwiftUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    func testThatDepartureTextFieldChanges(){
        let app = XCUIApplication()
        let departureTextFieldTextField = app.textFields["Departure Text Field"]
        departureTextFieldTextField.tap()
        departureTextFieldTextField.typeText("Berlin")
        guard let departureString = departureTextFieldTextField.value as? String else {
            return
        }
        XCTAssertTrue(departureString.characters.count > 0, "Can't type into departure textField")
        app.typeText("\n")
    }
    
    func testThatArrivalTextFieldWasTapped(){
        let app = XCUIApplication()
        let arrivalTextFieldTextField = app.textFields["Arrival Text Field"]
        arrivalTextFieldTextField.tap()
        let locationsTitle = app.navigationBars.element.identifier
        XCTAssertEqual(locationsTitle, "Locations")
        app.navigationBars[locationsTitle].buttons["Search"].tap()
    }
    
    func testThatDatePickerDidAppear(){
        let app = XCUIApplication()
        let dateTextFieldTextField = app.textFields["Date Text Field"]
        dateTextFieldTextField.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["Today"].swipeUp()

        guard let dateString = dateTextFieldTextField.value as? String else {
            return
        }
        XCTAssertNotNil(dateString)
        dateTextFieldTextField.tap()
    }
}
