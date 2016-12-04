//
//  ImageMakerViewController.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 20.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "ImageMakerViewController.h"
#import "ProfileView.h"

@interface ImageMakerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ImageMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Navigation Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    //import from first VC
    self.imageMakerImageView.image = [UIImage imageNamed:_imageMakerImage];
    self.textMakerForLabel.text = _imageMakerLabel;

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button action
-(void)save{
    //[_imageMakerImage insertObject: atIndex:_imageMakerIndexPath]; //вставить сюда изображение которое будет поменяно
    profileView *profileVC = [[profileView alloc]init];
    [profileVC dataChangeImage:_imageMakerImage andIndexPath:(int)_imageMakerIndexPath];
    [profileVC dataChangeLabel:_textMakerForLabel.text andIndexPath:(int)_imageMakerIndexPath];
    [self.navigationController popViewControllerAnimated:YES];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *gotImage = info[UIImagePickerControllerOriginalImage];
    self.imageMakerImageView.image = gotImage;
}

-(void)imageChange{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)imageEditFirst:(id)sender {
    _imageMakerImage = @"8";
    [self imageChange];
    self.imageMakerImageView.image = [UIImage imageNamed:@"8"];
}

- (IBAction)imageEditSecond:(id)sender {
    _imageMakerImage = @"2";
    self.imageMakerImageView.image = [UIImage imageNamed:@"2"];
}

- (IBAction)imageEditThird:(id)sender {
    _imageMakerImage = @"5";
    self.imageMakerImageView.image = [UIImage imageNamed:@"5"];
}
@end
