//
//  LocationsTableViewController.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/19/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    //MARK: - Properties 
    
    @IBOutlet weak var dataSource:LocationsTableViewDataSource?
    @IBOutlet weak var delegate:LocationsTableViewDelegate? {
        didSet{
            delegate?.locationsTableViewController = self
        }
    }
    var selectedLocation:Location?

    //MARK: Life cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
