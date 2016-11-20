//
//  MyCollectionViewCell.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 05.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end
