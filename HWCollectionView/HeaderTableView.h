//
//  HeaderTableView.h
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderTableView;
@protocol HeaderDelegate <NSObject>

- (void)changePhotoDidClickedInView:(HeaderTableView *)view;

@end

@interface HeaderTableView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;

@property (nonatomic, weak) id<HeaderDelegate> delegate;

@end
