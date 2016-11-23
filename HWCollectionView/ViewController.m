//
//  ViewController.m
//  HWCollectionView
//
//  Created by Ildar Zalyalov on 03.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "SingleCellViewController.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *imageDataSource;
@property (strong,nonatomic) NSMutableArray *textDataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *watchAgainButton;
@property (strong,nonatomic) NSMutableDictionary *collectionViewData;


@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageDataSource = [NSMutableArray new];
    _textDataSource = [NSMutableArray new];
    NSDictionary *helpDictionary = @{
                                     @"Images":_imageDataSource,
                                     @"Texts":_textDataSource
                                     };
    _collectionViewData = [helpDictionary mutableCopy];
    
    
//    _imageDataSource = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"], nil]];
//    _textDataSource = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture",@"picture", nil]];
//
//    [self writeDataToFile:@"collectionData"];
    
    //[self readData];
    self.helpCellVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleCellViewController"];
    
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self readData];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)watchAgainButtonPressed:(id)sender {
    UIViewController *moveToTutorial = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
    [self presentViewController:moveToTutorial animated:YES completion:nil];
}

#pragma collectionView methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.ImageView.image = (UIImage*)[_collectionViewData objectForKey:@"Images"][indexPath.row];
    cell.textLabel.text = (NSString*)[_collectionViewData objectForKey:@"Texts"][indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    _helpCellVC.imageView.image = (UIImage*)[_collectionViewData objectForKey:@"Images"][indexPath.row];
//    _helpCellVC.textLabel.text = (NSString*)[_collectionViewData objectForKey:@"Texts"][indexPath.row];
//    
//    [self addChildViewController:_helpCellVC];
//    [self.helpCellVC didMoveToParentViewController:self];
//    [self.view addSubview:_helpCellVC.view];
    
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
    
    //SingleCellViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleCellViewController"];
    

    //[self presentViewController:_helpCellVC animated:YES completion:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showDetail"])
    {
        SingleCellViewController *dvController = segue.destinationViewController;
        dvController.imageView.image = (UIImage*)[_collectionViewData objectForKey:@"Images"][sender];
        dvController.textLabel.text = (NSString*)[_collectionViewData objectForKey:@"Texts"][sender];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _imageDataSource.count;
}

#pragma working with property list

-(void)readData {
//    NSDictionary *dataDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"collectionData" ofType:@"plist"]];
//    _collectionViewData = [dataDict mutableCopy];
    
    NSPropertyListFormat format;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"collectionData.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"collectionData" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *dataDict = (NSDictionary*)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:nil];
    
    NSMutableArray *helpArr = [dataDict objectForKey:@"Images"];
    for (int i = 0; i < [helpArr count]; i++) {
        NSString *helpString = [helpArr objectAtIndex:i];
        [helpArr removeObjectAtIndex:i];
        [helpArr insertObject:[UIImage imageNamed: helpString] atIndex:i];
    }
    _imageDataSource = helpArr;
    _textDataSource = [dataDict objectForKey:@"Texts"];
    
    _collectionViewData[@"Images"] = helpArr;
    _collectionViewData[@"Texts"] = [dataDict objectForKey:@"Texts"];
}

-(void)writeDataToFile:(NSString*)fileName {
    NSDictionary *dataDict = @{
                               @"Images":_imageDataSource,
                               @"Texts":_textDataSource
                               };
    NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:dataDict format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *name = [NSString stringWithFormat:@"%@.plist",fileName];
    NSString *dataFile = [documentsPath stringByAppendingPathComponent:name];
    
    [writeData writeToFile:dataFile atomically:YES];
}


@end
