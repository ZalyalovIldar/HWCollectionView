//
//  FriendVC.h
//  HWCollectionView
//
//  Created by Ленар on 02.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *userImagesCollectionView;
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *userNameString;
@property (strong, nonatomic) NSString *imageNameString;
@property (strong, nonatomic) NSString *postImageName;

@end
