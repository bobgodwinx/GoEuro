//
//  LocationManagerDelegate.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate:class {
    /**
    Method called when the location is found to update the Location
    */
    func locationDidFindCurrentLocality(locality: String)
    /**
    Method called when the location is not found
    */
    func locationDidFailFindingCurrentLocalityWithError(error: LocationError)
    /**
    Method called when the authorization status is changed.
    */
    func locationDidChangeAuthorizationStatus(authorizationStatus: CLAuthorizationStatus)
}
