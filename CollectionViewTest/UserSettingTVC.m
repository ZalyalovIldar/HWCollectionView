//
//  UserSettingTVC.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 26.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UserSettingTVC.h"
#import "UserSetting.h"


@interface UserSettingTVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userLoginField;
@property (weak, nonatomic) IBOutlet UITextField *userWEBSiteURLField;
@property (weak, nonatomic) IBOutlet UITextField *userInformation;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNumber;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIPickerView *sexPicker;

@property (strong, nonatomic) NSDictionary *infoDictionary;
@property (strong, nonatomic) NSString * userAvatarName;
@property (strong, nonatomic) NSString * sexSelected;
@property (strong, nonatomic) NSArray * sexArr;
@end

@implementation UserSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _sexArr = @[@"Male",@"Female"];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"SettingIsOpened"] == 2) {
        
    }
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userAvatar.image = [self loadImage];
    self.userNameField.text = userSettingData.userName;
    self.userLoginField.text = userSettingData.userLogin;
    self.userInformation.text = userSettingData.userSay;
    self.userWEBSiteURLField.text = userSettingData.userWebSiteURL;
    self.userEmail.text = userSettingData.userEmail;
    
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
    self.userAvatar.clipsToBounds = YES;
    
    _sexPicker.delegate = self;
    _sexPicker.dataSource = self;
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
    //userSettingsWrite.userAvatar = _userAvatarName;
    userSettingsWrite.userName = self.userNameField.text;
    userSettingsWrite.userLogin = self.userLoginField.text;
    userSettingsWrite.userSay = self.userInformation.text;
    userSettingsWrite.userWebSiteURL = self.userWEBSiteURLField.text;
    userSettingsWrite.userEmail = self.userEmail.text;
    userSettingsWrite.userSex = self.sexSelected;
    [UserSetting archiveData:userSettingsWrite];
    [self savePhoto];
}

- (IBAction)saveButtonAction:(id)sender {
    if ([self allFieldValidate]) {
        if ([[NSUserDefaults standardUserDefaults]integerForKey:@"SettingIsOpened"] == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"ProfileView");
            UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //програмный переход в другой viewController
            UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"profileView"];
            [self presentViewController:moveToGeneral animated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self saveUserData];
    }
}

- (IBAction)userAvatarChange:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New avatar photo" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Image from camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:@"Image from library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:takePhotoAction];
    [alert addAction:choosePhotoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _userAvatar.image = info[UIImagePickerControllerEditedImage];
    _infoDictionary = info;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)savePhoto{
    if(_infoDictionary != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"photo.png"];
        NSString *mediaType = [_infoDictionary objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]){
            UIImage *editedImage = [_infoDictionary objectForKey:UIImagePickerControllerEditedImage];
            NSData *data = UIImagePNGRepresentation(editedImage);
            [data writeToFile:imagePath atomically:YES];
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(UIImage*)loadImage{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[path stringByAppendingPathComponent:@"photo.png"];
    UIImageView *myimage=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    myimage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    return myimage.image;
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
    if (self.userLoginField.text.length == 0 || self.userLoginField.text.length > 10){
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
#pragma mark - Picker

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _sexSelected = [_sexArr objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _sexArr.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _sexArr[row];
}

@end

