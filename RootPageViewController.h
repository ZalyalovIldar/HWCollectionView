//
//  RootPageViewController.h
//  HWCollectionView
//
//  Created by Наталья on 10.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootPageViewController : UIViewController <UIPageViewControllerDataSource>



@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@end
