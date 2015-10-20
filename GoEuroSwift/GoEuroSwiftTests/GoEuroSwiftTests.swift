//
//  GoEuroSwiftTests.swift
//  GoEuroSwiftTests
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import XCTest
import CoreLocation
@testable import GoEuroSwift

class GoEuroSwiftTests: XCTestCase {
    
    var storyboard:UIStoryboard?
    var searchViewController:UIViewController?
    var builder:Builder?
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        builder = Builder()
        guard let nav = storyboard?.instantiateViewControllerWithIdentifier(kController.MainNavigatorViewController) as? UINavigationController else {
            return
        }
        searchViewController = nav.topViewController
    }
    
    override func tearDown() {
        storyboard = nil
        super.tearDown()
    }
    
    func testThatBuilderReturnsValidDictionaryFromQuery() {
        let query = Query(locale: "DE", term: "Berlin")
        guard let dictionary = builder?.buildParamentersFromQuery(query) else {
            return
        }
        XCTAssertEqual(dictionary["locale"], "DE")
        XCTAssertEqual(dictionary["term"], "Berlin")
    }
    
    func testThatBuilderReturnsValidLocationsArray(){
        do {
            guard  let data =  NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("responseFile", ofType: "json")!) else {
                return
            }
            let response = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [AnyObject]
            guard let locations = builder?.buildServerResponse(response!) else {
                return
            }
            let location = locations[0]
            XCTAssertTrue(location.fullname == "Berlin, Germany")
            XCTAssertTrue(location.name == "Berlin")
            XCTAssertTrue(location.countryCode == "DE")
            XCTAssertTrue(location.coreCountry)
            XCTAssertTrue(location.inEurope)
            XCTAssertTrue(location.type == .LocationTypeLocation)
            let coordinate = CLLocationCoordinate2DMake(52.52437, 13.41053)
            XCTAssertEqual(coordinate.longitude, location.coordinate!.longitude)
            XCTAssertEqual(coordinate.latitude, location.coordinate!.latitude)
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func testThatSearchViewControllerHasDepartureTextField() {
        XCTAssertTrue(searchViewController!.respondsToSelector(Selector("departureTextField")))
    }
    
    func testThatSearchViewControllerHasArrivalTextField(){
        XCTAssertTrue(searchViewController!.respondsToSelector(Selector("arrivalTextField")))
    }
    
    func testThatSearchViewControllerHasDateTextField(){
        XCTAssertTrue(searchViewController!.respondsToSelector(Selector("dateTextField")))
    }
    
    func testThatSearchViewControllerHasDatePicker(){
        XCTAssertTrue(searchViewController!.respondsToSelector(Selector("datePicker")))
    }
    
}
