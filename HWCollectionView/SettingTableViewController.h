//
//  SettingTableViewController.h
//  HWCollectionView
//
//  Created by Ленар on 23.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *webpageTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveInfoButton;
@property (nonatomic)BOOL correctInfo;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic)NSString *userImageName;

@end
