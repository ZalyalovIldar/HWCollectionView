//
//  UserSettingVC.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 23.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UserSettingVC.h"
#import "UserSetting.h"

@interface UserSettingVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstSaveButton;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userLoginField;
@property (weak, nonatomic) IBOutlet UITextField *userWEBSiteURLField;
@property (weak, nonatomic) IBOutlet UITextField *userSayField;

@end

@implementation UserSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"SettingIsOpened"] == 2) {
        self.firstSaveButton.backgroundColor = [UIColor clearColor];
        self.firstSaveButton.tintColor = [UIColor clearColor];
        self.firstSaveButton.enabled = NO;
    }
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userNameField.text = userSettingData.userName;
    self.userLoginField.text = userSettingData.userLogin;
    self.userSayField.text = userSettingData.userSay;
    self.userWEBSiteURLField.text = userSettingData.userWebSiteURL;
    self.userEmail.text = userSettingData.userEmail;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"SettingIsOpened"] == 2) {
        _firstSaveButton = nil;
    }
    
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - User Data
-(void)saveUserData{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"SettingIsOpened"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UserSetting *userSettingsWrite = [UserSetting new];
    userSettingsWrite.userName = self.userNameField.text;
    userSettingsWrite.userLogin = self.userLoginField.text;
    userSettingsWrite.userSay = self.userSayField.text;
    userSettingsWrite.userWebSiteURL = self.userWEBSiteURLField.text;
    userSettingsWrite.userEmail = self.userEmail.text;
    [UserSetting archiveData:userSettingsWrite];
}

#pragma mark - Save Button
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

#pragma mark - RegEX
-(BOOL)allFieldValidate{
    bool che = true;
    if (![UserSettingVC emailValidate:self.userEmail.text]) {
        self.userEmail.backgroundColor = [UIColor redColor];
        che = false;
    }else{
        self.userEmail.backgroundColor = [UIColor clearColor];
    }
    if (self.userNameField.text.length == 0){
        self.userNameField.backgroundColor = [UIColor redColor];
        che = false;
    }else{
        self.userNameField.backgroundColor = [UIColor clearColor];
    }
    if (self.userLoginField.text.length == 0){
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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка заполнения" message:@"Введите данные корректно!" preferredStyle:UIAlertControllerStyleAlert];
    
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
