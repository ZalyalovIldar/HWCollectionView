//
//  profileView.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 07.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileView : UIViewController

-(void)dataChangeImage:(NSString *)imageName andIndexPath:(int)index;
-(void)dataChangeLabel:(NSString *)labelText andIndexPath:(int)index;

@end
