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
    NSString *expression = @"[a-zA-Z0-9]+@(([a-zA-Z0-9\-]+\.)([a-zA-Z0-9\-])+)+";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *matchForMail = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if(matchForMail){
        return true;
    }
    return false;
}

+ (Boolean)checkName:(NSString*)str{
    NSString *expression = @"[a-zA-Zа-яА-Я]{0,30}";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *matchForMail = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if(matchForMail){
        return true;
    }
    return false;
}

+ (Boolean)checkPhone:(NSString*)str{
    NSString *expression = @"^[0-9\-\+]{9,15}$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *matchForMail = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if(matchForMail){
        return true;
    }
    return false;
}

+ (Boolean)checkUserName:(NSString*)str{
    return true;
}

@end
