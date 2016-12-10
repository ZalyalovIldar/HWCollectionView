//
//  mainCustomTableViewCell.m
//  HWCollectionView
//
//  Created by Наталья on 03.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "MainCustomTableViewCell.h"
#import "ViewController.h"
#import "MainViewController.h"

@interface MainCustomTableViewCell()


@end

@implementation MainCustomTableViewCell


- (void)prepareForReuse {
    self.tapeImage.image = nil;
    self.profileNameLabel.text = nil;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
