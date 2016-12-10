//
//  HeaderTableView.m
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "HeaderTableView.h"

@implementation HeaderTableView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableView" owner:nil options:nil].firstObject;
    if (self) {
        
    }
    return self;
}
- (IBAction)changePhotoDidClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(changePhotoDidClickedInView:)])
    {
        [self.delegate changePhotoDidClickedInView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
