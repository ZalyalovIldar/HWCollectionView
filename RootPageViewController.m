//
//  RootPageViewController.m
//  HWCollectionView
//
//  Created by Наталья on 10.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "RootPageViewController.h"
#import "PageContentViewController.h"

@interface RootPageViewController ()



@end


@implementation RootPageViewController

- (NSArray *)pageImages
{
    if (!_pageImages)
    {
        _pageImages = @[@"1.jpg",@"2.jpg",@"screen.png"];
    }
    return _pageImages;
}

- (NSArray *)pageTitles
{
    if (!_pageTitles)
    {
        _pageTitles = @[@"Create your own space",@"Show the world your life",@"Be unique"];
    }
    return _pageTitles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
- (IBAction)skipButtonDidPressed:(id)sender {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"PresentationShowed" forKey:@"PresentationState"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark Page View Controller Data Source

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = ((PageContentViewController *)viewController).pageIndex;
    
    if (index == NSNotFound){
        return nil;
    }
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = ((PageContentViewController *)viewController).pageIndex;
    
    if (index == 0 || (index == NSNotFound)){
        return nil;
    }
    
    index--;
     return [self viewControllerAtIndex:index];

}



- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
