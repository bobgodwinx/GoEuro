//
//  GECommunicator.m
//  GoEuroObjC
//
//  Created by Bob Godwin Obi on 10/13/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

#import "GECommunicator.h"

@interface GECommunicator ()

@property (nonatomic) NSURLSession *URLSession;
@property (nonatomic) NSURL *baseURL;

@end

NSString *const GECommunicatorErrorDomain = @"GECommunicatorErrorDomain";
NSString *const kBasePath = @"db_access_web.php";
NSString *const kHTTPMethodPOST = @"POST";
NSString *const kHTTPMethodGET = @"GET";

@implementation GECommunicator

#pragma mark - init

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
    self = [super init];
    if(self){
        _baseURL = baseURL;
        _URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return self;
}

#pragma mark - helper methods

- (NSString *)stringForQueryWithParameters:(NSDictionary *)parameters
{
    NSMutableArray *arrayOfParameters = [[NSMutableArray alloc]init];
    
    for(NSString *key in parameters){
        NSString *queryString = [NSString stringWithFormat:@"%@=%@", key, parameters[key]];
        [arrayOfParameters addObject:queryString];
    }
    
    return [arrayOfParameters componentsJoinedByString:@"&"];
}

- (NSURL *)URLForQueryWithPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSString *pathWithParameters;
    
    if(path && parameters){
        pathWithParameters = [NSString stringWithFormat:@"%@?%@", path, [self stringForQueryWithParameters:parameters]];
    }else if (!path && parameters){
        pathWithParameters = [NSString stringWithFormat:@"?%@", [self stringForQueryWithParameters:parameters]];
    }else if (path && !pathWithParameters){
        pathWithParameters = [NSString stringWithFormat:@"%@", path];
    }
    return [NSURL URLWithString:[pathWithParameters stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
}

- (void)performWebServiceCallWithURL:(NSURL *)URL
                              method:(NSString *)method
                          parameters:(NSDictionary *)parameters
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = method;
    
    if(method == kHTTPMethodPOST && parameters){
        NSString *queryString = [self stringForQueryWithParameters:parameters];
        NSData *httpBody = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        request.HTTPBody = httpBody;
    }
    
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
        
        if([JSONSerialization isKindOfClass:[NSDictionary class]] && [NSJSONSerialization isValidJSONObject:JSONSerialization]){
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

- (void)fetchContentsWith:(NSDictionary *)parameters
                  success:(void (^)(NSDictionary *response))success
                  failure:(void (^)(NSError *error))failure
{
    NSURL *URL = [self URLForQueryWithPath:kBasePath parameters:parameters];
    [self performWebServiceCallWithURL:URL
                                method:kHTTPMethodGET
                            parameters:parameters
                               success:^(id response) {
                                   success((NSDictionary *)response);
                               } failure:^(NSError *error) {
                                   failure(error);
                               }];
}

@end

