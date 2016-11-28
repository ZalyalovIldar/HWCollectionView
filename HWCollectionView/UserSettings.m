//
//  UserSettings.m
//  HWCollectionView
//
//  Created by Rustam N on 25.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(!self){
        return nil;
    }
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.website = [aDecoder decodeObjectForKey:@"website"];
    self.bio = [aDecoder decodeObjectForKey:@"bio"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.phine = [aDecoder decodeObjectForKey:@"phine"];
    self.gender = [aDecoder decodeObjectForKey:@"gender"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.website forKey:@"website"];
    [aCoder encodeObject:self.bio forKey:@"bio"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.phine forKey:@"phine"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
}

+ (void)archiveUserSettings:(UserSettings*)setting{
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:setting];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:@"userSettings"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray*)unarchiveUserSettings{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSettings"];
    NSArray *userArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userArr;
}
@end
