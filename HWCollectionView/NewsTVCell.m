//
//  NewsTVCell.m
//  HWCollectionView
//
//  Created by Ленар on 01.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "NewsTVCell.h"
#import "NewsTVC.h"

@implementation NewsTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
