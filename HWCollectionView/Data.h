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
-(NSArray*)replaceCommentOfString:(NSString*)comment fromRow:(NSInteger)numberRow;
-(NSArray*)replaceImageWithName:(NSString*)imageName fromRow:(NSInteger)numberRow;
-(void)writeDataToFileImageArray:(NSArray*)imageArray andCommentArray:(NSArray*)commentArray;
-(NSString*)getImageName:(UIImageView*)imageView;
-(void)createImageFromData:(NSData*)data withName:(NSString*)name;
+(int)whatUserNotVisited;
+(NSArray*)getSexArray;

@end
