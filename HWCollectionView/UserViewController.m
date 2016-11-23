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

@interface UserViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) NSArray *imageNameArray;
@property (strong, nonatomic) NSArray *commentStringArray;
@property (strong, nonatomic) NSString *imageNameString;
@property (strong, nonatomic) NSString *commentString;

@end

@implementation UserViewController

static NSString * const reuseIdentifier = @"Cell";

- (IBAction)againWatchTutorialButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ViewLoad"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToTutorial = [tempStoryboard instantiateViewControllerWithIdentifier:@"Tutorial"];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:moveToTutorial animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
    Data *data = [Data new];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.galleryCollectionView addSubview:refreshControl];
    [self.galleryCollectionView setBounces:YES];
    self.galleryCollectionView.alwaysBounceVertical = YES;
    self.imageNameArray = [NSArray arrayWithArray:[data getImageNameArray]];
    self.commentStringArray = [NSArray arrayWithArray:[data getCommentArray]];
    [self.galleryCollectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/3-1, self.view.frame.size.width/3-1);
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    [self.galleryCollectionView setCollectionViewLayout:flowLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"ViewLoad"]!=0){
        [self visited];
    }
}

-(void)startRefresh{
    [self.galleryCollectionView reloadData];
}

-(void)visited{
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToTutorial = [tempStoryboard instantiateViewControllerWithIdentifier:@"Tutorial"];
    [self presentViewController:moveToTutorial animated:YES completion:nil];

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
    cell.PhotoImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.commentString = self.commentStringArray[indexPath.row];
    self.imageNameString = self.imageNameArray[indexPath.row];
    WatchPostVC *vc = (WatchPostVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"watch"];
    vc.commentString = self.commentString;
    vc.imageNameString = self.imageNameString;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
