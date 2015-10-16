//
//  GELocationsCell.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocationsCell.h"

@implementation GELocationsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
