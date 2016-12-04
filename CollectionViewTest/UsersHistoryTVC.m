//
//  UsersHistoryTVC.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 02.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UsersHistoryTVC.h"
#import "UsersHistoryCell.h"
#import "UsersHistoryTableCell.h"
#import "HistoryDataModel.h"
#import "DataSQL.h"
#import "SomeUserPageVC.h"

@interface UsersHistoryTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSArray *dataArr;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation UsersHistoryTVC

static NSString * const collectionReuseIdentifier = @"collectionCell";
static NSString * const tableReuseIdentifier = @"tableCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArr = [[DataSQL sharedInstance] getUsersFromDataBase];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"UsersHistoryCell" bundle:nil] forCellWithReuseIdentifier:collectionReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"UsersHistoryTableCell" bundle:nil] forCellReuseIdentifier:tableReuseIdentifier];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UsersHistoryCell *cell = (UsersHistoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseIdentifier forIndexPath:indexPath];
    cell.userLabel.text = @"Name";
    cell.userAvatar.image = [UIImage imageNamed:@"4"];
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
    UsersHistoryTableCell *cell = (UsersHistoryTableCell *)[tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier forIndexPath:indexPath];
    HistoryDataModel *model = dataArr[indexPath.row];
    
    cell.userAvatar.image = [UIImage imageNamed:model.userAvatarImage];
    
    cell.userHistoryImage.image = [UIImage imageNamed:model.postImageName.firstObject];
    [cell.userName setTitle:model.userName forState:UIControlStateNormal];
    cell.userName.tag = indexPath.row;
    cell.dotsButton.tag = indexPath.row;
    [cell.userName addTarget:self action:@selector(pushToSomeUser:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dotsButton addTarget:self action:@selector(pushToSomeUser:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

#pragma mark - Some User Push

-(void)pushToSomeUser:(UIButton *)sender{
    SomeUserPageVC *someUserPageVC = (SomeUserPageVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"SomeUserPageVC"];
    HistoryDataModel *model = dataArr[sender.tag];
    someUserPageVC.userSay = model.userSay;
    someUserPageVC.userName = model.userName;
    someUserPageVC.userAvatarImageName = model.userAvatarImage;
    someUserPageVC.postImageName = model.postImageName.firstObject;
    [self.navigationController pushViewController:someUserPageVC animated:YES];
}


@end
