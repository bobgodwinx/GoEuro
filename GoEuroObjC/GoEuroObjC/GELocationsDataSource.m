//
//  GELocationsDataSource.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocationsDataSource.h"
#import "GELocationsCell.h"
#import "GEIdentifiers.h"
#import "GELocation.h"

@implementation GELocationsDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView locationCellForRowAtIndexPath:indexPath];
}

- (GELocationsCell *)tableView:(UITableView *)tableView locationCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GELocationsCell *cell = [tableView dequeueReusableCellWithIdentifier:kGELocationsCell forIndexPath:indexPath];
    GELocation *location = (GELocation *)self.locations[indexPath.row];
    cell.locationName.text = location.fullName;
    cell.locationDescription.text = [location descriptionWithType:location.type];
    return cell;
}

- (nonnull instancetype)copyWithZone:(__unused NSZone *)zone {
    return self;
}
@end
