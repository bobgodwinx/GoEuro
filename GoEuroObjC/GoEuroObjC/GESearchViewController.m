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
#import "GELocationsTableViewController.h"
#import "GELocationsDataSource.h"
#import "GELocationsDelegate.h"
#import "GEIdentifiers.h"
@import CoreLocation;

@interface GESearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *departureTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonnull, nonatomic) GEManager *manager;
@property (nonnull, nonatomic) GELocationManager *locationManager;
@property (nonnull, nonatomic) NSArray *locations;

@end

@implementation GESearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.locationManager requestCurrentLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self configureTextField:self.arrivalTextField];
    [self configureTextField:self.departureTextField];
    [self configureTextField:self.dateTextField];
    self.datePickerHeightConstraint.constant = 0.0;
    
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

#pragma mark - configureTextField

- (void)configureTextField:(UITextField *)textField {
    if(textField == self.dateTextField){
        textField.layer.borderColor = self.manager.geRoyalBlueColor.CGColor;
        textField.text = [self.manager.dateFormatter stringFromDate:[NSDate date]];
    }
    textField.delegate = self;
    textField.layer.borderColor = self.manager.geAliceBlueColor.CGColor;
    textField.layer.borderWidth = 1.00;
    textField.layer.cornerRadius = 7.00;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 42)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    if(textField == self.arrivalTextField){
        textField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disclosure"]];
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
}


- (void)performSearchWithString:(NSString *)searchString {
    if(searchString.length > 0){
        searchString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        GEQuery *query = [[GEQuery alloc]initWithLocale:@"DE" term:searchString];
        [self.manager fetchLocationsWithQuery:query];
    } else {
        //FIXME: Handle message
    }
}

#pragma mark - UIDatePicker value change

- (IBAction)datePickerValueDidChange:(id)sender {
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    self.dateTextField.text = [self.manager.dateFormatter stringFromDate:datePicker.date];
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
    if (self.locations.count > 0) {
        GELocation *location = self.locations[0];
        self.arrivalTextField.text = location.fullName;
    }
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
    if (locality) {
        [self performSearchWithString:locality];
    }
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:kLocationsTableViewControllerSegue]){
        GELocationsTableViewController *locationsTableViewController = (GELocationsTableViewController *)segue.destinationViewController;
        locationsTableViewController.dataSource.locations = self.locations;
    }
}

#pragma mark - Unwind segue


- (IBAction)unwindFromLocationsTableViewController:(UIStoryboardSegue *)sender {
    if([sender.identifier isEqualToString:kUnwindFromLocationsTableViewController]){
        GELocationsTableViewController *locationsTableViewController = (GELocationsTableViewController *)sender.sourceViewController;
        GELocation *location = locationsTableViewController.delegate.selectedLocation;
        self.arrivalTextField.text = location.fullName;
    }
}

#pragma mark - Search Location

- (IBAction)searchLocations:(id)sender {
    if(self.departureTextField.text.length > 0){
        [self performSearchWithString:self.departureTextField.text];
    }
}

#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string  isEqual:@"\n"]){
        [textField resignFirstResponder];
        if(textField == self.departureTextField){
            [self performSearchWithString:self.departureTextField.text];
        }
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.dateTextField || textField == self.arrivalTextField) {
        [textField resignFirstResponder];
        textField.tintColor = [UIColor clearColor];
        if (textField == self.dateTextField) {
            if(self.datePickerHeightConstraint.constant == 0.00){
                self.datePickerHeightConstraint.constant = 139.00;
            } else {
                self.datePickerHeightConstraint.constant = 0.00;
            }
        } else if (textField == self.arrivalTextField) {
            [self performSegueWithIdentifier:kLocationsTableViewControllerSegue sender:self];
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
