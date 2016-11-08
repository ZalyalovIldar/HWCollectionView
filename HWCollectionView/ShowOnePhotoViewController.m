//
//  ShowOnePhotoViewController.m
//  HWCollectionView
//
//  Created by Наталья on 07.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ShowOnePhotoViewController.h"
#import "ViewController.h"

@interface ShowOnePhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fullImage;


@end

@implementation ShowOnePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fullImage.image = self.image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

@end
