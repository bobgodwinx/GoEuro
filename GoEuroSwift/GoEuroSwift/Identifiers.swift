//
//  Identifiers.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation

//MARK: - kConst

struct kConst {
    static let SearchPathLocale = "{locale}"
    static let SearchPathTerm = "{term}"
    static let Locale = "locale"
    static let Term = "term"
}

//MARK: - kResponseKey

/**
 Represents the server response keys for location
 */
struct kResponseKey {
    static let Id = "_id"
    static let CoreCountry = "coreCountry"
    static let Country = "country"
    static let CountryCode = "countryCode"
    static let Distance = "distance"
    static let FullName = "fullName"
    static let Coordinate = "geo_position"
    static let Latitude = "latitude"
    static let Longitude = "longitude"
    static let AirportCode = "iata_airport_code"
    static let InEurope = "inEurope"
    static let Key = "key"
    static let LocationId = "locationId"
    static let Name = "name"
    static let TypeString = "type"
    static let TypeLocationString = "location"
    static let TypeAirportString = "airport"
    static let TypeStationString =  "station"
}

struct kSegue {
    static let LocationsTableViewControllerSegue = "LocationsTableViewControllerSegue"
    static let UnwindFromLocationsTableViewController = "UnwindFromLocationsTableViewController"
}

struct kTableViewCell {
    static let LocationTableViewCell = "LocationTableViewCell"
}

struct kController {
    static let MainNavigatorViewController = "MainNavigatorViewController"
    static let SearchViewController = "SearchViewController"
    static let LocationsTableViewController = "LocationsTableViewController"
}

