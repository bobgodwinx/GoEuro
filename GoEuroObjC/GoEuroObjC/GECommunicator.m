//
//  GECommunicator.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GECommunicator.h"
#import "GEIdentifiers.h"

@interface GECommunicator ()

@property (nonatomic) NSURLSession *URLSession;

@end

NSString *const GECommunicatorErrorDomain = @"GECommunicatorErrorDomain";
NSString *const kSearchPath = @"http://api.goeuro.com/api/v2/position/suggest/{locale}/{term}";
NSString *const kHTTPMethodGET = @"GET";

@implementation GECommunicator

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if(self){
        _URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

#pragma mark - helper methods

- (NSURL *)URLForQueryWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
    NSString *pathWithParameters;
    pathWithParameters = [kSearchPath stringByReplacingOccurrencesOfString:kSearchPathLocale withString:parameters[kLocale]];
    pathWithParameters = [pathWithParameters stringByReplacingOccurrencesOfString:kSearchPathTerm withString:parameters[kTerm]];
    return [NSURL URLWithString:pathWithParameters];
}

#pragma mark - Perform API Call
- (void)performAPICallWithURL:(NSURL *)URL
                              method:(NSString *)method
                          parameters:(NSDictionary *)parameters
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *error))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = method;

    NSURLSessionDataTask *task = [self.URLSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            NSError *netWorkError = [NSError errorWithDomain:GECommunicatorErrorDomain
                                                        code:GECommunicatorNetworkingError
                                                    userInfo:@{
                                                                NSUnderlyingErrorKey:error
                                                              }];
            return failure(netWorkError);
        }
        
        NSError *serializationError;
        
        NSJSONSerialization *JSONSerialization = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:&serializationError];
        if(serializationError){
            NSError *theError = [NSError errorWithDomain:GECommunicatorErrorDomain
                                                    code:GECommunicatorSerializationError
                                                userInfo:@{
                                                           NSUnderlyingErrorKey:serializationError
                                                          }];
            return failure(theError);
        }
        
        if([JSONSerialization isKindOfClass:[NSArray class]] && [NSJSONSerialization isValidJSONObject:JSONSerialization]){
            return success(JSONSerialization);
        }else{
            NSError *invalidResponseError = [NSError errorWithDomain:GECommunicatorErrorDomain
                                                                code:GECommunicatorInvalidResponseError
                                                            userInfo:@{
                                                                       NSUnderlyingErrorKey:@"Invalid JSONResponse"
                                                                      }];
            return failure(invalidResponseError);
        }
    }];
    
    [task resume];
}


- (void)fetchLocationsWith:(NSDictionary *)parameters
                   success:(void (^)(NSArray * _Nullable))success
                   failure:(void (^)(NSError * _Nullable))failure {
    
    NSURL *URL = [self URLForQueryWithPath:kSearchPath parameters:parameters];
    [self performAPICallWithURL:URL
                         method:kHTTPMethodGET
                     parameters:parameters
                        success:^(id response) {
                            success((NSArray *)response);
                        } failure:^(NSError *error) {
                            failure(error);
                        }];
}

@end

