//
//  SettingTableViewController.m
//  HWCollectionView
//
//  Created by Ленар on 23.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SettingTableViewController.h"
#import "TableSettings.h"
#import <Photos/Photos.h>
#import "Data.h"


@interface SettingTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;

    TableSettings *settings = (TableSettings*)[TableSettings unarchiveData];
    self.nameTextField.text = settings.name;
    self.usernameTextField.text = settings.username;
    self.webpageTextField.text = settings.webpage;
    self.emailTextField.text = settings.email;
    self.phoneNumberTextField.text = settings.phoneNumber;
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"filledAboutItself"] isEqual:@"YES"]){
        self.cancelButton.enabled=NO;
        
        self.cancelButton.tintColor=[UIColor clearColor];
        self.saveInfoButton.title=@"Сохранить";
    }
    if(settings.userImageName==nil ||settings.userImageName==(id)[NSNull null]){
        self.userImageName = @"user";
        settings.userImageName = @"user";
    }else{
        self.userImageName = settings.userImageName;
    }
    self.userImageView.image = [UIImage imageNamed:self.userImageName];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    TableSettings *settings = (TableSettings*)[TableSettings unarchiveData];
    self.nameTextField.text = settings.name;
    self.usernameTextField.text = settings.username;
    self.webpageTextField.text = settings.webpage;
    self.emailTextField.text = settings.email;
    self.phoneNumberTextField.text = settings.phoneNumber;
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"filledAboutItself"] isEqual:@"YES"]){
        self.cancelButton.enabled=YES;
        self.cancelButton.tintColor=[UIColor darkGrayColor];
    }
}

#pragma mark - navigation controller and save info

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveInfoButton:(id)sender {
    self.correctInfo = YES;
    NSString *expressionForMail = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSError *error = NULL;
    NSString *errorString = @"";
    NSRegularExpression *regexForMail = [NSRegularExpression regularExpressionWithPattern:expressionForMail options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *matchForMail = [regexForMail firstMatchInString:self.emailTextField.text options:0 range:NSMakeRange(0, [self.emailTextField.text length])];
    if([self.nameTextField.text isEqual:@""]){
        errorString = @"Имя";
        self.correctInfo = NO;
    }else if([self.usernameTextField.text isEqual:@""]||self.usernameTextField.text.length>10){
        errorString = @"Имя пользователя";
        self.correctInfo = NO;
    }else if([self.emailTextField.text isEqual:@""]||!matchForMail){
        errorString = @"Эл.почта";
        self.correctInfo = NO;
    }else if([self.phoneNumberTextField.text isEqual:@""]||!(self.phoneNumberTextField.text.length==11||self.phoneNumberTextField.text.length==12)){
        errorString = @"Телефон";
        self.correctInfo = NO;
    }
    if(![errorString isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:[NSString stringWithFormat:@"Необходимо корректно заполнить поле '%@'",errorString] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        self.correctInfo = NO;
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (self.correctInfo!=NO) {
        TableSettings *saveSettings = [TableSettings new];
        saveSettings.userImageName = self.userImageName;
        saveSettings.name = self.nameTextField.text;
        saveSettings.username = self.usernameTextField.text;
        saveSettings.webpage = self.webpageTextField.text;
        saveSettings.email = self.emailTextField.text;
        saveSettings.phoneNumber = self.phoneNumberTextField.text;
        [TableSettings archiveData:saveSettings];
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"filledAboutItself"] isEqual:@"YES"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"filledAboutItself"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
            [self presentViewController:settingVC animated:YES completion:nil];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"filledAboutItself"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
#pragma mark - changeUserImage
- (IBAction)changeUserPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//работает правильно
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[refURL] options:nil];
    NSString *imageName = [[result firstObject] filename];
    Data *data = [Data new];
    NSData *imageData = UIImagePNGRepresentation([info valueForKey:UIImagePickerControllerOriginalImage]);
    [data createImageFromData:imageData withName:imageName];
    self.userImageView.image = [UIImage imageNamed:imageName];
    self.userImageName = imageName;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
