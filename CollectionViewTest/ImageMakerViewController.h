//
//  ImageMakerViewController.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 20.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"

@interface ImageMakerViewController : ScrollView
@property (weak, nonatomic) IBOutlet UIImageView *imageMakerImageView;
@property (weak, nonatomic) IBOutlet UITextField *textMakerForLabel;
- (IBAction)imageEditFirst:(id)sender;
- (IBAction)imageEditSecond:(id)sender;
- (IBAction)imageEditThird:(id)sender;

@property (strong, nonatomic) NSString *imageMakerImage;
@property (strong, nonatomic) NSString *imageMakerLabel;
@property NSInteger imageMakerIndexPath;

@end
