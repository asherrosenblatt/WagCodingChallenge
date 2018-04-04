//
//  ViewController.m
//  WagCodingChallenge
//
//  Created by Asher Rosenblatt on 4/3/18.
//  Copyright © 2018 AVRTech. All rights reserved.
//

#import "ViewController.h"
#import "UserAPI.h"
#import "User.h"
#import "UserTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSArray *users;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainTableView.refreshControl = [UIRefreshControl new];
    [self.mainTableView.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"ID"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getUsers];
}

-(void)getUsers
{
    [UserAPI getUsers:^(NSArray *resultArray, NSString *errorString) {
        if (resultArray && !errorString)
        {
            self.users = resultArray;
            [self.mainTableView reloadData];
        }
        else
        {
            NSLog(@"error");
        }
        [self.mainTableView.refreshControl endRefreshing];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil)
    {
        cell = [[UserTableViewCell alloc] init];
    }
    User *user = [self.users objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.usernameLabel.text = user.displayName;
    cell.goldLabel.text = user.goldBadgeCount.stringValue;
    cell.silverLabel.text = user.silverBadgeCount.stringValue;
    cell.bronzeLabel.text = user.bronzeBadgeCount.stringValue;
    [cell.profileImageView sd_setShowActivityIndicatorView:YES];
    [cell.profileImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.profileImageView sd_setImageWithURL:user.profileImgURL];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(void)refresh
{
    [self getUsers];
}
@end
