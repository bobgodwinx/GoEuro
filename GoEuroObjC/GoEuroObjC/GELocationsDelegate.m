//
//  GELocationsDelegate.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocationsDelegate.h"
#import "GELocationsDataSource.h"
#import "GELocationsTableViewController.h"
#import "GEIdentifiers.h"

@implementation GELocationsDelegate

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GELocationsDataSource *dataSource =  (GELocationsDataSource *)tableView.dataSource;
    self.selectedLocation = dataSource.locations[indexPath.row];
    [self.locationsTableViewController performSegueWithIdentifier:kUnwindFromLocationsTableViewController sender:self.locationsTableViewController];
}

@end
