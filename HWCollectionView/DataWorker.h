//
//  DataWorker.h
//  HWCollectionView
//
//  Created by Наталья on 21.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"
@interface DataWorker : NSObject

+ (instancetype)sharedInstance;

- (void)fetchAllContentWithSuccesBlock:(void(^)(NSArray *result))succesBlock andErrorBlock:(void(^)(NSError *error))errorBlock;

@end
