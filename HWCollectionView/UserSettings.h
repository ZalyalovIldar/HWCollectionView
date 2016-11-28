//
//  UserSettings.h
//  HWCollectionView
//
//  Created by Rustam N on 25.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettings : NSObject <NSCoding>
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *userName;
@property(strong, nonatomic) NSString *website;
@property(strong, nonatomic) NSString *bio;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *phine;
@property (strong, nonatomic) NSString* gender;

+ (void)archiveUserSettings:(UserSettings*)setting;
+ (NSArray*)unarchiveUserSettings;

@end
