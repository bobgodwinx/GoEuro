//
//  Location.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Returns the kind of location Airport | Station | Location
 */
enum LocationType: CustomStringConvertible {
    case LocationTypeUnknown
    case LocationTypeLocation
    case LocationTypeStation
    case LocationTypeAirPort
    
    var description: String {
        switch self
        {
        case .LocationTypeLocation:
            return "Location"
        case .LocationTypeAirPort:
            return "Airport"
        case .LocationTypeStation:
            return "Station"
        case .LocationTypeUnknown:
            return "Unknown"
        }
    }
}

/**
 Represents a location object from from the server
 */
struct Location {
    var identifier:Int64?
    var coreCountry:Bool
    var country:String?
    var countryCode:String?
    var distance:Int64?
    var fullname:String?
    var coordinate: CLLocationCoordinate2D?
    var airportCode:String?
    var inEurope:Bool
    var key:String?
    var locationId:Int64?
    var name:String?
    var type:LocationType
}