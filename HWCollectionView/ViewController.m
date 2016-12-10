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
@property (weak, nonatomic) IBOutlet UIImageView *mainPhoto;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *postsLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscribersLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscriptionsLabel;




@end

@implementation ViewController


static NSString *reuseIdentifire = @"Cell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifire];
    
    self.flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    self.flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    
        
    self.mainPhoto.layer.cornerRadius = self.mainPhoto.frame.size.width / 2;
    self.mainPhoto.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
    if (!self.user)
    {
        self.user = [User new];
        DataWorker *worker = [DataWorker sharedInstance];
        [worker fetchAllContentWithSuccesBlock:^(NSArray *result) {
            self.user.contents = result;
            [self.collectionView reloadData];
            
        } andErrorBlock:^(NSError *error) {
            
        }];
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferences"];
        Preferences *preferences = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if (!preferences){
            
            [self performSegueWithIdentifier:@"showSettings" sender:nil];
            
        }

        self.user.preferences = preferences;
      
        self.user.posts = @"7";
        self.user.subscribers = @"7";
        self.user.subscriptions = @"10";
    }
    
    self.mainPhoto.image = [UIImage imageWithData:self.user.preferences.profileImageData];
    self.aboutLabel.text = self.user.preferences.about;
    
    self.postsLabel.text = self.user.posts;
    self.subscribersLabel.text = self.user.subscribers;
    self.subscriptionsLabel.text = self.user.subscriptions;
    
    self.mainPhoto.layer.cornerRadius = self.mainPhoto.frame.size.width / 2;
    self.mainPhoto.clipsToBounds = YES;

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
    return self.user.contents.count;
}


- (CustomCellCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifire forIndexPath:indexPath];
    Content *content = self.user.contents[indexPath.row];
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
    destViewController.content = self.user.contents[indexPath.row];
    
       
    }

}
    
    @end

