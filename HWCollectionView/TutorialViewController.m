//
//  TutorialViewController.m
//  HWCollectionView
//
//  Created by Ленар on 08.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "TutorialViewController.h"
#import "PageContentViewController.h"

@interface TutorialViewController ()

@end

static NSString *const watchTutorial = @"ViewLoad";

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageImages = @[@"instagram1",@"iPhone2",@"iPhone3"];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(self.view.frame.size.height/9));
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    thisControl.hidden = true;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - Page View Controller Data Source

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - skip tutorial
- (IBAction)skipTutorialButton:(id)sender {
    if([[[NSUserDefaults standardUserDefaults] objectForKey:watchTutorial] isEqual:@"visited"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"visited" forKey:watchTutorial];
        [[NSUserDefaults standardUserDefaults]synchronize];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"filledAboutItself"] isEqual:@"YES"]){
            UIViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"setting"];
            [self presentViewController:settingVC animated:YES completion:nil];
        }else{
            UIViewController *userVC = [storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
            [self presentViewController:userVC animated:YES completion:nil];
        }
    }
}

@end
