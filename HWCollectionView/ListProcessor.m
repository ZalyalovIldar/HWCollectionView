
//
//  ListProcessor.m
//  HWCollectionView
//
//  Created by Rustam N on 20.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ListProcessor.h"

@implementation ListProcessor

- (NSString*)getLabelText:(int)index{
    return [[self read] objectForKey:@"LabelDate"][index];
}

- (NSString*)getImageName:(int)index{
    return [[self read] objectForKey:@"ImageDate"][index];
}


- (NSMutableArray*)getLabelsArray{
    return [[self read] objectForKey:@"LabelDate"];
}

- (NSMutableArray*)getImageArray{
    return [[self read] objectForKey:@"ImageDate"];
}

- (NSArray*)getAllImageArray{
    return [[self read] objectForKey:@"AllImage"];
}

- (void)add:(NSString*)image andText:(NSString*)text{
    NSMutableDictionary *dictionary = [self read];
    NSMutableArray *arrLabelDate = [dictionary objectForKey:@"LabelDate"];
    NSMutableArray *arrImageDate = [dictionary objectForKey:@"ImageDate"] ;
    [arrLabelDate addObject:text];
    [arrImageDate addObject:image];
    [dictionary setObject:arrLabelDate forKey:@"LabelDate"];
    [dictionary setObject:arrImageDate forKey:@"ImageDate"];
    [self write:dictionary];
}

- (NSMutableDictionary*)read{
    NSPropertyListFormat format;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"CollectionViewCellDate.plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSMutableDictionary *dataDict = (NSMutableDictionary*)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:nil];
    return dataDict;
}

- (void)write:(NSMutableDictionary*)dictionary{
    NSArray *allImage = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    NSError *error;
    NSDictionary *dataDick = @{@"AllImage": allImage, @"LabelDate":[dictionary objectForKey:@"LabelDate"], @"ImageDate":[dictionary objectForKey:@"ImageDate"]};
    
    NSData *writwData = [NSPropertyListSerialization dataWithPropertyList:dataDick format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *name = [NSString stringWithFormat:@"CollectionViewCellDate.plist"];
    NSString *dataFile = [documentsPath stringByAppendingPathComponent:name];
    [writwData writeToFile:dataFile atomically:YES];
}

- (void)setLabelText:(int)index andText:(NSString*)text{
    NSMutableDictionary *dictionary = [self read];
    NSMutableArray *arrLabelDate = [dictionary objectForKey:@"LabelDate"];
    [arrLabelDate replaceObjectAtIndex:index withObject:text];
    [dictionary setObject:arrLabelDate forKey:@"LabelDate"];
    [self write:dictionary];
}

- (void)setImage:(int)index andImageName:(NSString*)image{
    NSMutableDictionary *dictionary = [self read];
    NSMutableArray *arrImageDate = [dictionary objectForKey:@"ImageDate"] ;
    [arrImageDate replaceObjectAtIndex:index withObject:image];
    [dictionary setObject:arrImageDate forKey:@"ImageDate"];
    [self write:dictionary];
}

- (void)delete:(int)index{
    NSMutableDictionary *dictionary = [self read];
    NSMutableArray *arrLabelDate = [dictionary objectForKey:@"LabelDate"];
    NSMutableArray *arrImageDate = [dictionary objectForKey:@"ImageDate"] ;
    [arrLabelDate removeObjectAtIndex:index];
    [arrImageDate removeObjectAtIndex:index];
    [dictionary setObject:arrLabelDate forKey:@"LabelDate"];
    [dictionary setObject:arrImageDate forKey:@"ImageDate"];
    [self write:dictionary];
}

- (void)firsLoad{
    NSArray *allImage = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    NSArray *labelDate = @[@"Exsample"];
    NSArray *imageDate = @[@"1"];
    NSError *error;
    NSDictionary *dataDick = @{@"AllImage": allImage, @"LabelDate":labelDate, @"ImageDate":imageDate};
    NSData *writwData = [NSPropertyListSerialization dataWithPropertyList:dataDick format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *name = [NSString stringWithFormat:@"CollectionViewCellDate.plist"];
    NSString *dataFile = [documentsPath stringByAppendingPathComponent:name];
    [writwData writeToFile:dataFile atomically:YES];
}

@end
