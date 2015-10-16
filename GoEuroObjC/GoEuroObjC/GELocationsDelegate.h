//
//  GELocationsDelegate.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import UIKit;
@class  GELocation;
@class  GELocationsTableViewController;

@interface GELocationsDelegate : NSObject<UITableViewDelegate>
@property (weak, nonatomic) GELocationsTableViewController *locationsTableViewController;
@property (nonatomic) GELocation *selectedLocation;

@end
