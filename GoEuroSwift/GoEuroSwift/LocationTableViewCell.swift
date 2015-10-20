//
//  LocationTableViewCell.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet weak var locationDescription: UILabel?
    @IBOutlet weak var locationName: UILabel?
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .Default
        accessoryType = .None
    }
}
