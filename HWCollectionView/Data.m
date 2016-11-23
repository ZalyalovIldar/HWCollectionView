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

@end
