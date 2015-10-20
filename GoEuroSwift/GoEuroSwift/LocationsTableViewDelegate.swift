//
//  LocationTableViewDelegate.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit

class LocationsTableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var locationsTableViewController:LocationsTableViewController?
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let dataSource = tableView.dataSource as? LocationsTableViewDataSource where dataSource.locations!.count > 0 else {
            return
        }
        locationsTableViewController?.selectedLocation = dataSource.locations![indexPath.row]
        locationsTableViewController?.performSegueWithIdentifier(kSegue.UnwindFromLocationsTableViewController, sender: locationsTableViewController)
    }
}
