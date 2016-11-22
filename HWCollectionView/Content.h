//
//  Content.h
//  HWCollectionView
//
//  Created by Наталья on 21.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const ICImageDataKey;
extern NSString * const ICTextKey;
extern NSString * const ICIdKey;

@interface Content : NSObject

@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *text;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
