//
//  NewsTVC.h
//  HWCollectionView
//
//  Created by Ленар on 30.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTVC : UITableViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *historyCollectionView;

-(void)pushToFriendControllerClicked:(UIButton*)sender;

@end
