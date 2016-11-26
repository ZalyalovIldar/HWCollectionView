//
//  UserSettingTVC.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 26.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UserSettingTVC.h"
#import "UserSetting.h"


@interface UserSettingTVC ()
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userLoginField;
@property (weak, nonatomic) IBOutlet UITextField *userWEBSiteURLField;
@property (weak, nonatomic) IBOutlet UITextField *userInformation;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNumber;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) NSString * userAvatarName;
@end

@implementation UserSettingTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"SettingIsOpened"] == 2) {
        
    }
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userAvatarName = userSettingData.userAvatar;
    self.userAvatar.image = [UIImage imageNamed:_userAvatarName];
    self.userNameField.text = userSettingData.userName;
    self.userLoginField.text = userSettingData.userLogin;
    self.userInformation.text = userSettingData.userSay;
    self.userWEBSiteURLField.text = userSettingData.userWebSiteURL;
    self.userEmail.text = userSettingData.userEmail;
    
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
    self.userAvatar.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Data
-(void)saveUserData{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"SettingIsOpened"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UserSetting *userSettingsWrite = [UserSetting new];
    userSettingsWrite.userAvatar = _userAvatarName;
    userSettingsWrite.userName = self.userNameField.text;
    userSettingsWrite.userLogin = self.userLoginField.text;
    userSettingsWrite.userSay = self.userInformation.text;
    userSettingsWrite.userWebSiteURL = self.userWEBSiteURLField.text;
    userSettingsWrite.userEmail = self.userEmail.text;
    [UserSetting archiveData:userSettingsWrite];
}

- (IBAction)saveButtonAction:(id)sender {
    if ([self allFieldValidate]) {
        if ([[NSUserDefaults standardUserDefaults]integerForKey:@"SettingIsOpened"] == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //програмный переход в другой viewController
            UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"profileView"];
            [self presentViewController:moveToGeneral animated:YES completion:nil];
        }else{
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        [self saveUserData];
    }
}

- (IBAction)userAvatarChange:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select image" message:@"Select image for you profile" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cat" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        _userAvatarName = @"avatar1";
        self.userAvatar.image = [UIImage imageNamed:self.userAvatarName];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Hard Coder" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        _userAvatarName = @"avatar2";
        self.userAvatar.image = [UIImage imageNamed:self.userAvatarName];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Super pusher" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        _userAvatarName = @"avatar3";
        self.userAvatar.image = [UIImage imageNamed:self.userAvatarName];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action){
        _userAvatarName = @"avatarDefault";
        self.userAvatar.image = [UIImage imageNamed:self.userAvatarName];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}


#pragma mark - RegEX
-(BOOL)allFieldValidate{
    bool che = true;
    if (![UserSettingTVC emailValidate:self.userEmail.text]) {
        self.userEmail.backgroundColor = [UIColor redColor];
        che = false;
    }else{
        self.userEmail.backgroundColor = [UIColor clearColor];
    }
    if (self.userNameField.text.length == 0 || self.userNameField.text.length > 20){
        self.userNameField.backgroundColor = [UIColor redColor];
        che = false;
    }else{
        self.userNameField.backgroundColor = [UIColor clearColor];
    }
    if (self.userLoginField.text.length == 0 || self.userLoginField.text.length > 8){
        self.userLoginField.backgroundColor = [UIColor redColor];
        che = false;
    }else{
        self.userLoginField.backgroundColor = [UIColor clearColor];
    }
    if (!che) {
        [self errorAlert];
    }
    return che;
}
-(void)errorAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Correct you data" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* resultAlert = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:resultAlert];
    [self presentViewController:alert animated:YES completion:nil];
}

+ (BOOL)emailValidate:(NSString *)email {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:email];
}

@end
