//
//  mainViewController.m
//  HWCollectionView
//
//  Created by Наталья on 03.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "MainViewController.h"
#import "MainCustomTableViewCell.h"
#import "MainCustomCollectionViewCell.h"
#import "DataManager.h"
#import "ViewController.h"
#import "User.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *tapeTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *storiesCollectionView;
@property (strong, nonatomic) NSArray *sourceArr;

@end

@implementation MainViewController

static NSString *reuseIdentifireTV = @"CellTV";
static NSString *reuseIdentifireCV = @"CellCV";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tapeTableView.delegate = self;
    self.tapeTableView.dataSource = self;
    self.storiesCollectionView.delegate = self;
    self.storiesCollectionView.dataSource = self;
    [self.tapeTableView registerNib:[UINib nibWithNibName:@"MainCustomTableViewCell" bundle:nil]forCellReuseIdentifier:reuseIdentifireTV];
    [self.storiesCollectionView registerNib:[UINib nibWithNibName:@"MainCustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifireCV];
    NSError *error = nil;
    self.sourceArr = [[DataManager sharedInstance] allUsersWithError:&error];
    if (error)
    {
        NSLog(@"%@", error);
    }else
    {
        NSLog(@"%@", self.sourceArr );
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 78;
    }
    return tableView.sectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    if (section == 0){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 78)];

        UICollectionView *storiesCollectionView = [[UICollectionView alloc]initWithFrame:headerView.bounds collectionViewLayout: layout];
        storiesCollectionView.delegate = self;
        storiesCollectionView.dataSource = self;
        [storiesCollectionView registerNib:[UINib nibWithNibName:@"MainCustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifireCV];
        storiesCollectionView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:storiesCollectionView];
        return headerView;
    }
    return nil;
    
}



#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 450;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *newViewController = [main instantiateViewControllerWithIdentifier:@"ViewController"];
    
    newViewController.user = self.sourceArr[indexPath.row];
    newViewController.navigationItem.leftBarButtonItem = nil;
    [self.navigationController pushViewController:newViewController animated:YES];
    
}

#pragma mark - Table View Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArr.count ;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(MainCustomTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifireTV forIndexPath:indexPath];
    
    User *user = self.sourceArr[indexPath.row];
    cell.tapeImage.image = [UIImage imageWithData:user.contents[indexPath.row].imageData];
    //cell.profileNameLabel.text = user.preferences.nikName;
    
    
    [cell.profileNameButton setTitle:user.preferences.nikName forState:UIControlStateNormal];
    cell.profileNameButton.tag = indexPath.row;
    [cell.profileNameButton addTarget:self action:@selector(openAnotherProfileFromNews:) forControlEvents:UIControlEventTouchUpInside];
        
    return cell;
    
}

- (void)openAnotherProfileFromNews:(UIButton *)sender{
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *newViewController = [main instantiateViewControllerWithIdentifier:@"ViewController"];
    
    newViewController.user = self.sourceArr[sender.tag];
    newViewController.navigationItem.leftBarButtonItem = nil;
    [self.navigationController pushViewController:newViewController animated:YES];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sourceArr.count ;
}




- (MainCustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MainCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifireCV forIndexPath:indexPath];
    User *user = self.sourceArr[indexPath.row];
    cell.storiesImage.image = [UIImage imageWithData:user.preferences.profileImageData];
    cell.storiesImage.layer.cornerRadius = cell.frame.size.width / 2;
    cell.storiesImage.clipsToBounds = YES;
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = CGRectGetWidth(self.storiesCollectionView.frame) / 4 - 20;
    return CGSizeMake(60,60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

@end
