//
//  Content.m
//  HWCollectionView
//
//  Created by Наталья on 21.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "Content.h"
NSString * const ICImageDataKey = @"ic_imageData";
NSString * const ICTextKey = @"ic_text";
NSString * const ICIdKey = @"ic_id";

@implementation Content

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    
    self.text = dictionary[ICTextKey];
    self.id = [dictionary[ICIdKey] integerValue];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:dictionary[ICImageDataKey] ofType: nil];
    self.imageData = [NSData dataWithContentsOfFile:imagePath];
    return self;
}

@end
