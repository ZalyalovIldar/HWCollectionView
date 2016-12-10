//
//  DataManager.m
//  HWCollectionView
//
//  Created by Наталья on 03.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "DataManager.h"
#import "User.h"
#import <FMDB.h>

@implementation DataManager
{
    FMDatabase *dataBase;
}

+ (instancetype)sharedInstance{
    static id _singleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleTon = [[self alloc] init];
    });
    return _singleTon;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
   
    NSString *path = [docPath stringByAppendingPathComponent:@"instagram_db.sqlite"];
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    if (![fileManager fileExistsAtPath: path])
    {
        
        dataBase = [[FMDatabase alloc] initWithPath:path];
        [dataBase open];
        NSError *error;
        [self createTableWithError:&error];
        if (error)
        {
            NSLog (@"Error :%@", error);
            return;
        }
        
       User *newUser = [self createNewUser:@"acacuce" name:@"Nikita" about:@"fuckin' zadrot" email:@"acacuce@gmail.com" phoneNumber:nil sex:nil imageName:@"1.jpg" posts:@"10" subscribers:@"100" subscriptions:@"30"];
        User *secondUser = [self createNewUser:@"theweeknd" name:@"Abel" about:@"STARBOY" email:nil phoneNumber:nil sex:nil imageName:@"weeknd.jpg" posts:@"650" subscribers:@"10000" subscriptions:@"421"];
        User *thirdUser = [self createNewUser:@"kimkardashian" name:@"Kim Kardashian West" about:@"Twitter - KimKardashian" email:nil phoneNumber:nil sex:nil imageName:@"kkp.jpg" posts:@"99990" subscribers:@"50000" subscriptions:@"90"];
         User *fourthUser = [self createNewUser:@"natasha" name:@"Natalia" about:@"IOS Developer" email:nil phoneNumber:nil sex:nil imageName:@"9.jpg" posts:@"9" subscribers:@"50" subscriptions:@"10"];
         User *fifthUser = [self createNewUser:@"gulia" name:@"Gulia" about:@"Keep calm and yoga on " email:nil phoneNumber:nil sex:nil imageName:@"6.jpg" posts:@"9" subscribers:@"5" subscriptions:@"9"];
         User *sixthUser = [self createNewUser:@"chingiz" name:@"Hikka" about:@"Twitter - Rich Bitch" email:nil phoneNumber:nil sex:nil imageName:@"14.jpg" posts:@"5" subscribers:@"3" subscriptions:@"4"];
        
        [self addNewUser:newUser andWithError:&error];
        [self addNewUser:secondUser andWithError:&error];
        [self addNewUser:thirdUser andWithError:&error];
        [self addNewUser:fourthUser andWithError:&error];
        [self addNewUser:fifthUser andWithError:&error];
        [self addNewUser:sixthUser andWithError:&error];
        
        if (error)
        {
            NSLog(@"Error %@", error);
        }

    }
    dataBase = [[FMDatabase alloc] initWithPath:path];
    [dataBase open];
    
}

- (User *)createNewUser:(NSString *)nikname
                 name:(NSString *)name
                about:(NSString *)about
                email:(NSString *)email
          phoneNumber:(NSString *)phoneNumber
                    sex:(NSString *)sex
              imageName:(NSString *)imageName
                  posts:(NSString *)posts
            subscribers:(NSString *)subscribers
          subscriptions:(NSString *)subscriptions


{
    Preferences *preferences = [Preferences new];
    preferences.nikName = nikname;
    preferences.email = email;
    preferences.name = name;
    preferences.about = about;
    preferences.profileImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
       User *user = [User new];
    user.preferences = preferences;
    user.posts = posts;
    user.name = name;
    user.subscribers = subscribers;
    user.subscriptions = subscriptions;
 
    NSMutableArray *contents = [NSMutableArray new];
    Content *content = nil;
    
    content = [self contentWithImage:@"1.jpg"];
    [contents addObject:content];
    content = [self contentWithImage:@"4.jpg"];
    [contents addObject:content];
    content = [self contentWithImage:@"7.jpg"];
    [contents addObject:content];
    content = [self contentWithImage:@"9.jpg"];
    [contents addObject:content];
    content = [self contentWithImage:@"12.jpg"];
    [contents addObject:content];
    
    content = [self contentWithImage:@"10.jpg"];
    [contents addObject:content];
    user.contents = contents;
    return user;
    
    
}

