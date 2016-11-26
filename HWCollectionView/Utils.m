//
//  Utils.m
//  HWCollectionView
//
//  Created by Rustam N on 24.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "Utils.h"




@implementation Utils



#pragma mark - NSRegularExpression
+ (Boolean)checkEmail:(NSString*)str{
    NSError *error = nil;
    NSString *expression = @"[a-zA-Z0-9]+@(([a-zA-Z0-9\-]+\.)([a-zA-Z0-9\-])+)+";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:0 error:&error];
    if ([regex rangeOfFirstMatchInString:str options:0 range:NSMakeRange(0, [str length])].location == NSNotFound) {
        return false;
    }
    return true;
    
}

+ (Boolean)checkName:(NSString*)str{
    NSError *error = nil;
    NSString *expression = @"[a-zA-Zа-яА-Я]+";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:0 error:&error];
    if ([regex rangeOfFirstMatchInString:str options:0 range:NSMakeRange(0, [str length])].location == NSNotFound) {
        return false;
    }
    return true;
}
+ (Boolean)checkUserName:(NSString*)str{
    return true;
}

@end
