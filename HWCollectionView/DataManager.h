//
//  DataManager.h
//  HWCollectionView
//
//  Created by Ленар on 30.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataManager : NSObject

+ (instancetype)sharedInstance;
- (void)creatTable;
- (void)addRowToUserTableWithName:(NSString*)name andUserName:(NSString*)username andUserImageName:(NSString*)userImageName;
- (void)addValuesFromArray;
-(void)dropTable;
- (NSArray*)getUsersArrFromDataBase;
- (NSArray*)getUserControllerWithUsername:(NSString*)username;

@end
