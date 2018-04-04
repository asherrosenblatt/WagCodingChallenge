//
//  UserAPI.h
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserAPI : NSObject

+(void)getUsers :(void(^)(NSArray *resultArray, NSString* errorString))handler;
+(void)getProfileImageForUser :(User *)user :(void(^)(NSData *imageData, NSString* errorString))handler;
@end
