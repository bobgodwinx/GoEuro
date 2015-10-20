//
//  Config.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import UIKit

class Manager {
    
    //MARK: - Singleton SharedInstance
    
    static let sharedInstance = Manager()
    
    //MARK: - Shared properties
    let communicator = Communicator()
    let locationManager = LocationManager()
    let builder = Builder()
    weak var delegate:ManagerDelegate?
    
    lazy var geRoyalBlueColor: UIColor = {
        return UIColor(red: 0.2549019608, green: 0.5137254902, blue: 0.8431372549, alpha: 1)
    }()
    lazy var geAliceBlueColor: UIColor = {
        return UIColor(red: 0.8941176471, green: 0.9450980392, blue: 0.9960784314, alpha: 1)
    }()
    
    lazy var geGrayColor: UIColor = {
        return UIColor(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
    }()

    lazy var dateFormatter:NSDateFormatter = {
        var dateFormatter:NSDateFormatter?
        var __dispatchToken: dispatch_once_t = 0
        dispatch_once(&__dispatchToken) {
            dateFormatter = NSDateFormatter()
            dateFormatter!.locale = NSLocale(localeIdentifier: "de_DE")
            dateFormatter!.dateStyle = .ShortStyle;
            dateFormatter!.timeStyle = .ShortStyle;
        }
        return dateFormatter!
    }()
    
    lazy var concurrentQueue:dispatch_queue_t = {
        var __dispatchToken:dispatch_once_t = 0
        var queue:dispatch_queue_t?
        let qos = qos_class_t(QOS_CLASS_USER_INITIATED.rawValue)
        let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, qos, 2);
        dispatch_once(&__dispatchToken, {
            queue = dispatch_queue_create("com.GoEuro.concurrent", attr);
        });
        return queue!
        }()
    
    func fetchLocationsWithQuery(query:Query) {
        let parameters = builder.buildParamentersFromQuery(query)
        communicator.fetchLocationsWithParameters(parameters, success: { [weak self](response) in
            guard let strongSelf = self else {
                return
            }
            
            let locations = strongSelf.builder.buildServerResponse(response)
            strongSelf.delegate?.managerDidFinishFetchingLocations(locations)
            
        }, failure: { [weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.delegate?.managerDidFailFetchingLocationsWithError(error)
        })
    }
}