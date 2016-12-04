//
//  SomeUserPageVC.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SomeUserPageVC : UIViewController 

@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSayLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSString * userAvatarImageName;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * postImageName;
@property (strong, nonatomic) NSString * userSay;
@property (strong, nonatomic) NSString * userName;


@end
