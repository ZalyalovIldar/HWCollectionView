//
//  WatchPostVC.m
//  HWCollectionView
//
//  Created by Ленар on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "WatchPostVC.h"
#import "Data.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface WatchPostVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation WatchPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]initWithTitle:@"Изменить" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    self.navigationItem.rightBarButtonItem = edit;
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width/2;
    self.userPhoto.clipsToBounds = YES;
    self.postImageView.image = [UIImage imageNamed:self.imageNameString];
    self.commentLabel.text = self.commentString;
}
#pragma mark - alert to change
-(void)showAlert{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Изменить" message:@"Что хотите изменить?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *changeImage = [UIAlertAction actionWithTitle:@"Изображение" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *changeComment = [UIAlertAction actionWithTitle:@"Комментарий" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIAlertController *alertForChangeComment = [UIAlertController alertControllerWithTitle:@"Изменение комментария" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertForChangeComment addTextFieldWithConfigurationHandler:^(UITextField *textField){
         textField.placeholder = @"Комментарий";
        }];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       UITextField *comment = alertForChangeComment.textFields.firstObject;
                                       self.commentLabel.text = self.commentString = comment.text;
                                       Data *data = [[Data alloc]init];
                                       NSLog(@"%@",[data getCommentArray]);
                                       [data writeDataToFileImageArray:[data getImageNameArray] andCommentArray:[data replaceCommentOfString:comment.text fromRow:self.numberOfRow]];
                                       NSLog(@"%@",[data getCommentArray]);
                                   }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:nil];
        [alertForChangeComment addAction:okAction];
        [alertForChangeComment addAction:cancelAction];
        [self presentViewController:alertForChangeComment animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:changeImage];
    [alert addAction:changeComment];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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
    self.postImageView.image = [UIImage imageNamed:imageName];
    NSLog(@"%@",[data getImageNameArray]);
    [data writeDataToFileImageArray:[data replaceImageWithName:imageName fromRow:self.numberOfRow] andCommentArray:[data getCommentArray]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
