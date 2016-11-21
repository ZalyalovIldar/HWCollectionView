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

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *arrayLabels;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

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
        UIStoryboard *mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *descriptionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Description"];
        [self presentViewController:descriptionVC animated:NO completion:nil];
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    _userImage.image = [UIImage imageNamed:@"user"];
    
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
