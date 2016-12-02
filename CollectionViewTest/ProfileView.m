//
//  profileView.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 07.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "profileView.h"
#import "MyCollectionViewCell.h"
#import "ImageMakerViewController.h"
#import "UserSetting.h"

@interface profileView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImage;

@property (strong, nonatomic) NSMutableArray * dataSourceImage;
@property (strong, nonatomic) NSMutableArray * dataSourceLabel;
@property (strong, nonatomic) NSMutableArray * dataSource;


@end

@implementation profileView

static NSString * const reuseIdentifier = @"Cell";

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userAvatarImage.image = [self loadImage];
    self.userNameLabel.text = userSettingData.userName;
    self.userSayLabel.text = userSettingData.userSay;
    self.navigationItem.title = userSettingData.userLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Находим instagramList.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    //Пацан за контент отвечает и добавляет в массив
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceImage = [dict objectForKey:@"instagramImage"];
    _dataSourceLabel = [dict objectForKey:@"instagramLabel"];
    
    //userInformation
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userAvatarImage.image = [self loadImage];
    self.userNameLabel.text = userSettingData.userName;
    self.userSayLabel.text = userSettingData.userSay;
    //Refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.attributedTitle = [NSAttributedString.alloc initWithString:@"Я обновляюсь..."];
    [refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    self.collectionView.refreshControl = refreshControl;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setItemSize:CGSizeMake([self setSize], [self setSize])];
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.userAvatarImage.layer.cornerRadius = self.userAvatarImage.frame.size.width/2;
    self.userAvatarImage.clipsToBounds = YES;
    
    // Do any additional setup after loading the view.
}
//Refresh
- (void)reloadData
{
    // Находим instagramList.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    //Пацан за контент отвечает и добавляет в массив
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceImage = [dict objectForKey:@"instagramImage"];
    _dataSourceLabel = [dict objectForKey:@"instagramLabel"];
    
    //userInformation
    UserSetting *userSettingData = (UserSetting*)[UserSetting unarchiveData];
    self.userNameLabel.text = userSettingData.userName;
    self.userSayLabel.text = userSettingData.userSay;
    [self.collectionView reloadData];
    
    [self.collectionView.refreshControl endRefreshing];
    
}

//размер ячейки
-(int)setSize{
    int res = self.view.frame.size.width/3-1;
    return res;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.collectionView.image = [UIImage imageNamed:[_dataSourceImage objectAtIndex:indexPath.row]];
    cell.cellLabel.text = _dataSourceLabel[indexPath.row];
    // Configure the cell
    return cell;
}

#pragma mark - Instagram function

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //ImageMakerViewController
    ImageMakerViewController *vc = (ImageMakerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ImageMakerViewController"];
    vc.imageMakerImage = _dataSourceImage[indexPath.row];
    vc.imageMakerLabel = _dataSourceLabel[indexPath.row];
    vc.imageMakerIndexPath = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - data
-(void)dataChangeImage:(NSString *)imageName andIndexPath:(int)index{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceImage = [NSMutableArray arrayWithArray:[dict objectForKey:@"instagramImage"]];
    NSLog(@"%@", _dataSourceImage);
    [_dataSourceImage replaceObjectAtIndex:index withObject:imageName];
    NSLog(@"%@", _dataSourceImage);
    NSLog(@"Work");
    
}
-(void)dataChangeLabel:(NSString *)labelText andIndexPath:(int)index{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceLabel = [NSMutableArray arrayWithArray:[dict objectForKey:@"instagramLabel"]];
    NSLog(@"%@", _dataSourceLabel);
    [_dataSourceLabel replaceObjectAtIndex:index withObject:labelText];
    NSLog(@"%@", _dataSourceImage);
    [self writeDataToFile];
    NSLog(@"Work");
}

-(void)writeDataToFile{
    NSError *eroor;
    NSDictionary *dataDict = @{
                               @"instagramImage":_dataSourceImage,
                               @"instagramLabel":_dataSourceLabel
                               };
    NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:dataDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&eroor];
    //Data
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"instagramList" ofType:@"plist"];
    [writeData writeToFile:plistPath atomically:YES];
}

#pragma mark - PageView
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self changeViewOnPageView];
}

- (void)changeViewOnPageView{ //метод перехода на другой ViewController
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //програмный переход в другой viewController
    UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self presentViewController:moveToGeneral animated:YES completion:nil];
    
}

-(UIImage*)loadImage{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[path stringByAppendingPathComponent:@"photo.png"];
    UIImageView *myimage=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    myimage.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    return myimage.image;
}
@end
