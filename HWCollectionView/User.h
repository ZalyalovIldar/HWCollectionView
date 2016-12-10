//
//  User.h
//  HWCollectionView
//
//  Created by Наталья on 04.12.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"
#import "Preferences.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray <Content *> *contents;
@property (nonatomic, strong) Preferences *preferences;
@property (nonatomic, strong) NSString *posts;
@property (nonatomic, strong) NSString *subscribers;
@property (nonatomic, strong) NSString  *subscriptions;



@end
