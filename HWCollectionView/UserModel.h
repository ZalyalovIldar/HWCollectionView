//
//  UserModel.h
//  HWCollectionView
//
//  Created by Ленар on 02.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface UserModel : NSObject

@property (nonatomic) NSUInteger userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *userImageName;
@property (strong, nonatomic) NSMutableArray *postImageName;

- (instancetype)initWithResultSetFromUsers:(FMResultSet*)resultSetUsers andResultSetFromPosts:(FMResultSet*)resultSetPosts;

@end
