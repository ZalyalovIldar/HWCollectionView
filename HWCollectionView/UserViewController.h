//
//  UserViewController.h
//  HWCollectionView
//
//  Created by Ленар on 07.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *galleryCollectionView;

@end
