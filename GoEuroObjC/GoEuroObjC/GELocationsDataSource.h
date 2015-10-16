//
//  GELocationsDataSource.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface GELocationsDataSource : NSObject<UITableViewDataSource, NSCopying>

@property (nonatomic) NSArray *locations;

@end
