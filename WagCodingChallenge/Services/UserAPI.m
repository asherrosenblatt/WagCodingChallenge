//
//  UserAPI.m
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import "UserAPI.h"

@implementation UserAPI

+(void)getUsers :(void(^)(NSArray *resultArray, NSString* errorString))handler
{
    __block NSMutableArray *objectArray;
    __block NSString *errorStr;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"https://api.stackexchange.com/2.2/users?site=stackoverflow"]];
    
    [request setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    if (!error) {
        NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (data && !error && [httpResponse statusCode]==200)
            {
                NSDictionary *responseDic = [[NSDictionary alloc] init];
                responseDic = [NSJSONSerialization JSONObjectWithData:data options:NO error:nil];
                NSArray *responseArray = [NSArray new];
                responseArray = responseDic[@"items"];
                objectArray = [NSMutableArray new];
                for (NSDictionary *userDict in responseArray)
                {
                    User *user = [[User alloc] initUserWithDictionary:userDict];
                    [objectArray addObject:user];
                }
                handler(objectArray, errorStr);
            }
            else
            {
                NSLog(@"Eroor getting users");
                errorStr = error.localizedDescription;
                handler(objectArray, errorStr);
            }
        }];
        [dataTask resume];
        
    }
}

+(void)getProfileImageForUser :(User *)user :(void(^)(NSData *imageData, NSString* errorString))handler
{
    __block NSString *errorStr;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:user.profileImgURL];
    
    //[request setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    if (!error) {
        NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (data && !error && [httpResponse statusCode]==200)
            {
                handler(data, errorStr);
            }
            else
            {
                NSLog(@"Eroor getting image data");
                errorStr = error.localizedDescription;
                handler(nil, errorStr);
            }
        }];
        [dataTask resume];
        
    }
}
@end
