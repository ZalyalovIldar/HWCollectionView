//
//  PageContentViewController.m
//  HWCollectionView
//
//  Created by Rustam N on 12.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
}


@end
