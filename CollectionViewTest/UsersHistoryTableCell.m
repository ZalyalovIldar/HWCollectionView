//
//  UsersHistoryTableCell.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 02.12.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "UsersHistoryTableCell.h"

@implementation UsersHistoryTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
    self.userAvatar.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse{
    self.userName = nil;
    self.userAvatar.image = nil;
    self.userHistoryImage.image = nil;
}

@end
