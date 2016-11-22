//
//  ShowOnePhotoViewController.m
//  HWCollectionView
//
//  Created by Наталья on 07.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ShowOnePhotoViewController.h"
#import "ViewController.h"
#import "DataWorker.h"

@interface ShowOnePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *fullImage;


@property (weak, nonatomic) IBOutlet UILabel *commentLabel;



@end

@implementation ShowOnePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fullImage.image = [UIImage imageWithData:self.content.imageData];
    self.commentLabel.text = self.content.text;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeButtonDidClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Изменить" message:@"Что хотите изменить ?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *imageChangeAction = [UIAlertAction actionWithTitle:@"Изображение" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:picker animated:YES completion:nil];
        

    }];
    [alert addAction:imageChangeAction];
    
    UIAlertAction *labelTextChangeAction = [UIAlertAction actionWithTitle:@"Комментарий" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *changeLabelAlert = [UIAlertController alertControllerWithTitle:@"Изменить комментарий" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [changeLabelAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"new comment";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
#warning TODO fix add save to plist
        UIAlertAction *doneAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = changeLabelAlert.textFields.firstObject;
            self.content.text = textField.text;
            self.commentLabel.text = self.content.text;
            [[DataWorker sharedInstance] saveContent:self.content];
       }];

        
       UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:nil];
        
        [changeLabelAlert addAction:doneAlertAction];
        [changeLabelAlert addAction:cancelAlertAction];
        [self presentViewController:changeLabelAlert animated:YES completion:nil];
    }];
    UIAlertAction *mainCancelAlertAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:mainCancelAlertAction];
    [alert addAction:labelTextChangeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.8);
    self.content.imageData = imageData;
    [[DataWorker sharedInstance] saveContent:self.content];
    
    UIImage *photo = [UIImage imageWithData:imageData];
    self.fullImage.image = photo;
    
//    [_imageView setImage:photo];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




@end
