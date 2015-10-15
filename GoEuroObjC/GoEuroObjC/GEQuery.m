//
//  GEQuery.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GEQuery.h"

@implementation GEQuery

- (instancetype)init {
    return [self initWithLocale:@"DE" term:@"Berlin"];
}

- (nonnull instancetype)initWithLocale:(NSString *)locale
                                  term:(NSString *)term {
    self = [super init];
    if(self){
        _locale = [locale copy];
        _term = [term copy];
    }
    return self;
}

- (nonnull instancetype)copyWithZone:(__unused NSZone *)zone {
    return self;
}

@end
