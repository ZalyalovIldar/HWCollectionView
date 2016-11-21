//
//  Data.m
//  HWCollectionView
//
//  Created by Ленар on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "Data.h"

@implementation Data

-(void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    self.commentArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"Comment"]];
    self.imageNameArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"Image"]];
}

-(NSMutableArray*)getCommentArray{
    [self getDataFromPlist];
    return self.commentArray;
}

-(NSMutableArray*)getImageNameArray{
    [self getDataFromPlist];
    return self.imageNameArray;
}

-(NSArray*)replaceCommentOfString:(NSString*)comment fromRow:(NSInteger)numberRow{
    [self.commentArray replaceObjectAtIndex:numberRow withObject:comment];
    return self.commentArray;
}

-(NSArray*)replaceImageWithName:(NSString*)imageName fromRow:(NSInteger)numberRow{
    NSLog(@"%@",imageName);
    [self.imageNameArray replaceObjectAtIndex:numberRow withObject:imageName];
    return self.imageNameArray;
}

-(void)writeDataToFileImageArray:(NSArray*)imageArray andCommentArray:(NSArray*)commentArray{
    NSError *error;
    NSDictionary *plistDict = @{@"Image":imageArray,@"Comment":commentArray};
    NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    NSLog(@"%@",plistPath);
    [writeData writeToFile:plistPath atomically:YES];
}

-(NSString*)getImageName:(UIImageView*)imageView{
    NSString *imageName = [imageView image].accessibilityIdentifier;
    return imageName;
}

-(void)createImageFromData:(NSData*)data withName:(NSString*)name{
    NSString *rootPath = [[NSBundle mainBundle] resourcePath];
    NSString *docPath = [rootPath stringByAppendingPathComponent:name];
    NSLog(@"%@", docPath);
    if(![[NSFileManager defaultManager]fileExistsAtPath:docPath]){
        [[NSFileManager defaultManager]createFileAtPath:docPath contents:data attributes:nil];
    }
}

@end
