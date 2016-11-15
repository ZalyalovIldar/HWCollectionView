//
//  FirstViewController.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 08.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()



- (IBAction)skipButton:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //Создание базы данных
    _pageTitles = @[@"Более 200 советов и приемов",@"Открой для себя скрытые возможности!",@"После появления социальных сетей...",@"...люди решили, что они кому-то нужны"];
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    
    //Создание PageView контроллера
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    
    thisControl.hidden = true;

    //size
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    
    [self  addChildViewController:_pageViewController];
    [self.view  addSubview:_pageViewController.view];
    [self.pageViewController  didMoveToParentViewController:self];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ViewLoad"];

    
    // Do any additional setup after loading the view.
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Переходы
//- (void)viewDidAppear:(BOOL)animated{ //то что происходит после запуска приложения
//    [super viewDidAppear:animated];
//    if([[NSUserDefaults standardUserDefaults] integerForKey:@"ViewLoad"] == 0){
//        [self dismissViewControllerAnimated:YES completion:nil];
//        [self changeViewOnProfileView];
//    }
//}
- (void)changeViewOnProfileView{ //метод перехода на другой ViewController
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //програмный переход в другой viewController
    UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"ProfileView"];
    [self presentViewController:moveToGeneral animated:YES completion:nil];
    
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
    if (index == [self.pageTitles count]) {
        return nil;
    }
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
- (IBAction)skipButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ViewLoad"];
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
