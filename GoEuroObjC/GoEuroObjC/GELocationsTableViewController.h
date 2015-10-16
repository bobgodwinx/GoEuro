//
//  GELocationsTableViewController.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import UIKit;
@class GELocationsDataSource;
@class GELocationsDelegate;

@interface GELocationsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet GELocationsDelegate *delegate;
@property (weak, nonatomic) IBOutlet GELocationsDataSource *dataSource;

@end
