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
@interface Content()

@property (nonatomic, strong) NSString *imageName;

@end
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

    self.imageData = dictionary[ICImageDataKey];
    return self;
}

- (NSDictionary *)dictionaryFromObject
{
    return @{ICIdKey : @(self.id), ICImageDataKey : self.imageData, ICTextKey : self.text};
}

@end
