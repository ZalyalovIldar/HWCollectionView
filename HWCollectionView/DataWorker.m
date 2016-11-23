//
//  DataWorker.m
//  HWCollectionView
//
//  Created by Наталья on 21.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "DataWorker.h"

const NSString *DWContentKey = @"content";
@interface DataWorker()

@property (nonatomic, strong) NSString *path;


@end

@implementation DataWorker


+ (instancetype)sharedInstance {
    
    static DataWorker *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self == nil)
    {
        return nil;
    }
    [self initialize];
    return self;
}

- (void)initialize
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Images.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) {
        
        NSMutableDictionary *root = [@{@"autosave" : @"YES", @"identifier" : @"4F4@@"} mutableCopy];
        NSMutableArray *contents = [NSMutableArray new];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1.jpg" ofType: nil];
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        
                               
        NSDictionary *content = @{ICIdKey : @(1), ICImageDataKey : data, ICTextKey : @"Привет" };
        [contents addObject:content];
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"2.jpg" ofType: nil];
        data = [NSData dataWithContentsOfFile:imagePath];
        content = @{ICIdKey : @(2), ICImageDataKey : data, ICTextKey : @"ЭЭЭЭЭЭЙ"};
        [contents addObject:content];
        
        [root setObject:contents forKey:DWContentKey];
        NSError *error;
        
        
        NSData *representation = [NSPropertyListSerialization dataWithPropertyList:root format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];

        if (error)
        {
            NSLog(@"%@", error);
            return;
        }
        
        BOOL isWriteToFile = [representation writeToFile:path atomically:YES];
#warning TODO add if else
        NSLog(@"Write to file status: %@", isWriteToFile ? @"Good" : @"Failed");
        
        
    }
    
    NSMutableDictionary *data;
    self.path = path;
    
}

- (void)fetchAllContentWithSuccesBlock:(void(^)(NSArray *result))succesBlock andErrorBlock:(void(^)(NSError *error))errorBlock
{
    NSData *dataWithContentPlist = [NSData dataWithContentsOfFile:self.path];
    if (!dataWithContentPlist) {
        NSLog(@"error reading");
//        errorBlock();
        return;
    }
        
    NSError *error = nil;
    NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:dataWithContentPlist options:NSPropertyListMutableContainersAndLeaves format:0 error:&error];
    if (!error) {
        
        NSMutableDictionary *root = plist;
        NSArray *fetchedContents = [root objectForKey:DWContentKey];
        NSMutableArray *modelContent = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in fetchedContents) {
            
            Content *content = [[Content alloc] initWithDictionary:dict];
            [modelContent addObject:content];
        }
        
        succesBlock(modelContent);
        
    }else {
        NSLog(@"error");
        errorBlock(error);
        
    }
    
}

- (Content *)fetchContentWithId:(NSUInteger)id
{


    return [Content new];
}

- (void)saveContent:(Content *)content
{
    [self fetchAllContentWithSuccesBlock:^(NSArray *result) {
        
        
        NSMutableArray *mutableResult = [result mutableCopy];
        if (content.id == 0)
        {
            NSInteger lastIndex = result.count - 1;
            Content *lastContent = result[lastIndex];
            content.id = lastContent.id + 1;
            [mutableResult addObject:content];
            [self saveAllContent:[mutableResult copy]];
            return ;
        }
        
        __block NSInteger containsIndex = - 1;
        
        
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Content *curContent = obj;
            if (curContent.id == content.id)
            {
                containsIndex = idx;
                *stop = YES;
            }
            
        }];
        
        
        if (containsIndex >= 0)
        {
            [mutableResult replaceObjectAtIndex:containsIndex withObject:content];
        }else
        {
            [mutableResult addObject:content];
        }
        
        [self saveAllContent:[mutableResult copy]];
        
    } andErrorBlock:^(NSError *error) {
        
        NSLog(@"Something go wrong");
        
    }];
}

- (void)saveAllContent:(NSArray<Content *> *)content
{
    NSMutableDictionary *root = [@{@"autosave" : @"YES", @"identifier" : @"4F4@@"} mutableCopy];

    NSMutableArray *contents = [NSMutableArray new];
    
    [content enumerateObjectsUsingBlock:^(Content * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [contents addObject:[obj dictionaryFromObject]];
    }];
    
    [root setObject:[contents copy] forKey:DWContentKey];
    NSError *error;
    
    NSData *representation = [NSPropertyListSerialization dataWithPropertyList:root format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if (error)
    {
        NSLog(@"%@", error);
        return;
    }
    
    BOOL isWriteToFile = [representation writeToFile:self.path atomically:YES];
#warning TODO add if else
    NSLog(@"Write to file status: %@", isWriteToFile ? @"Good" : @"Failed");
    

}




@end
