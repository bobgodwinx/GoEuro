//
//  LocationTableViewDataSource.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit

class LocationsTableViewDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Properties
    
    var locations:[Location]?

    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard locations?.count > 0 else {
            return 0
        }
        return locations!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.tableView(tableView, locationCellForRowAtIndexPath: indexPath)!
    }
    
    func tableView(tableView: UITableView, locationCellForRowAtIndexPath indexPath: NSIndexPath) -> LocationTableViewCell? {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCell.LocationTableViewCell, forIndexPath: indexPath) as? LocationTableViewCell else {
            return nil
        }
        guard let location = locations?[indexPath.row] else {
            return nil
        }
        cell.locationDescription?.text = location.type.description
        cell.locationName?.text = location.fullname
        
        return cell
    }

}
