//
//  SettingsTableViewCell.m
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SettingsTableViewCell.h"
#import "SettinsCellModel.h"
@interface SettingsTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) SettinsCellModel *cellModel;

@end
@implementation SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configWithModel:(SettinsCellModel *)cellModel andIndexPath:(NSIndexPath *)indexPath 
{
    self.textField.placeholder = cellModel.name;
    self.cellModel = cellModel;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.cellModel.value = textField.text;
}

@end
