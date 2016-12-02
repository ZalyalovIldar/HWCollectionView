//
//  HistoryCVCell.m
//  HWCollectionView
//
//  Created by Ленар on 30.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "HistoryCVCell.h"

@implementation HistoryCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
}

@end
