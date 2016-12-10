//
//  DataManager.h
//  HWCollectionView
//
//  Created by Наталья on 03.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface DataManager : NSObject

+ (instancetype)sharedInstance;
- (NSArray<User *> *)allUsersWithError:(out NSError **)error;
@end
