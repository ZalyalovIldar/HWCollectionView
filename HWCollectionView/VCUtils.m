//
//  VCUtils.m
//  HWCollectionView
//
//  Created by Rustam N on 24.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "VCUtils.h"

@interface VCUtils ()

@end

@implementation VCUtils

- (UIAlertController*)cancelAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unsaved changes" message:@"You have unsaved changes. Are you sure want to cancel?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAlertAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"no");
    }];
    UIAlertAction *yesAlertAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                NSLog(@"yes");
      
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:noAlertAction];
    [alert addAction:yesAlertAction];
    return alert;
   }
@end
