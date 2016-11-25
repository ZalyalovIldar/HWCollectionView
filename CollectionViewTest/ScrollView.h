//
//  ScrollView.h
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 25.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIViewController <UITextFieldDelegate>
{
    UIScrollView* scrollView; //  указатель на наш UIScrollView
    UITextField* activeField; // указывает на активный элемент ввода
}

@end
