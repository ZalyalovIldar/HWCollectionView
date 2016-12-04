//
//  HistoryDataModel.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface HistoryDataModel : NSObject

@property(nonatomic) NSUInteger userId;
@property(nonatomic, strong) NSString * userAvatarImage;
@property(nonatomic, strong) NSString * userSay;
@property(nonatomic, strong) NSString * userName;
@property(nonatomic, strong) NSString * name;
@property(nonatomic, strong) NSMutableArray * postImageName;

-(instancetype)initWithResultSet:(FMResultSet *)resultSetUsers and:(FMResultSet *)resultSetPosts;

@end
