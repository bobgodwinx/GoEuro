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
    case CommunicatorHTTPStatusError(statusCode: Int, errorMessages:String?)
    case CommunicatorJSONSerializationError(errorMessage: String?)
    
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

//class RequestController {
//    func makeRequest(success:(response:AnyObject)->(), failure:(error:CommunicatorError)->()) {
//        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        let URL = NSURL(string: "http://private-anon-827bc57e0-andresbrun.apiary-mock.com/api/v3/search_suggestions")
//        let request = NSMutableURLRequest(URL: URL!)
//        request.HTTPMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("e3e4db4432d6f93905f705e53a4898087920b6e71b0ffc4b5451924361c3e86b", forHTTPHeaderField: "access_token")
//        
//        let bodyObject = [
//            "city": "berlin"
//        ]
//        do {
//            let bodyData = try NSJSONSerialization.dataWithJSONObject(bodyObject, options: NSJSONWritingOptions.init(rawValue: 0))
//            request.HTTPBody = bodyData
//        } catch let error as NSError {
//            return failure(error: CommunicatorError.CommunicatorJSONSerializationError(errorMessage: error.description))
//        }
//        
//        let task = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> () in
//            let HTTPStatusCode = (response as! NSHTTPURLResponse).statusCode
//            guard HTTPStatusCode == 200 else {
//                if let error = error {
//                    return failure(error: CommunicatorError.CommunicatorHTTPStatusError(statusCode: HTTPStatusCode, errorMessages: error.description))
//                } else {
//                    return failure(error: CommunicatorError.CommunicatorHTTPStatusError(statusCode: HTTPStatusCode, errorMessages: nil))
//                }
//            }
//            
//            do {
//                let JSONResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String:AnyObject]
//                return(success(response: JSONResponse))
//            } catch let error as NSError {
//               return failure(error: CommunicatorError.CommunicatorJSONSerializationError(errorMessage: error.description))
//            }
//         }
//
//        task.resume()
//    }
//}


