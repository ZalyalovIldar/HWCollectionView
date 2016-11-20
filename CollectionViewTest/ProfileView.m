//
//  profileView.m
//  CollectionViewTest
//
//  Created by Ильяс Ихсанов on 07.11.16.
//  Copyright © 2016 Ильяс Ихсанов. All rights reserved.
//

#import "profileView.h"
#import "MyCollectionViewCell.h"

@interface profileView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) NSArray * dataSourceImage;
@property (strong, nonatomic) NSArray * dataSourceLabel;
@property (strong, nonatomic) NSArray * dataSource;
@end

@implementation profileView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Находим instagramList.plist
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instagramList" ofType:@"plist"];
    //Пацан за контент отвечает и добавляет в массив
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataSourceImage = [dict objectForKey:@"instagramImage"];
    _dataSourceLabel = [dict objectForKey:@"instagramLabel"];
    
    //Tutorial
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"ViewLoad"] != 0){
            [self dismissViewControllerAnimated:YES completion:nil];
            [self changeViewOnPageView];
        }
    
    //_dataSource = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setItemSize:CGSizeMake([self setSize], [self setSize])];
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    // Do any additional setup after loading the view.
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
    NSLog(@"%@", _dataSource);
    cell.collectionView.image = [UIImage imageNamed:[_dataSourceImage objectAtIndex:indexPath.row]];
    cell.cellLabel.text = _dataSourceLabel[indexPath.row];
    // Configure the cell
    return cell;
}

#pragma mark - Instagram function

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ViewLoad"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self changeViewOnPageView];
}

- (void)changeViewOnPageView{ //метод перехода на другой ViewController
    UIStoryboard *tempStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //програмный переход в другой viewController
    UIViewController *moveToGeneral = [tempStoryboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self presentViewController:moveToGeneral animated:YES completion:nil];
    
}
@end
