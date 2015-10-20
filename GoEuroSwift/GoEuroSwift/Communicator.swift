//
//  Communicator.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation

class Communicator: NSObject {
    
    //MARK: - Private Properties
    private var URLSession:NSURLSession!
    
    //MARK: - Private Struct
    
    private struct HTTPMethod {
        static let GET = "GET"
    }
    
    private struct URLPath {
        static var searchPath = "http://api.goeuro.com/api/v2/position/suggest/{locale}/{term}"
    }
    
    //MARK: - Init Method
    
    required override init (){
        super.init()
        URLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
    }
    
    //MARK: - Helper method

    private func URLForQueryWithPath(path: String, parameters: [String: String]) -> NSURL {
        var pathWithParameters:String?
        pathWithParameters = path.stringByReplacingOccurrencesOfString(kConst.SearchPathLocale, withString:parameters[kConst.Locale]!)
        pathWithParameters = pathWithParameters?.stringByReplacingOccurrencesOfString(kConst.SearchPathTerm, withString: parameters[kConst.Term]!)
        return NSURL(string: pathWithParameters!)!
    }
    
    //MARK: - PerformWebServiceCallWithURL
    
    private func performAPICallWithURL(URL: NSURL!, method:String!, success: (response: [AnyObject])->(), failure: (error: CommunicatorError?)->()) {
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = method
        request.addValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
 
        let task = URLSession.dataTaskWithRequest(request) { (data : NSData?, response : NSURLResponse?, error : NSError?) -> Void in
            if error != nil {
                return failure(error: CommunicatorError.CommunicatorNetworkError)
            } else {
                let HTTPStatusCode = (response as! NSHTTPURLResponse).statusCode
                guard HTTPStatusCode == 200 else {
                    return failure(error: CommunicatorError.CommunicatorHTTPStatusError( statusCode: HTTPStatusCode, errorMessages: HTTPStatusCode.description))
                }
                
                do {
                    let responseArr = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [AnyObject]
                    return success(response:responseArr)
                } catch let serializationError as NSError {
                    return failure(error: CommunicatorError.CommunicatorJSONSerializationError(errorMessage: serializationError.description))
                }
            }
        }

        task.resume()
    }
    
    //MARK: - FetchContentsWithParameters
    
    func fetchLocationsWithParameters(parameters:[String: String], success:(response: [AnyObject])->(), failure:(error:CommunicatorError)->()) {
        let URL = self.URLForQueryWithPath(URLPath.searchPath, parameters: parameters)

        performAPICallWithURL(URL, method: HTTPMethod.GET, success: { (response) -> () in
            success(response: response)
        }, failure: { (error) -> () in
            failure(error: error!)
        })
    }
}
