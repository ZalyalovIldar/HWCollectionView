//
//  ViewController.m
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ViewController.h"
#import "CustomCellCollectionViewCell.h"
#import "ShowOnePhotoViewController.h"
#import "DataWorker.h"
#import "Content.h"
#import "Preferences.h"

#define kMinimumLineSpacing 1.0f
#define kMinimumInteritemSpacing 1.0f
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *photoArray;
@property (weak, nonatomic) IBOutlet UIImageView *mainPhoto;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end

@implementation ViewController


- (NSArray *)photoArray
{
    if(!_photoArray){
//        _photoArray = @[[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"], [UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"], [UIImage imageNamed:@"6.jpg"],[UIImage imageNamed:@"7.jpg"], [UIImage imageNamed:@"8.jpg"],[UIImage imageNamed:@"9.jpg"], [UIImage imageNamed:@"10.jpg"],[UIImage imageNamed:@"11.jpg"], [UIImage imageNamed:@"12.jpg"],[UIImage imageNamed:@"13.jpg"],[UIImage imageNamed:@"14.jpg"]];
        
        
    }
    return _photoArray;
}

static NSString *reuseIdentifire = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifire];
    
    self.flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    self.flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;

    
    self.mainPhoto.image = [UIImage imageNamed:@"mainPhoto.jpg"];
    self.mainPhoto.layer.cornerRadius = self.mainPhoto.frame.size.width / 2;
    self.mainPhoto.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    DataWorker *worker = [DataWorker sharedInstance];
    [worker fetchAllContentWithSuccesBlock:^(NSArray *result) {
        self.photoArray = result;
        [self.collectionView reloadData];
        
    } andErrorBlock:^(NSError *error) {
        
    }];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferences"];
    Preferences *preferences = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (preferences)
    {
        self.mainPhoto.image = [UIImage imageWithData:preferences.profileImageData];
        self.nikNameLabel.text = preferences.nikName;
        self.aboutLabel.text = preferences.about;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = CGRectGetWidth(collectionView.frame) / 3 - 2 * kMinimumInteritemSpacing;
    return CGSizeMake(width, width);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
}


- (CustomCellCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifire forIndexPath:indexPath];
    Content *content = self.photoArray[indexPath.row];
    cell.cellImage.image = [UIImage imageWithData: content.imageData];
    cell.commentLabel.text = content.text;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showImage" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showImage"]) {
     
    ShowOnePhotoViewController *destViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].firstObject;
    destViewController.content = self.photoArray[indexPath.row];
    
       
    }

}
    
    @end

