//
//  SetEmailAndPhone.m
//  HWCollectionView
//
//  Created by Rustam N on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SetEmailAndPhone.h"
#import "Utils.h"
#import "EditSettingTabel.h"

@interface SetEmailAndPhone ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation SetEmailAndPhone

- (void)viewDidLoad {
    [super viewDidLoad];
        _textField.text = _phoneOrEmail;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    if(_key == 1){
        _textField.placeholder = @"you email";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneActionlButtonEmail)];
    }
    else{
        _textField.placeholder = @"you phone, exsample 88005553535, +78005553535";
        _textField.keyboardType = UIKeyboardTypePhonePad;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneActionlButtonPhone)];
    }
    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstStart"] isEqual:@"false"]){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}

#pragma mark - Buttons
- (void)doneActionlButtonEmail{
    if(_textField.text != _phoneOrEmail){
        if([Utils checkEmail: _textField.text]){
            //send new email
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self errorlAlert:@"Incorrect email" andMessage:@"Write the pone in the correct format."];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)doneActionlButtonPhone{
    if(_textField.text != _phoneOrEmail){
        if([Utils checkPhone: _textField.text]){
            //send new phone
     
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self errorlAlert:@"Incorrect phone" andMessage:@"Write the phone in the correct format."];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)cancelButton{
    if(_textField.text != _phoneOrEmail){
        [self cancelAlert];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Alerts
- (void)cancelAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unsaved changes" message:@"You have unsaved changes. Are you sure want to cancel?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAlertAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    UIAlertAction *yesAlertAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self.navigationController popViewControllerAnimated:YES];
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


@end
