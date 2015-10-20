//
//  ManagerDelegate.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation

protocol ManagerDelegate:class {
    /**
     A method that notifies the controller that locations were successfully returned
     */
    func managerDidFinishFetchingLocations(locations: [Location])
    /**
     A method that notifies the controller that locations request failed
     */
    func managerDidFailFetchingLocationsWithError(error: CommunicatorError)
}