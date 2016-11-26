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


@interface SettingTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@end

static NSString *const visitSetting = @"filledAboutItself";

@implementation SettingTableViewController

@synthesize dataSource;
@synthesize pickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.clipsToBounds = YES;
    self.dataSource = [Data getSexArray];
    [self setTextIntoTextField];
    [self setImageAfterLaunch];
    [self firstLaunchSettings];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.sexPickerVisible = NO;
    [self firstLaunchSettings];
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
        saveSettings.sexNumber =(int)[pickerView selectedRowInComponent:0];
        [TableSettings archiveData:saveSettings];
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:visitSetting] isEqual:@"YES"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:visitSetting];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
            [self presentViewController:settingVC animated:YES completion:nil];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:visitSetting];
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

-(void)setTextIntoTextField{
    TableSettings *settings = (TableSettings*)[TableSettings unarchiveData];
    self.nameTextField.text = settings.name;
    self.usernameTextField.text = settings.username;
    self.webpageTextField.text = settings.webpage;
    self.emailTextField.text = settings.email;
    self.phoneNumberTextField.text = settings.phoneNumber;
    [pickerView selectRow:settings.sexNumber inComponent:0 animated:NO];
    self.sexLabel.text = self.dataSource[[pickerView selectedRowInComponent:0]];
}

-(void)setImageAfterLaunch{
    TableSettings *settings = (TableSettings*)[TableSettings unarchiveData];
    if(settings.userImageName==nil ||settings.userImageName==(id)[NSNull null]){
        self.userImageName = settings.userImageName = @"user";
    }else{
        self.userImageName = settings.userImageName;
    }
    self.userImageView.image = [UIImage imageNamed:self.userImageName];
}

-(void)firstLaunchSettings{
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:visitSetting] isEqual:@"YES"]){
        self.cancelButton.enabled=NO;
        
        self.cancelButton.tintColor=[UIColor clearColor];
        self.saveInfoButton.title=@"Сохранить";
    }
}

#pragma mark - resize for cell with picker view

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 3) {
        if (self.sexPickerVisible) {
            return 150;
        } else {
            return 0;
        }
    } else {
        return self.tableView.rowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        self.sexPickerVisible=!self.sexPickerVisible;
        pickerView.hidden =! self.sexPickerVisible;
        [UIView animateWithDuration:.3 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
    }
    else{
        pickerView.hidden = YES;
        self.sexPickerVisible=NO;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    [tableView reloadData];
}

#pragma mark - set to picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.sexLabel.text = self.dataSource[row];
}

@end
