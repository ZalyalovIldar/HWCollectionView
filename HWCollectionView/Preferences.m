//
//  Preferences.m
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "Preferences.h"
NSString *const IPProfileImageDataKey = @"ip_imageData";
NSString *const IPNameKey = @"ip_name";
NSString *const IPNikNameKey = @"ip_nikName";
NSString *const IPWebPageKey = @"ip_webpage";
NSString *const IPAboutKey = @"ip_about";
NSString *const IPEmailKey = @"ip_email";
NSString *const IPPhoneNumberKey = @"ip_phonenumber";
NSString *const IPSexKey = @"ip_sex";

@implementation Preferences
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.profileImageData = [decoder decodeObjectForKey:IPProfileImageDataKey];
    self.name = [decoder decodeObjectForKey:IPNameKey];
    self.nikName = [decoder decodeObjectForKey:IPNikNameKey];
    self.webPage = [decoder decodeObjectForKey:IPWebPageKey];
    self.about = [decoder decodeObjectForKey:IPAboutKey];
    self.email = [decoder decodeObjectForKey:IPEmailKey];
    self.phoneNumber = [decoder decodeObjectForKey:IPPhoneNumberKey];
    self.sex = [decoder decodeObjectForKey:IPSexKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.profileImageData forKey:IPProfileImageDataKey];
    [encoder encodeObject:self.name forKey:IPNameKey];
    [encoder encodeObject:self.nikName forKey:IPNikNameKey];
    [encoder encodeObject:self.webPage forKey:IPWebPageKey];
    [encoder encodeObject:self.about forKey:IPAboutKey];
    [encoder encodeObject:self.email forKey:IPEmailKey];
    [encoder encodeObject:self.phoneNumber forKey:IPPhoneNumberKey];
    [encoder encodeObject:self.sex forKey:IPSexKey];
}


@end
