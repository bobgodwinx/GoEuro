//
//  GESearchViewController.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import UIKit;
#import "GEManagerDelegate.h"
#import "GELocationManagerDelegate.h"
@interface GESearchViewController : UIViewController<GEManagerDelegate,
                                                     GELocationManagerDelegate,
                                                     UITextFieldDelegate>

@end
