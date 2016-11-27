//
//  SettinsCellModel.m
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SettinsCellModel.h"

@implementation SettinsCellModel

- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value format:(kCellFormat)format key:(NSString *)key
{
    self = [super init];
    if (self) {
        self.name = name;
        self.format = format;
        self.value = value;
        self.key = key;
    }
    return self;
}


@end
