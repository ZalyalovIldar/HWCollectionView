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

@interface profileView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) NSMutableArray * dataSourceImage;
@property (strong, nonatomic) NSMutableArray * dataSourceLabel;
@property (strong, nonatomic) NSMutableArray * dataSource;
@end

@implementation profileView

static NSString * const reuseIdentifier = @"Cell";

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:YES];
//    [self writeDataToFile:@"SomeData"];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Находим instagramList.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    //Пацан за контент отвечает и добавляет в массив
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceImage = [dict objectForKey:@"instagramImage"];
    _dataSourceLabel = [dict objectForKey:@"instagramLabel"];
    
    //Tutorial
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
    
    
    // Do any additional setup after loading the view.
}
//Refresh
- (void)reloadData
{
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
    vc.imageMakerImage = _dataSourceImage;
    vc.imageMakerLabel = _dataSourceLabel;
    vc.imageMakerIndexPath = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [segue destinationViewController];
//    // Pass the selected object to the new view controller.
//}



#pragma mark - data
-(void)dataChangeImage:(NSString *)imageName andIndexPath:(int)index{
    [_dataSourceImage replaceObjectAtIndex:index withObject:imageName];
    NSLog(@"%@", _dataSourceImage);
    NSLog(@"Work");
    
}
-(void)dataChangeLabel:(NSString *)labelText andIndexPath:(int)index{
    
}
-(void)writeDataToFile{
    NSError *eroor;
    NSDictionary *dataDict = @{
                               @"instagramImage":_dataSourceImage,
                               @"instagramLabel":_dataSourceLabel
                               };
    NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:dataDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&eroor];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    //Data
    NSString *name = [NSString stringWithFormat:@"instagramList.plist"];
    NSString *datafile = [documentsPath stringByAppendingPathComponent:name];
    
    [writeData writeToFile:datafile atomically:YES];
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
- (void)changeViewOnSetting{ //метод перехода на другой Setting
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"SettingView"];
    [self.navigationController pushViewController:moveToGeneral animated:YES];
    //[self presentViewController:moveToGeneral animated:YES completion:nil];
}
@end
