//
//  ImageMakerViewController.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 20.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "ImageMakerViewController.h"
#import "ProfileView.h"

@interface ImageMakerViewController ()

@end

@implementation ImageMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Navigation Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    //import from first VC
    self.imageMakerImageView.image = [UIImage imageNamed:[_imageMakerImage objectAtIndex:self.imageMakerIndexPath]];
    self.textMakerForLabel.text = [_imageMakerLabel objectAtIndex:self.imageMakerIndexPath];

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
    [profileVC dataChangeImage:@"" andIndexPath:(int)_imageMakerIndexPath];
   // [self.imageMakerLabel replaceObjectAtIndex:_imageMakerIndexPath withObject:_textMakerForLabel.text];

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

@end
