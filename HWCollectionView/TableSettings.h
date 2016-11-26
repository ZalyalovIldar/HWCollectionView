//
//  TableSettings.h
//  HWCollectionView
//
//  Created by Ленар on 23.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableSettings : NSObject <NSCoding>

@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *username;
@property (strong,nonatomic)NSString *webpage;
@property (strong,nonatomic)NSString *email;
@property (strong,nonatomic)NSString *phoneNumber;
@property (strong, nonatomic)NSString *userImageName;
@property int sexNumber;

+(void)archiveData:(TableSettings*)tabelSettings;
+(NSArray*)unarchiveData;

@end
