//
//  SomeUserPageVC.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "SomeUserPageVC.h"
#import "MyCollectionViewCell.h"

@interface SomeUserPageVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation SomeUserPageVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _userName;
    
    self.userAvatar.image = [UIImage imageNamed:_userAvatarImageName];
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
    self.userAvatar.clipsToBounds = YES;
    
    self.userSayLabel.text = _userSay;
    self.nameLabel.text = _name;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake([self setSize], [self setSize])];
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    [self.collectionView setCollectionViewLayout:flowLayout];
}

#pragma mark - Collection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.collectionView.image = [UIImage imageNamed:_postImageName];
    cell.cellLabel.text = nil;
    // Configure the cell
    return cell;
}

//размер ячейки
-(int)setSize{
    int res = self.view.frame.size.width/3-1;
    return res;
}
@end
