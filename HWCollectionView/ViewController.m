//
//  ViewController.m
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataSours;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSours = @[[UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"], [UIImage imageNamed:@"5"], [UIImage imageNamed:@"1"], [UIImage imageNamed:@"6"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"], [UIImage imageNamed:@"5"], [UIImage imageNamed:@"1"], [UIImage imageNamed:@"6"],  [UIImage imageNamed:@"1"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    _userImage.image = [UIImage imageNamed:@"user"];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:1.0f];
    [flowLayout setMinimumLineSpacing:1.0f];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/3-1, self.view.frame.size.width/3-1)];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(!([[userDefaults objectForKey:@"showDescription"]  isEqual: @"true"])){
        [userDefaults setObject:@"true" forKey:@"showDescription"];
        [userDefaults synchronize];
        UIStoryboard *mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *descriptionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Description"];
        [self presentViewController:descriptionVC animated:NO completion:nil];
    }
}

- (IBAction)infoButtonPressed:(id)sender {
    UIStoryboard *mainStoryboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *descriptionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Description"];
    [self presentViewController:descriptionVC animated:NO completion:nil];
    
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSours.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageViewCell.image = (UIImage*)_dataSours[indexPath.row];
    return cell;
}

@end
