//
//  SettingsTableViewCell.h
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettinsCellModel.h"


@interface SettingsTableViewCell : UITableViewCell
- (void) configWithModel:(SettinsCellModel *)cellModel andIndexPath:(NSIndexPath *)indexPath;
@end
