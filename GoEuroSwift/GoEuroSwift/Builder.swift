//
//  Builder.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import CoreLocation

class Builder {
    
    /**
     Returns a dictionary of Strings for search
     */
    func buildParamentersFromQuery(query:Query) -> [String:String]{
        var parameters = [String:String]()
        parameters[kConst.Locale] = query.locale
        parameters[kConst.Term] = query.term
        return parameters
    }
    
    /**
     Returns an array of locations based on the server response
     */
    
    func buildServerResponse(response:[AnyObject]) -> [Location] {
        var locations = [Location]()
        for item in response {
            var latitude:Double = 0.0000000
            var longitude:Double = 0.0000000
            guard let dictionary = item as? [String:AnyObject] else {
                //Go to the next dictionary
                continue
            }
            
            let identifier = (dictionary[kResponseKey.Id] as? NSNumber)?.longLongValue ?? 0
            let coreCountry = (dictionary[kResponseKey.CoreCountry] as? NSNumber)?.boolValue ?? false
            let country = dictionary[kResponseKey.Country] as? String ?? nil
            let  countryCode = dictionary[kResponseKey.CountryCode] as? String ?? nil
            
            let distance = (dictionary[kResponseKey.Distance] as? NSNumber)?.longLongValue ?? 0
            let fullname = dictionary[kResponseKey.FullName] as? String ?? nil
            
            if let coordinateItem = dictionary[kResponseKey.Coordinate] as? [String :AnyObject] {
                //If possibile we store the right position. Else location 0.0
                latitude = (coordinateItem[kResponseKey.Latitude] as? NSNumber)?.doubleValue ?? 0.0000000
                longitude = (coordinateItem[kResponseKey.Longitude] as? NSNumber)?.doubleValue ?? 0.0000000
            }

            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let airportCode = dictionary[kResponseKey.AirportCode] as? String ?? nil
            let inEurope = (dictionary[kResponseKey.InEurope] as? NSNumber)?.boolValue ?? false
            let key = dictionary[kResponseKey.Key] as? String ?? nil
            let locationId = (dictionary[kResponseKey.LocationId] as? NSNumber)?.longLongValue ?? 0
            let name = dictionary[kResponseKey.Name] as? String ?? nil
            let locationString = dictionary[kResponseKey.TypeString] as? String ?? nil
            let typeString = locationTypeWithString(locationString)
            
            let location = Location(identifier:identifier, coreCountry:coreCountry, country:country, countryCode:countryCode, distance:distance, fullname:fullname, coordinate:coordinate, airportCode:airportCode, inEurope:inEurope, key:key, locationId:locationId, name:name, type:typeString)
            locations.append(location)
        }
        
        return locations
    }
    
    
    func locationTypeWithString(string:String?) -> LocationType {
        guard let typeString = string else {
            return .LocationTypeUnknown
        }
        
        switch typeString
        {
        case kResponseKey.TypeAirportString:
            return .LocationTypeAirPort
        case kResponseKey.TypeLocationString:
            return .LocationTypeLocation
        case kResponseKey.TypeStationString:
            return .LocationTypeStation
        default:break
        }
        return .LocationTypeUnknown
    }
}