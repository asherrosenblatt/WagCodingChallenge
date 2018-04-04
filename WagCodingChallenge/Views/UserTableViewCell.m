//
//  UserTableViewCell.m
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.profileImageView.layer setCornerRadius:37.5];
    [self.profileImageView.layer setMasksToBounds:YES];
    self.imgLoadingIndicator = [UIActivityIndicatorView new];
    [self.imgLoadingIndicator setFrame:self.profileImageView.bounds];
    [self.profileImageView addSubview:self.imgLoadingIndicator];
    [self.imgLoadingIndicator setHidesWhenStopped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
