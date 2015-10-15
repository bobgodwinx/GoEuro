//
//  GESearchViewController.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GESearchViewController.h"
#import "GEManager.h"
#import "GEQuery.h"
#import "GELocation.h"
#import "GELocationManagerDelegate.h"
#import "GELocationManager.h"
@import CoreLocation;

@interface GESearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *departureTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonnull, nonatomic) GEManager *manager;
@property (nonnull, nonatomic) GELocationManager *locationManager;
@property (nonnull, nonatomic) GEQuery *query;
@property (nonnull, nonatomic) NSArray *locations;

@end

@implementation GESearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.locationManager requestCurrentLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureTextField:self.arrivalTextField];
    [self configureTextField:self.departureTextField];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self.manager fetchLocationsWithQuery:self.query];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - Lazy initializer

- (GEManager *)manager {
    if (!_manager) {
        _manager = [[GEManager alloc]initWithDelegate:self];
    }
    return _manager;
}

- (GELocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[GELocationManager alloc]initWithDelegate:self];
    }
    return _locationManager;
}

- (GEQuery *)query {
    if (!_query) {
        /**
         This is just to start the query with default settings Berlin
         */
        _query = [[GEQuery alloc] initWithLocale:@"DE" term:@"Berlin"];
    }
    
    return _query;
}

#pragma mark - configureTextField

- (void)configureTextField:(UITextField *)textField {
    textField.layer.borderColor = self.manager.geAliceBlueColor.CGColor;
    textField.layer.borderWidth = 1.00;
    textField.layer.cornerRadius = 7.00;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 42)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - presentAlertViewWithError

- (void)presentAlertViewWithError:(NSError *)error {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Location Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self)weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alertViewController addAction:okAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - GEManagerDelegate

- (void)managerDidFinishFetchingLocations:(NSArray *)locations {
    self.locations = locations;
    GELocation *location = locations[0];
    self.arrivalTextField.text = location.fullName;
}

- (void)managerDidFailFetchingLocationsWithError:(NSError *)error {
    [self presentAlertViewWithError:error];
}

#pragma mark - GELocationManagerDelegate

- (void)locationDidChangeAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus {
    NSString *errorMessage;
    switch (authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:
            errorMessage = @"Can't determine authorization status";
            break;
        case kCLAuthorizationStatusRestricted:
            errorMessage = @"Authorization restricted";
            break;
        case kCLAuthorizationStatusDenied:
            errorMessage = @"Authorization denied";
            break;
        default:break;
    }
    
    NSError *error = [NSError errorWithDomain:GELocationManagerErrorDomain
                                         code:GELocationManagerAuthorizationError
                                     userInfo:@{
                                                NSLocalizedDescriptionKey: NSLocalizedString(errorMessage, @"Error description.")
                                                }];
    if (errorMessage) {
        [self presentAlertViewWithError:error];
    }
}

- (void)locationDidFailFindinglocalityWithError:(NSError *)error {
    [self presentAlertViewWithError:error];
}

- (void)locationDidFindCurrentLocality:(NSString *)locality {
    self.departureTextField.text = locality;
    GEQuery *query = [[GEQuery alloc]initWithLocale:@"DE" term:locality];
    [self.manager fetchLocationsWithQuery:query];
}

@end
