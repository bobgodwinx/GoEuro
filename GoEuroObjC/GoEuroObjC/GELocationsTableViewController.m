//
//  GELocationsTableViewController.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocationsTableViewController.h"
#import "GELocationsDataSource.h"
#import "GELocationsDelegate.h"

@interface GELocationsTableViewController ()

@end

@implementation GELocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.delegate.locationsTableViewController = self;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.delegate.locationsTableViewController = self;
    self.navigationController.navigationBarHidden = NO;
}


@end
