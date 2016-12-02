//
//  NewsTVC.m
//  HWCollectionView
//
//  Created by Ленар on 30.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "NewsTVC.h"
#import "HistoryCVCell.h"
#import "UserModel.h"
#import <FMDB.h>
#import "DataManager.h"
#import "NewsTVCell.h"
#import "FriendVC.h"

@interface NewsTVC ()
{
    NSArray *dataArr;
}

@end

static NSString *const reuseIdentifier = @"History";
static NSString *const newsIdentifier = @"News";

@implementation NewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.historyCollectionView registerNib:[UINib nibWithNibName:@"HistoryCVCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.historyCollectionView.delegate = self;
    self.historyCollectionView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    dataArr = [[DataManager sharedInstance] getUsersArrFromDataBase];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTVCell" bundle:nil] forCellReuseIdentifier:newsIdentifier];
    
}

#pragma mark - history collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistoryCVCell *cell = (HistoryCVCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width/2;
    cell.userImageView.clipsToBounds = YES;
    cell.userImageView.image = [UIImage imageNamed:@"user"];
    cell.userNameLabel.text = @"Lenar";
    return cell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTVCell *cell = (NewsTVCell*)[tableView dequeueReusableCellWithIdentifier:newsIdentifier forIndexPath:indexPath];
    UserModel *user = dataArr[indexPath.row];
    cell.userImageView.image = [UIImage imageNamed:user.userImageName];
    [cell.usernameButton setTitle:user.username forState:UIControlStateNormal];
    cell.usernameButton.tag = indexPath.row;
    [cell.usernameButton addTarget:self action:@selector(pushToFriendControllerClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.postImageView.image = [UIImage imageNamed:user.postImageName.firstObject];
    cell.pushToFriendButton.tag = indexPath.row;
    [cell.pushToFriendButton addTarget:self action:@selector(pushToFriendControllerClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 379;
}

- (void)refreshTable {
    [self.refreshControl beginRefreshing];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - push to friend

- (void)pushToFriendControllerClicked:(UIButton *)sender{
    FriendVC *vc = (FriendVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"Friend"];
    UserModel *model = dataArr[sender.tag];
    vc.nameString = model.name;
    vc.userNameString = model.username;
    vc.imageNameString = model.userImageName;
    vc.postImageName = model.postImageName.firstObject;
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
