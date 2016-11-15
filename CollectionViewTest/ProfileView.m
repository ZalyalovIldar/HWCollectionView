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
@property (strong, nonatomic) NSArray * datasource;
@end

@implementation profileView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"ViewLoad"] == 0){
            [self dismissViewControllerAnimated:YES completion:nil];
            [self changeViewOnPageView];
        }
    _datasource = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setItemSize:CGSizeMake([self setSize], [self setSize])];
    [flowLayout setMinimumLineSpacing:1];
    [flowLayout setMinimumInteritemSpacing:1];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    // Do any additional setup after loading the view.
}

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
#warning Incomplete implementation, return the number of items
    return _datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.collectionView.image = (UIImage *)_datasource[indexPath.row];
    // Configure the cell
    
    return cell;
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
