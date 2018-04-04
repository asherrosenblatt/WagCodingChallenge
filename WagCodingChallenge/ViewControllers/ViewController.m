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
    [self getUsersAndImages];
}

-(void)getUsersAndImages
{
    [UserAPI getUsers:^(NSArray *resultArray, NSString *errorString) {
        if (resultArray && !errorString)
        {
            self.users = resultArray;
            [self.mainTableView reloadData];
            for (User *user in resultArray)
            {
                [UserAPI getProfileImageForUser:user :^(NSData *imageData, NSString *errorString) {
                    if (imageData && !errorString)
                    {
                        UIImage *profImg = [UIImage imageWithData:imageData];
                        user.profileImage = profImg;
                        [self.mainTableView reloadData];
                        NSLog(@"image");
                    }
                    else
                    {
                        NSLog(@"error");
                    }
                }];
            }
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
    cell.usernameLabel.text = user.displayName;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Gold: %@ Silver: %@ Bronze: %@", user.goldBadgeCount, user.silverBadgeCount, user.bronzeBadgeCount];
    if (user.profileImage == nil)
    {
        [cell.imgLoadingIndicator startAnimating];
    }
    else
    {
        [cell.imgLoadingIndicator stopAnimating];
        cell.profileImageView.image = user.profileImage;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(void)refresh
{
    [self getUsersAndImages];
}
@end
