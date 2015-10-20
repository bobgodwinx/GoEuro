//
//  CommunicatorError.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation

enum CommunicatorError: CustomStringConvertible, ErrorType {
    case CommunicatorUnknownError
    case CommunicatorNetworkError
    case CommunicatorHTTPStatusError(statusCode: Int, errorMessages:String)
    case CommunicatorJSONSerializationError(errorMessage: String)
    
    var description: String {
        switch self
        {
        case .CommunicatorUnknownError:
            return "Unknown communicator error"
        case .CommunicatorNetworkError:
            return "Network or internet connection unavailable"
        case .CommunicatorHTTPStatusError(let statusCode, let errorMessage):
            return "Request failed with HTTPStatusCode \(statusCode) : \(errorMessage)"
        case .CommunicatorJSONSerializationError(let errorMessage):
            return "Invalid JSONResponse \(errorMessage)"
        }
    }
}
