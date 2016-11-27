//
//  ViewController.m
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DetailCollectionView.h"
#import "ListProcessor.h"
#import "UserSettings.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *arrayLabels;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    ListProcessor *lp = [ListProcessor new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(!([[userDefaults objectForKey:@"showDescription"]  isEqual: @"true"])){
        [lp firsLoad];
        [userDefaults setObject:@"true" forKey:@"showDescription"];
        [userDefaults synchronize];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *descriptionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Description"];
        [self presentViewController:descriptionVC animated:NO completion:nil];
    }
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstStart"] isEqual:@"false"]){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *userSettings = [mainStoryboard instantiateViewControllerWithIdentifier:@"userSettings"];
        [self.navigationController pushViewController:userSettings animated:YES];
    }
    else{
        UserSettings *userSettings = (UserSettings*)[UserSettings unarchiveUserSettings];
        _nameLabel.text = userSettings.name;
        _navigationBar.title = userSettings.userName;
        _bioLabel.text = userSettings.bio;
        _userImage.clipsToBounds = true;
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:1.0f];
    [flowLayout setMinimumLineSpacing:1.0f];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/3-1, self.view.frame.size.width/3-1)];
    [self.collectionView setCollectionViewLayout:flowLayout];

    [lp getLabelsArray];
    _arrayLabels = [[NSMutableArray alloc] initWithArray:[lp getLabelsArray]];
    _imageArray = [[NSMutableArray alloc] initWithArray:[lp getImageArray]];
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    

}

- (void)viewWillAppear:(BOOL)animated{
    UserSettings *userSettings = (UserSettings*)[UserSettings unarchiveUserSettings];
    _nameLabel.text = userSettings.name;
    _navigationBar.title = userSettings.userName;
    _bioLabel.text = userSettings.bio;
    _userImage.image = [self loadImage];

}

- (IBAction)infoButtonPressed:(id)sender {
    UIStoryboard *mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *descriptionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Description"];
    [self presentViewController:descriptionVC animated:NO completion:nil];
    
}
- (IBAction)addElements:(id)sender {
    DetailCollectionView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailCollectionView"];
    vc.indexCell = -1;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)refresh{
    ListProcessor *lp = [ListProcessor new];
    _arrayLabels = [lp getLabelsArray];
    _imageArray = [lp getImageArray];
    [_collectionView reloadData];
    [_refreshControl endRefreshing];
}


-(UIImage*)loadImage{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[path stringByAppendingPathComponent:@"photo.png"];
    UIImageView *myimage=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    myimage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    return myimage.image;
}
#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.labelCell.text = _arrayLabels[indexPath.row];
    cell.imageViewCell.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailCollectionView"];
    vc.indexCell = (int)indexPath.row;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
