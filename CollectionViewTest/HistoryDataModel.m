//
//  HistoryDataModel.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "HistoryDataModel.h"


@implementation HistoryDataModel

-(instancetype)initWithResultSet:(FMResultSet *)resultSetUsers and:(FMResultSet *)resultSetPosts{
    self = [super init];
    if(self){
        _userId = [resultSetUsers longForColumn:@"id"];
        _userAvatarImage = [resultSetUsers stringForColumn:@"userAvatarImage"];
        _userSay = [resultSetUsers stringForColumn:@"userSay"];
        _userName = [resultSetUsers stringForColumn:@"userName"];
        _name = [resultSetUsers stringForColumn:@"name"];
        _postImageName = [NSMutableArray new];
        while (resultSetPosts.next) {
            [_postImageName addObject:[resultSetPosts stringForColumn:@"postImageName"]];
        }
        //_postImageName = [resultSet stringForColumn:@"postImageName"];
    }
    return self;
}

@end
