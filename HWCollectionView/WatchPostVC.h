//
//  WatchPostVC.h
//  HWCollectionView
//
//  Created by Ленар on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchPostVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) NSString *imageNameString;
@property (strong, nonatomic) NSString *commentString;

@end
