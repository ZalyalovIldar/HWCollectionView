//
//  TableSettings.m
//  HWCollectionView
//
//  Created by Ленар on 23.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "TableSettings.h"

static NSString *const tableSetting = @"tabelSetting";

@implementation TableSettings

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.username = [aDecoder decodeObjectForKey:@"username"];
    self.webpage = [aDecoder decodeObjectForKey:@"webpage"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.phoneNumber = [aDecoder decodeObjectForKey:@"phone"];
    self.userImageName = [aDecoder decodeObjectForKey:@"userImage"];
    self.sexNumber = [aDecoder decodeIntForKey:@"sex"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.webpage forKey:@"webpage"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phone"];
    [aCoder encodeObject:self.userImageName forKey:@"userImage"];
    [aCoder encodeInt:self.sexNumber forKey:@"sex"];
}

+(void)archiveData:(TableSettings*)tabelSettings{
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:tabelSettings];
    [[NSUserDefaults standardUserDefaults] setObject:saveData forKey:tableSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)unarchiveData{
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:tableSetting];
    NSArray *userData = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    return userData;
}

@end
