//
//  ViewController.h
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCellViewController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) SingleCellViewController *helpCellVC;

-(void)readData;
-(void)writeDataToFile:(NSString*)fileName;


@end

