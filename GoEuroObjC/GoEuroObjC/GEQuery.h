//
//  GEQuery.h
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

@import Foundation;

@interface GEQuery : NSObject<NSCopying>
/**
 String type to store the current locale. e.g. DE
 */
@property (nonnull, nonatomic, copy) NSString *locale;
/**
 String type to store the search term
 */
@property (nonnull, nonatomic, copy) NSString *term;
/**
 Designated Initializer
 */
-(nonnull instancetype)initWithLocale:(NSString *_Nonnull)locale term:(NSString *_Nonnull)term NS_DESIGNATED_INITIALIZER;

@end
