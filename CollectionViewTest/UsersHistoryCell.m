//
//  UsersHistoryCell.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 02.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UsersHistoryCell.h"

@implementation UsersHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
    self.userAvatar.clipsToBounds = YES;
    // Initialization code
}

@end
