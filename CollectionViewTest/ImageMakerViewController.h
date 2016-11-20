//
//  ImageMakerViewController.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 20.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMakerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageMakerImage;
- (IBAction)closeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textMakerForLabel;
@property (strong, nonatomic) NSString *imageMakerName;

@end
