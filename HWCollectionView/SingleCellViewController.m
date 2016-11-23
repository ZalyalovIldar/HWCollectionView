//
//  SingleCellViewController.m
//  HWCollectionView
//
//  Created by Хариго on 22.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SingleCellViewController.h"

@interface SingleCellViewController ()
@property (nonatomic, weak, readwrite) IBOutlet UIImageView *imageView;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *textLabel;

@end

@implementation SingleCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageView:(UIImage *)image {
    _imageView.image = image;
}

-(void)setTextLabel:(NSString *)text {
    _textLabel.text = text;
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
