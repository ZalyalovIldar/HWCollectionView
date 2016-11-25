//
//  UserSetting.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 23.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetting : NSObject <NSCoding>

@property (strong, nonatomic) NSString *userAvatar;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userLogin;
@property (strong, nonatomic) NSString *userWebSiteURL;
@property (strong, nonatomic) NSString *userSay;
@property (strong, nonatomic) NSString *userEmail;

+(void)archiveData:(UserSetting *)userSetting;
+(NSArray*)unarchiveData;

@end
