//
//  User.h
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSNumber *accountId;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSURL *profileImgURL;
@property (strong, nonatomic) NSNumber *bronzeBadgeCount;
@property (strong, nonatomic) NSNumber *silverBadgeCount;
@property (strong, nonatomic) NSNumber *goldBadgeCount;

- (id)initUserWithDictionary: (NSDictionary *)userDictionary;
@end
