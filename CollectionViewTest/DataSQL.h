//
//  DataSQL.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 04.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataSQL : NSObject

+(instancetype)sharedInstance;

-(void)createTable;
-(void)addNewRow;
-(void)addValuesFromArr;
-(NSArray *)getUsersFromDataBase;
-(void)dropTable;
@end
