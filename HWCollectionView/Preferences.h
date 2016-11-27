//
//  Preferences.h
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject <NSCoding>

@property (nonatomic, strong) NSData *profileImageData;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nikName;
@property (nonatomic, strong) NSString *webPage;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *sex;


@end