- (Content *)contentWithImage:(NSString *)imageName
{
    Content *content = [Content new];
    content.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    return content;
}

- (void)createTableWithError:(out NSError **)error{
    [dataBase beginTransaction];
    NSString *sqlRequestForUsers = @"CREATE TABLE users(id integer PRIMARY KEY AUTOINCREMENT , nikName text, profilePhoto BLOB,name text,webPage text,about text, email varchar, phoneNumber text, sex text, posts text, subscribers text, subscriptions text)";
    NSString *sqlRequestForPictures = @"CREATE TABLE pictures(id integer PRIMARY KEY AUTOINCREMENT , user_id integer,picture BLOB)";
    
    
        [dataBase executeUpdate:sqlRequestForUsers];
        [dataBase executeUpdate:sqlRequestForPictures];
   BOOL endTransaction =  [dataBase commit];
    if (!endTransaction){
        *error = dataBase.lastError;
    }
    
            
}

- (void)addNewUser:(User *)user andWithError:(out NSError **)error
{
    
    [dataBase beginTransaction];
    NSString *insertQuery = @"INSERT INTO users(nikName, profilePhoto, name, webPage, about, email, phoneNumber, sex, posts, subscribers, subscriptions ) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
    NSString  *selectQuery = @"SELECT MAX(id) as id FROM users";
    NSString *insertToPhotosQuery = @"INSERT INTO pictures(user_id, picture) VALUES (?,?)";
    
    
    [dataBase executeUpdate:insertQuery, user.preferences.nikName, user.preferences.profileImageData, user.preferences.name, user.preferences.webPage, user.preferences.about, user.preferences.email, user.preferences.phoneNumber, user.preferences.sex, user.posts, user.subscribers, user.subscriptions];
   FMResultSet *resultSet =  [dataBase executeQuery:selectQuery];
    NSInteger lastId = 0;
    
    if (resultSet.next)
    {
        lastId = [resultSet intForColumn:@"id"];
    }else{
        [dataBase rollback];
    }
    
    for(Content *content in user.contents)
    {
        NSError *insertError = nil;
        [dataBase executeUpdate:insertToPhotosQuery values:@[@(lastId), content.imageData] error:&insertError];
        
            if (insertError)
        {
            *error = insertError;
            return;
        }
    }

    BOOL endTransaction = [dataBase commit];
    if(!endTransaction){
        *error = dataBase.lastError;
    }
    
}

- (NSArray<User *> *)allUsersWithError:(out NSError **)error
{
    NSString *sql = @"SELECT * FROM users";
    NSString *sqlSelectContent = @"SELECT * FROM pictures WHERE user_id = ?";
    

    
    FMResultSet *resultSet =  [dataBase executeQuery:sql values:nil error:error];
    if (*error)
    {
        return nil;
    }
    NSMutableArray *mutableUsers = [NSMutableArray new];
    while (resultSet.next) {
        
        User *user = [User new];
        NSInteger id = [resultSet intForColumn:@"id"];
        NSMutableArray *mutableContent = [NSMutableArray new];
        FMResultSet *contentResult = [dataBase executeQuery:sqlSelectContent values:@[@(id)] error:error];
        if (*error)
        {
            return nil;
        }
            
        while (contentResult.next) {
            Content *content = [Content new];
            NSData *data = [contentResult dataForColumn:@"picture"];
            content.imageData = data;
            [mutableContent addObject:content];
            
        }
        user.contents = [mutableContent copy];
        user.name = [resultSet stringForColumn:@"name"];
        Preferences *preferences = [Preferences new];
        preferences.name = [resultSet stringForColumn:@"name"];
        preferences.nikName = [resultSet stringForColumn:@"nikName"];
        preferences.profileImageData = [resultSet dataForColumn:@"profilePhoto"];
        preferences.webPage = [resultSet stringForColumn:@"webPage"];
        preferences.email = [resultSet stringForColumn:@"email"];
        preferences.about = [resultSet stringForColumn:@"about"];
        preferences.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
        preferences.sex = [resultSet stringForColumn:@"sex"];
        user.posts = [resultSet stringForColumn:@"posts"];
        user.subscribers = [resultSet stringForColumn:@"subscribers"];
        user.subscriptions = [resultSet stringForColumn:@"subscriptions"];
        user.preferences = preferences;
        [mutableUsers addObject:user];
    }
    
    
    return [mutableUsers copy];
}


@end
