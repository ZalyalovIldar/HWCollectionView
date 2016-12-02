//
//  Data.m
//  HWCollectionView
//
//  Created by Ленар on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "Data.h"

static NSString *const visitedSetting = @"filledAboutItself";

@implementation Data

-(void)getDataFromPlist{
    NSError *error;
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *newPlistPath=[path stringByAppendingPathComponent:@"Data.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:newPlistPath]){
        NSLog(@"file");
    }else{
        NSData *newPlistData = [NSPropertyListSerialization dataWithPropertyList:dict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
        [newPlistData writeToFile:newPlistPath atomically:YES];
        dict = [NSDictionary dictionaryWithContentsOfFile:newPlistPath];
    }
    self.commentArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"Comment"]];
    self.imageNameArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"Image"]];
    NSLog(@"comment %@",self.commentArray);
    NSLog(@"image %@",self.imageNameArray);
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
    NSLog(@"Волшебный массив %@",[self getCommentArray]);
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

+(int)whatUserNotVisited{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewLoad"] isEqual:@"visited"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:visitedSetting];
        return 1;
    }else{
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:visitedSetting] isEqual:@"YES"]) {
            return 2;
        }else{
            return 3;
        }
    }
}

+(NSArray*)getSexArray{
    return @[@"Не указано",@"Мужской",@"Женский"];
}

+(void)uploadPhotoOnPhoneWithInfo:(NSDictionary*)info{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"userPhoto.png"];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data = UIImagePNGRepresentation(editedImage);
        [data writeToFile:imagePath atomically:YES];
    }
}

@end
