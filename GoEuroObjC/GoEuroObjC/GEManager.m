//
//  GEManager.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GEManager.h"
#import "GECommunicator.h"
#import "GEIdentifiers.h"
#import "GEManagerDelegate.h"
#import "GEBuilder.h"

@interface GEManager()
@property (nonatomic, weak) id <GEManagerDelegate> delegate;
@property (nonnull, nonatomic) GECommunicator *communicator;
@property (nonnull, nonatomic) GEBuilder *builder;

@end

@implementation GEManager

/**
 Convenience Initializer
 */

- (instancetype)init {
    return [self initWithDelegate:nil];
}

/**
 Designated Initializer
 */

- (nonnull instancetype)initWithDelegate:(id<GEManagerDelegate>)aDelegate {
    self = [super init];
    if(self){
        _delegate = aDelegate;
        _geAliceBlueColor = [UIColor colorWithRed:0.8941176471 green:0.9450980392 blue:0.9960784314 alpha:1];
        _geRoyalBlueColor = [UIColor colorWithRed:0.2549019608 green:0.5137254902 blue:0.8431372549 alpha:1];
    }
    return self;
}

/**
 Lazy Init for communicator
 */

- (nonnull GECommunicator *)communicator {
    if (!_communicator) {
        _communicator = [[GECommunicator alloc]init];
    }
    
    return  _communicator;
}

- (void)fetchLocationsWithQuery:(nonnull GEQuery *)query {
    NSDictionary *parameters = [self.builder buildParamentersFromQuery:query];
    __weak typeof(self)weakSelf = self;
    [self.communicator fetchLocationsWith:parameters success:^(NSArray * _Nullable response) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (response) {
            NSArray *locations = [strongSelf.builder buildServerResponse:response];
            [strongSelf.delegate managerDidFinishFetchingLocations:locations];
        } else {
            NSError *error = [NSError errorWithDomain:GECommunicatorErrorDomain
                                                    code:GECommunicatorNULLResponseError
                                                userInfo:@{
                                                           NSLocalizedDescriptionKey: NSLocalizedString(@"No location found", @"Error description.")
                                                           }];
            [strongSelf.delegate managerDidFailFetchingLocationsWithError:error];
        }

    } failure:^(NSError * _Nullable error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if(error){
            [strongSelf.delegate managerDidFailFetchingLocationsWithError:error];
        } else {
            NSError *error = [NSError errorWithDomain:GECommunicatorErrorDomain
                                                 code:GECommunicatorInvalidError
                                             userInfo:@{
                                                        NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid error", @"Error description.")
                                                        }];
             [strongSelf.delegate managerDidFailFetchingLocationsWithError:error];
        }
    }];
}

/**
 Lazy initializer for builder
 */

- (GEBuilder *)builder {
    if (!_builder) {
        _builder = [[GEBuilder alloc]init];
    }
    return _builder;
}

@end
