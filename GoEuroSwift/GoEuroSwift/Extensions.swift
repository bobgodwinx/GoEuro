//
//  Extensions.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/22/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC


protocol cellIndexPathForUITextFieldDelegate:class {
    var cellIndexPath: NSIndexPath? {get set}
}

extension UITextField: cellIndexPathForUITextFieldDelegate {
    private struct AssociatedKeys {
        static var kNSIndexPath = "kNSIndexPath"
    }
    
    var cellIndexPath: NSIndexPath? {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kNSIndexPath) as? NSIndexPath
        }
        
        set (newValue){
            objc_setAssociatedObject(self, &AssociatedKeys.kNSIndexPath, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}