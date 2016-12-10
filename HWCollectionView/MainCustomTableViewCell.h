//
//  mainCustomTableViewCell.h
//  HWCollectionView
//
//  Created by Наталья on 03.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *profileNameButton;
@property (weak, nonatomic) IBOutlet UIImageView *tapeImage;
@end
