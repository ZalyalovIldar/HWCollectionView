//
//  UsersHistoryTableCell.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 02.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersHistoryTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userHistoryImage;
@property (weak, nonatomic) IBOutlet UIButton *dotsButton;


@end
