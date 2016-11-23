//
//  PageContentViewController.h
//  HWCollectionView
//
//  Created by Rustam N on 12.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property NSUInteger pageIndex;
@property NSString *imageFile;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
