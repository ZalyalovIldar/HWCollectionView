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
        NSDictionary *content = @{ICIdKey : @(0), ICImageDataKey : @"1.jpg", ICTextKey : @"Привет" };
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
    
}

- (void)saveAllContent:(NSArray<Content *> *)content
{
    
}




@end
