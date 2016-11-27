//
//  EditSettingTabel.m
//  HWCollectionView
//
//  Created by Rustam N on 23.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "EditSettingTabel.h"
#import "Utils.h"
#import "UserSettings.h"
#import "SetEmailAndPhone.h"



@interface EditSettingTabel() <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *changePhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *wrbsiteTextField;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profilPhoto;
@property (strong, nonatomic) NSDictionary *infoImage;
@property (weak, nonatomic) IBOutlet UILabel *gendorLabel;

@property (nonatomic) BOOL isVisibalPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation EditSettingTabel

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    _picker.delegate = self;
    _picker.dataSource = self;
    _isVisibalPicker = false;
    
    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstStart"] isEqual:@"false"]){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveActionlButton)];
        _gendorLabel.text = @"Not Specified";
    }
    else{
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(canceActionlButton)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneActionlButton)];
        [self getSettings];
    }
    _profilPhoto.image = [self loadImage];
    _profilPhoto.clipsToBounds = true;
    _profilPhoto.layer.cornerRadius = _profilPhoto.frame.size.height/2;
}


#pragma mark - Work With Photo
- (IBAction)chengePhotoButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Chanhe Profile Photo" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:@"Choose From Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
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
    _profilPhoto.image = info[UIImagePickerControllerEditedImage];
    _infoImage = info;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)savePhoto{
    if(_infoImage != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"photo.png"];
        NSString *mediaType = [_infoImage objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]){
            UIImage *editedImage = [_infoImage objectForKey:UIImagePickerControllerEditedImage];
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
#pragma mark - Header Buttons
- (void)doneActionlButton{
    if([self isChangeAnything]){
        if(![_emailLabel.text  isEqual: @""]){
            if([Utils checkName: _nameTextField.text]){
                [self saveSettings];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                [self errorlAlert:@"Incorrect name format" andMessage:@"Write the name in the correct format."];
            }
        }
        else{
            [self errorlAlert:@"You have not added the mail" andMessage:@"Add email."];
        }
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)canceActionlButton{
    if([self isChangeAnything]){
        [self cancelAlert];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)saveActionlButton{
    if(![_emailLabel.text  isEqual: @""]){
        if([Utils checkName: _nameTextField.text]){
            [self saveSettings];
            [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"firstStart"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [self errorlAlert:@"Incorrect name format" andMessage:@"Write the name in the correct format."];
        }
    }
    else{
        [self errorlAlert:@"You have not added the mail" andMessage:@"Add email."];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 4;
        case 2:
            if(_isVisibalPicker){
                return 4;
            }
            return 3;
    }
    return 0;
}

#pragma mark - Utils
- (void)cancelAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unsaved changes" message:@"You have unsaved changes. Are you sure want to cancel?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAlertAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    UIAlertAction *yesAlertAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:noAlertAction];
    [alert addAction:yesAlertAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)errorlAlert:(NSString*)header andMessage:(NSString*)messgae{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:messgae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAlertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){}];
    [alert addAction:noAlertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveSettings{
    UserSettings *userSettings = [UserSettings new];
    userSettings.name =  _nameTextField.text;
    userSettings.userName = _userNameTextField.text;
    userSettings.website = _wrbsiteTextField.text;
    userSettings.bio =  _bioTextField.text;
    userSettings.email =  @"ss@dsa";//
    userSettings.phine =  @"877";//
    userSettings.gender =  _gendorLabel.text;
    [self savePhoto];
    
    if([_userNameTextField.text isEqual: @""]){
        [self errorlAlert:@"Not chosen username or e-mail" andMessage:@"Please  choose required fields."];
    }
    else{
    [UserSettings archiveUserSettings:userSettings];
    }
}
- (void)getSettings{
    UserSettings *userSettings = (UserSettings*)[UserSettings unarchiveUserSettings];
    _nameTextField.text = userSettings.name;
    _userNameTextField.text = userSettings.userName;
    _wrbsiteTextField.text = userSettings.website;
    _bioTextField.text = userSettings.bio;
    _emailLabel.text = userSettings.email;
    _phoneLabel.text = userSettings.phine;
    _gendorLabel.text = userSettings.gender;
}
- (BOOL)isChangeAnything{
    UserSettings *userSettings = [UserSettings new];
    if(userSettings.name !=  _nameTextField.text || userSettings.userName != _userNameTextField.text || userSettings.website != _wrbsiteTextField.text || userSettings.bio !=  _bioTextField.text || userSettings.email != _emailLabel.text || userSettings.phine != _phoneLabel.text ||  userSettings.gender != _gendorLabel.text){
        return true;
    }
    return false;
}

#pragma mark - phone and email
- (IBAction)setEmailOrPhone:(id)sender {
    SetEmailAndPhone *setEmailAndPhone = [self.storyboard instantiateViewControllerWithIdentifier:@"SetEmailOrPhone"];
    setEmailAndPhone.key = (int)[sender tag];
    if((int)[sender tag] == 1){
        setEmailAndPhone.phoneOrEmail = _emailLabel.text;
    }
    else{
        setEmailAndPhone.phoneOrEmail = _phoneLabel.text;
    }
    [self.navigationController pushViewController:setEmailAndPhone animated:YES];
}

#pragma mark - Gendor Picker
- (IBAction)chengeGendor:(id)sender {
    if(!_isVisibalPicker){
        _isVisibalPicker = true;
    }
    else{
        _isVisibalPicker = false;
    }
    [self.tableView reloadData];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch(row) {
        case 0:
            title = @"Not Specified";
            _gendorLabel.text = @"Not Specified";
            break;
        case 1:
            title = @"Male";
            _gendorLabel.text = @"Male";
            break;
        case 2:
            title = @"Female";
            _gendorLabel.text = @"Female";
            break;
    }
    return title;
}

@end
