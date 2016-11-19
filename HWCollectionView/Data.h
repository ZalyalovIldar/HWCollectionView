//
//  Data.h
//  HWCollectionView
//
//  Created by Ленар on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Data : UIView

@property(strong, nonatomic)NSMutableArray* commentArray;
@property(strong,nonatomic)NSMutableArray* imageNameArray;
-(NSMutableArray*)getImageNameArray;
-(NSMutableArray*)getCommentArray;

@end
