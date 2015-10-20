//
//  LocationManager.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager:NSObject, CLLocationManagerDelegate {
    //MARK: Properties
    
    lazy var coreLocationManager: CLLocationManager? = {
        var _coreLocationManager = CLLocationManager()
        _coreLocationManager.delegate = self
        return _coreLocationManager
        }()
    
    weak var delegate:LocationManagerDelegate?
    
    //MARK: - RequestCurrentLocation
    
    func requestCurrentLocation(){
        coreLocationManager?.requestWhenInUseAuthorization()
        coreLocationManager?.startUpdatingLocation()
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        delegate?.locationDidChangeAuthorizationStatus(status)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let locationError = LocationError.LocationFailFindingLocalityError(errorMessage: error.description)
        delegate?.locationDidFailFindingCurrentLocalityWithError(locationError)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coreLocationManager?.stopUpdatingLocation()
        findCoordinateWithLocation(locations.last!)
    }
    
    //MARK: - FindCoordinateWithLocation
    
    func findCoordinateWithLocation(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placeMarks:[CLPlacemark]?, error:NSError?) in
            guard let strongSelf = self else {
                return
            }
            guard let nearestPlaceMark = placeMarks?.first else {
                let error = LocationError.LocationFailFindingCoordinateError(errorMessage: "Cannot determine location coordination")
                strongSelf.delegate?.locationDidFailFindingCurrentLocalityWithError(error)
                return
            }
            strongSelf.delegate?.locationDidFindCurrentLocality(nearestPlaceMark.locality!)
        }
    }
    
}