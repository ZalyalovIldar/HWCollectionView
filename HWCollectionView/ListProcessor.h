//
//  ListProcessor.h
//  HWCollectionView
//
//  Created by Rustam N on 20.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListProcessor : NSObject

- (void)setImage:(int)index andImageName:(NSString*)image;
- (void)setLabelText:(int)index andText:(NSString*)text;
- (void)add:(NSString*)image andText:(NSString*)text;
- (void)delete:(int)index;
- (void)firsLoad;
- (NSMutableArray*)getLabelsArray;
- (NSMutableArray*)getImageArray;
- (NSString*)getImageName:(int)index;
- (NSString*)getLabelText:(int)index;
- (NSArray*)getAllImageArray;


@end
