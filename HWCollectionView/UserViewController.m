//
//  UserViewController.m
//  HWCollectionView
//
//  Created by Ленар on 07.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "UserViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Data.h"
#import "WatchPostVC.h"
#import "TableSettings.h"

@interface UserViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) NSArray *imageNameArray;
@property (strong, nonatomic) NSArray *commentStringArray;
@property (strong, nonatomic) NSString *imageNameString;
@property (strong, nonatomic) NSString *commentString;
@property (nonatomic)UIRefreshControl *refreshControl;
@property (nonatomic,strong)Data *data;

@end

@implementation UserViewController

static NSString * const reuseIdentifier = @"Cell";

- (IBAction)againWatchTutorialButton:(id)sender {
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToTutorial = [tempStoryboard instantiateViewControllerWithIdentifier:@"Tutorial"];
    [self presentViewController:moveToTutorial animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TableSettings *userInfo = (TableSettings*)[TableSettings unarchiveData];
    self.navigationItem.title = userInfo.name;
    self.userNameLabel.text = userInfo.username;
    self.webpageLabel.text = userInfo.webpage;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
    self.data = [Data new];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imagePath=[path stringByAppendingPathComponent:@"userPhoto.png"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        self.userImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
    else {
        self.userImageView.image = [UIImage imageNamed:@"user"];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.galleryCollectionView addSubview:self.refreshControl];
    [self.galleryCollectionView setBounces:YES];
    self.galleryCollectionView.alwaysBounceVertical = YES;
    self.imageNameArray = [NSArray arrayWithArray:[self.data getImageNameArray]];
    self.commentStringArray = [NSArray arrayWithArray:[self.data getCommentArray]];
    [self.galleryCollectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/3-1, self.view.frame.size.width/3-1);
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    [self.galleryCollectionView setCollectionViewLayout:flowLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    TableSettings *userInfo = (TableSettings*)[TableSettings unarchiveData];
    self.navigationItem.title = userInfo.name;
    self.userNameLabel.text = userInfo.username;
    self.webpageLabel.text = userInfo.webpage;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [[self.editInformationAboutUserButton layer] setCornerRadius:3.0f];
    [[self.editInformationAboutUserButton layer] setMasksToBounds:YES];
    NSString *imagePath=[path stringByAppendingPathComponent:@"userPhoto.png"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        self.userImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
    else {
        self.userImageView.image = [UIImage imageNamed:@"user"];
    }
}

-(void)startRefresh{
    [self.refreshControl beginRefreshing];
    self.imageNameArray = [NSArray arrayWithArray:[self.data getImageNameArray]];
    self.commentStringArray = [NSArray arrayWithArray:[self.data getCommentArray]];
    [self.galleryCollectionView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photoLabel.text = self.commentStringArray[indexPath.row];
    cell.PhotoImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.commentString = self.commentStringArray[indexPath.row];
    self.imageNameString = self.imageNameArray[indexPath.row];
    WatchPostVC *vc = (WatchPostVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"watch"];
    vc.commentString = self.commentString;
    vc.imageNameString = self.imageNameString;
    vc.numberOfRow = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)editUserProfileButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"setting"];
    [self presentViewController:settingVC animated:YES completion:nil];
}

@end
