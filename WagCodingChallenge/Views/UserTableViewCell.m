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
    [self.goldLabel.layer setCornerRadius:10.0];
    [self.goldLabel.layer setMasksToBounds:YES];
    [self.goldLabel setBackgroundColor:[UIColor colorWithRed:0.99 green:0.97 blue:0.90 alpha:1.00]];
    
    [self.silverLabel.layer setCornerRadius:10.0];
    [self.silverLabel.layer setMasksToBounds:YES];
    [self.silverLabel setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.94 alpha:1.00]];
    
    [self.bronzeLabel.layer setCornerRadius:10.0];
    [self.bronzeLabel.layer setMasksToBounds:YES];
    [self.bronzeLabel setBackgroundColor:[UIColor colorWithRed:0.96 green:0.93 blue:0.89 alpha:1.00]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
