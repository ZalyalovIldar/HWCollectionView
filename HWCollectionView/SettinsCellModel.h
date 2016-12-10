//
//  SettinsCellModel.h
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kCellFormat) {
    kCellFormatString,
    kCellFormatEmail,
    kCellFormatNumber,
};
@interface SettinsCellModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) kCellFormat format;
@property (nonatomic, strong) NSString *key;


- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value format:(kCellFormat)format key:(NSString *)key;
@end
