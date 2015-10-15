//
//  GElocationManager.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/15/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GELocationManager.h"
#import "GELocationManagerDelegate.h"


@interface GELocationManager()

@property (nonatomic, weak) id <GELocationManagerDelegate> delegate;
@property (nonnull,  nonatomic) CLLocationManager *locationManager;

@end

NSString *const GELocationManagerErrorDomain = @"GELocationManagerErrorDomain";

@implementation GELocationManager

#pragma mark - Convenience init

- (instancetype)init {
    return [self initWithDelegate:nil];
}

#pragma mark - Designated init

- (nonnull instancetype)initWithDelegate:(id<GELocationManagerDelegate> __nullable)aDelegate {
    self = [super init];
    if (self) {
        _delegate = aDelegate;
    }
    return self;
}

#pragma mark - Lazy initialization

- (CLLocationManager *)locationManager {
    if(_locationManager){
        return _locationManager;
    }
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    return _locationManager;
}

#pragma mark - RequestCurrentLocation

- (void)requestCurrentLocation {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - FindCoordinateWithLocation

- (void)findCoordinateWithLocation:(CLLocation *)location {
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    __weak typeof(self)weakSelf = self;
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CLPlacemark *nearestPlaceMark = [placemarks firstObject];
        if([strongSelf.delegate respondsToSelector:@selector(locationDidFindCurrentLocality:)]){
            [strongSelf.delegate locationDidFindCurrentLocality:nearestPlaceMark.locality];
        }
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    [self findCoordinateWithLocation:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(locationDidFailFindinglocalityWithError:)]){
        
        NSError *theError = [NSError errorWithDomain:GELocationManagerErrorDomain
                                                code:GELocationManagerFailFindingLocalityError
                                            userInfo:@{
                                                       NSUnderlyingErrorKey:error
                                                       }];
        
        [self.delegate locationDidFailFindinglocalityWithError:theError];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if([self.delegate respondsToSelector:@selector(locationDidChangeAuthorizationStatus:)]){
        [self.delegate locationDidChangeAuthorizationStatus:status];
    }
}

@end