//
//  UserSettingTVC.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 26.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSettingTVC : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource>

- (IBAction)userAvatarChange:(id)sender;
- (IBAction)saveButtonAction:(id)sender;

@end
