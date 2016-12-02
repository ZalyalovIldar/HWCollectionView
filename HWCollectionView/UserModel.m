//
//  UserModel.m
//  HWCollectionView
//
//  Created by Ленар on 02.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithResultSetFromUsers:(FMResultSet*)resultSetUsers andResultSetFromPosts:(FMResultSet*)resultSetPosts
{
    self = [super init];
    if (self) {
        _userId = [resultSetUsers longForColumn:@"id"];
        _name = [resultSetUsers stringForColumn:@"name"];
        _username = [resultSetUsers stringForColumn:@"username"];
        _userImageName = [resultSetUsers stringForColumn:@"userImageName"];
        _postImageName = [NSMutableArray new];
        while (resultSetPosts.next) {
            [_postImageName addObject:[resultSetPosts stringForColumn:@"postImageName"]];
        }
    }
    return self;
}

@end
