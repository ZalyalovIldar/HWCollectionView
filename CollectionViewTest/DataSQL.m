//
//  DataSQL.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "DataSQL.h"
#import "HistoryDataModel.h"

@implementation DataSQL
{
    FMDatabase *dataBase;
}

+(instancetype)sharedInstance{
    static id _singleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleTon = [[self alloc]init];
    });
    return _singleTon;
}

- (instancetype)init{
    self = [super init];
    if (self){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [docPath stringByAppendingPathComponent:@"sqLiteDb.sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
        [dataBase open];
        NSLog(@"%@", path);
    }
    return self;
}

-(void)createTable{
    NSString *sqlRequestUserTable = @"create table IF NOT EXISTS Users (id integer PRIMARY KEY AUTOINCREMENT, userAvatarImage text , userSay text, userName text, name text);";
    NSString *sqlRequestPostTable = @"create table IF NOT EXISTS Posts (user_id integer PRIMARY KEY AUTOINCREMENT, postImageName text);"; //FK-PK
    @try {
        [dataBase executeUpdate:sqlRequestUserTable];
        [dataBase executeUpdate:sqlRequestPostTable];
    } @catch (NSException *exception) {
        NSLog(@"Request failed: %@", exception);
    }
}

-(void)addNewRow{
    NSString *insertQuery = @"INSERT INTO Users (userAvatarImage, userSay, userName, name) values ('avatar1', 'Hello!', 'Henry','kekik');";
    @try {
        [dataBase executeQuery:insertQuery];
    } @catch (NSException *exception) {
        NSLog(@"Request failed: %@", exception);
    }
    
    FMResultSet *resSet = [dataBase executeQuery:@"select count(*) from Users"];
    while (resSet.next) {
        NSLog(@"%ld", [resSet longForColumn:0]);
    }
}

-(void)addValuesFromArr{
    NSArray *dataArr = [self getDataFomPlist];
    
    for (NSDictionary *dict in dataArr) {
        @try {
            [dataBase executeUpdate:@"INSERT INTO Users (userAvatarImage, userSay, userName, name) VALUES (:userAvatarImage, :userSay, :userName, :name);" withParameterDictionary:dict];
            [dataBase executeUpdate:@"INSERT INTO Posts (postImageName) VALUES (:postImageName);" withParameterDictionary:dict];
        } @catch (NSException *exception) {
            NSLog(@"Executed with error: %@", exception);
        }
        FMResultSet *resSet = [dataBase executeQuery:@"select count(*) from Users"];
        while (resSet.next) {
            NSLog(@"%ld", [resSet longForColumn:0]);
        }
    }
}

-(void)removeAllObjectInTable{
    NSString *sqlRequest = @"Delet from Users;";
    @try {
        [dataBase executeQuery:sqlRequest];
    } @catch (NSException *exception) {
        NSLog(@"Execute exeption: %@", exception);
    }
}


-(NSArray *)getUsersFromDataBase{
    FMResultSet *resSetFromUsers = [dataBase executeQuery:@"select * from Users"];
    NSMutableArray *dataArr = [NSMutableArray new];
    
    while (resSetFromUsers.next) {
        FMResultSet *resSetFromPosts = [dataBase executeQuery:[NSString stringWithFormat:@"select * from Posts where user_id = %@;", [resSetFromUsers stringForColumn:@"id"]]];
        [dataArr addObject:[[HistoryDataModel alloc] initWithResultSet:resSetFromUsers and:resSetFromPosts]];
    }
    return [dataArr copy];
}


//-(NSArray *)getUsersInformationFromDataSQL:(NSString*)userName{
//    FMResultSet *resSet = [dataBase executeQuery:[NSString stringWithFormat:@"select * from Posts"];
//    NSMutableArray *dataArr = [NSMutableArray new];
//    
//    while (resSet.next) {
//        [dataArr addObject:[[HistoryDataModel alloc] initWithResultSet:resSet]];
//    }
//    return [dataArr copy];
//}

#pragma mark - Helpers

-(void)dropTable{
    [dataBase executeUpdate:@"DROP TABLE Users"];
    [dataBase executeUpdate:@"DROP TABLE Posts"];
}

-(NSArray *)getDataFomPlist{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DataPlist" ofType:@"plist"];
    NSArray *dataArr = [[NSArray alloc]initWithContentsOfFile:path];
    if (!dataArr){
        return nil;
    }
    return dataArr;
}
@end
