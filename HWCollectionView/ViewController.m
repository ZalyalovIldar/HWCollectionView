//
//  ViewController.m
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define kMinimumLineSpacing 1.0f
#define kMinimumInteritemSpacing 1.0f
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"], [UIImage imageNamed:@"5"], [UIImage imageNamed:@"6"], [UIImage imageNamed:@"7"], [UIImage imageNamed:@"8"], [UIImage imageNamed:@"9"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    self.flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    self.flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    
    self.profilePhoto.image = [UIImage imageNamed:@"ProfilePhoto"];
    self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width/2;
    self.profilePhoto.clipsToBounds = YES;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)againWatchTutorialButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ViewLoad"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToTutorial = [tempStoryboard instantiateViewControllerWithIdentifier:@"Tutorial"];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:moveToTutorial animated:YES completion:nil];
    
}

#pragma mark FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
       CGFloat width = CGRectGetWidth(collectionView.frame) / 3 - 2 * kMinimumInteritemSpacing;
    return CGSizeMake(width, width);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageInCell.image = (UIImage*) _dataSource[indexPath.row];    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */


@end
