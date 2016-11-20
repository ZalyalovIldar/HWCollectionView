//
//  ImageMakerViewController.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 20.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "ImageMakerViewController.h"

@interface ImageMakerViewController ()

@end

@implementation ImageMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageMakerName = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageMake"];
    NSLog(@"%@", _imageMakerName);
    self.imageMakerImage.image = [UIImage imageNamed:self.imageMakerName];
    self.textMakerForLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"labelMake"];
    // Do any additional setup after loading the view.
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

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
