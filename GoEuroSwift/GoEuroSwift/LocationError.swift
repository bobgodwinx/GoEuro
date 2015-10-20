//
//  LocationError.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

enum LocationError:CustomStringConvertible, ErrorType {
    /**
     Location unknow error
     */
    case LocationUnknownError(errorMessage: String)
    /**
     Location fail to find location coordinate
     */
    case LocationFailFindingCoordinateError(errorMessage: String)
    /**
     Location fail to find locality error
     */
    case LocationFailFindingLocalityError(errorMessage: String)
    /**
     Location authroization error
     */
    case LocationAuthorizationError(errorMessage: String)
    
    var description : String {
        switch self
        {
        case .LocationUnknownError(let errorMessage):
            return errorMessage
        case .LocationFailFindingLocalityError(let errorMessage):
            return errorMessage
        case .LocationFailFindingCoordinateError(let errorMessage):
            return errorMessage
        case .LocationAuthorizationError(let errorMessage):
            return errorMessage
        }
    }
}
