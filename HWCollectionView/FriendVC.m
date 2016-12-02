//
//  FriendVC.m
//  HWCollectionView
//
//  Created by Ленар on 02.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "FriendVC.h"
#import "PhotoCollectionViewCell.h"

@interface FriendVC ()

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation FriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.userNameString;
    self.usernameLabel.textColor = [UIColor clearColor];
    self.userImageView.image = [UIImage imageNamed:self.imageNameString];
    self.navigationItem.title = self.nameString;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
    [self.userImagesCollectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/3-1, self.view.frame.size.width/3-1);
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    [[self.subscribeButton layer] setCornerRadius:3.0f];
    [[self.subscribeButton layer] setMasksToBounds:YES];
    [self.userImagesCollectionView setCollectionViewLayout:flowLayout];
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photoLabel.text = @"";
    cell.PhotoImageView.image = [UIImage imageNamed:self.postImageName];
    return cell;
}

@end
