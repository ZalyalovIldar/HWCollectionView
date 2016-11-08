//
//  UserViewController.m
//  HWCollectionView
//
//  Created by Ленар on 07.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "UserViewController.h"
#import "PhotoCollectionViewCell.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

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

-(void)visited{
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToTutorial = [tempStoryboard instantiateViewControllerWithIdentifier:@"Tutorial"];
    [self presentViewController:moveToTutorial animated:NO completion:nil];

}
#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.PhotoImageView.image = [UIImage imageNamed:@"cat"];
    return cell;
}

@end
