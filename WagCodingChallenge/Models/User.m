//
//  User.m
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initUserWithDictionary:(NSDictionary *)userDictionary
{
    id result = [super init];
    self.accountId = userDictionary[@"account_id"];
    self.age = userDictionary[@"age"];
    self.displayName = userDictionary[@"display_name"];
    self.bronzeBadgeCount = userDictionary[@"badge_counts"][@"bronze"];
    self.silverBadgeCount = userDictionary[@"badge_counts"][@"silver"];
    self.goldBadgeCount = userDictionary[@"badge_counts"][@"gold"];
    NSString *profImgURLString = userDictionary[@"profile_image"];
    self.profileImgURL = [NSURL URLWithString:profImgURLString];
    return result;
}
@end
