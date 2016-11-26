//
//  UserSetting.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 23.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UserSetting.h"

@implementation UserSetting

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userAvatar forKey:@"userAvatar"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userLogin forKey:@"userLogin"];
    [aCoder encodeObject:self.userSay forKey:@"userSay"];
    [aCoder encodeObject:self.userWebSiteURL forKey:@"userWebSiteURL"];
    [aCoder encodeObject:self.userEmail forKey:@"userEmail"];
    [aCoder encodeObject:self.userPhone forKey:@"userPhone"];
    [aCoder encodeObject:self.userSex forKey:@"userSex"];
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.userAvatar = [aDecoder decodeObjectForKey:@"userAvatar"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.userLogin = [aDecoder decodeObjectForKey:@"userLogin"];
    self.userSay = [aDecoder decodeObjectForKey:@"userSay"];
    self.userWebSiteURL = [aDecoder decodeObjectForKey:@"userWebSiteURL"];
    self.userEmail = [aDecoder decodeObjectForKey:@"userEmail"];
    self.userPhone = [aDecoder decodeObjectForKey:@"userPhone"];
    self.userSex = [aDecoder decodeObjectForKey:@"userSex"];
    
    return self;
}

+(void)archiveData:(UserSetting *)userSetting{
    NSData * archiveData = [NSKeyedArchiver archivedDataWithRootObject:userSetting];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:@"userSetting"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)unarchiveData{
    NSData *unarchiveData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSetting"];
    NSArray *userData = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    return userData;
}

@end
