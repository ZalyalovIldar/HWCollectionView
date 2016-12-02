//
//  DataManager.m
//  HWCollectionView
//
//  Created by Ленар on 30.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "DataManager.h"
#import "UserModel.h"


@implementation DataManager
{
    FMDatabase *dataBase;
}

+ (instancetype)sharedInstance{
    static id _singleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleTon = [[self alloc]init];
    });
    return _singleTon;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [docPath stringByAppendingPathComponent:@"instagramSQLiteDB.sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
        
        [dataBase open];
        NSLog(@"%@",path);
    }
    return self;
}

- (void)creatTable{
    NSString *sqlRequestForUser = @"create table IF NOT EXISTS Users(id integer primary key autoincrement, name text, username text, userImageName text)";
    NSString *sqlRequestForPosts = @"create table IF NOT EXISTS Posts(user_id int , postImageName text)";
    @try {
        [dataBase executeUpdate:sqlRequestForUser];
        [dataBase executeUpdate:sqlRequestForPosts];
    } @catch (NSException *exception) {
        NSLog(@"Request failed: %@",exception);
    }
}

- (void)addRowToUserTableWithName:(NSString*)name andUserName:(NSString*)username andUserImageName:(NSString*)userImageName{
    NSString *insertQuery = @"INSERT INTO Users (name, username, userImageName) VALUES (?,?,?);";
    
    @try {
        [dataBase executeUpdate:insertQuery,name,username,userImageName];
    } @catch (NSException *exception) {
        NSLog(@"Executed with Error: %@",exception);
    }
    
    FMResultSet *resultSet = [dataBase executeQuery:@"select count(*) from Users"];
    while (resultSet.next) {
        NSLog(@"Raw count: %ld", [resultSet longForColumnIndex:0]);
    }
}

- (void)addValuesFromArray{
    FMResultSet *resultSet = [dataBase executeQuery:@"select count(*) from Users"];
    while (resultSet.next) {
        if ([resultSet longForColumnIndex:0]==0) {
            NSArray *dataArr = [self getDataFromPlist];
            int i = 1;
            for (NSDictionary *dict in dataArr) {
                @try {
                    [dataBase executeUpdate:@"INSERT INTO Users (name,username,userImageName) VALUES (:name, :username, :userImageName);" withParameterDictionary:dict];
                    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO Posts (user_id, postImageName) VALUES (%i,:postImageName);",i];
                    [dataBase executeUpdate:sqlQuery withParameterDictionary:dict];
                    i++;
                } @catch (NSException *exception) {
                    NSLog(@"Executed with Error: %@", exception);
                }
            }
        }
    }
}

-(void)dropTable{
    [dataBase executeUpdate:@"DROP TABLE Users"];
    [dataBase executeUpdate:@"DROP TABLE Posts"];
}

- (NSArray*)getUsersArrFromDataBase{
    FMResultSet *resultSetFromUsers = [dataBase executeQuery:@"SELECT * FROM Users;"];
    NSMutableArray *dataArr = [NSMutableArray new];
    
    while (resultSetFromUsers.next) {
        FMResultSet *resutlSetFromPosts = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM Posts WHERE user_id = %@;",[resultSetFromUsers stringForColumn:@"id"]]];
        [dataArr addObject:[[UserModel alloc] initWithResultSetFromUsers:resultSetFromUsers andResultSetFromPosts:resutlSetFromPosts]];
    }
    return [dataArr copy];
}

- (NSArray*)getUserControllerWithUsername:(NSString*)username{
    FMResultSet *resultSetFromUsers = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM Users WHERE username='%@';",username]];
    NSMutableArray *dataArr = [NSMutableArray new];
    while (resultSetFromUsers.next) {
        FMResultSet *resutlSetFromPosts = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM Posts WHERE user_id = %@;",[resultSetFromUsers stringForColumn:@"id"]]];
        [dataArr addObject:[[UserModel alloc] initWithResultSetFromUsers:resultSetFromUsers andResultSetFromPosts:resutlSetFromPosts]];
    }
    return dataArr;
}

#pragma mark - Helper

-(NSArray*)getDataFromPlist{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DataList" ofType:@"plist"];
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:path];
    
    if (!dataArr) {
        return nil;
    }
    
    return dataArr;
}



@end
