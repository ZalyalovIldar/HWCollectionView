//
//  DetailCollectionView.m
//  HWCollectionView
//
//  Created by Rustam N on 19.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "DetailCollectionView.h"
#import "ListProcessor.h"
#import "CollectionViewCell.h"

@interface DetailCollectionView () <UICollectionViewDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageArr;
@property (strong, nonatomic) NSString *finalImageName;
@property (strong, nonatomic) NSString *finalText;
@property (nonatomic,assign) BOOL isNew;

@end

@implementation DetailCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    ListProcessor *lp = [ListProcessor new];
    _imageArr = [[NSArray alloc] initWithArray:[lp getAllImageArray]];
    _textField.delegate = self;
    _isNew = false;
    
    if(_indexCell == -1){
        _textField.text = @"";
        _finalImageName = @"";
        _finalText = @"";
        _indexCell = 0;
        _deleteButton.enabled = NO;
        _isNew = true;
    }
    else{
        _imageView.image = [UIImage imageNamed:[lp getImageName:_indexCell]];
        _textField.text = [lp getLabelText:_indexCell];
        _finalText = [lp getLabelText:_indexCell];
        _finalImageName = [lp getImageName:_indexCell];
        
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:1.0f];
    [flowLayout setMinimumLineSpacing:1.0f];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/4-3, self.view.frame.size.width/4-3)];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    _finalText = textField.text;
    return YES;
}

- (IBAction)skipActionButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveActionButton:(id)sender {
    if([_finalText  isEqual: @""] || [_finalImageName isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Wrong image or description" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAllertButton = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
        [alert addAction:cancelAllertButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        ListProcessor *lp = [ListProcessor new];
        if(_isNew){
            [lp add:_finalImageName andText:_finalText];
        }
        else{
            if(_finalImageName != [_imageArr objectAtIndex:_indexCell]){
                [lp setImage:_indexCell andImageName:_finalImageName];
            }
            if(_finalText != [lp getLabelText:_indexCell]){
                [lp setLabelText:_indexCell andText:_finalText];
            }

        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (IBAction)deleteActionButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAllertButton = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    UIAlertAction *okAllertButton = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
         ListProcessor *lp = [ListProcessor new];
        [lp delete:_indexCell];
    }];
    [alert addAction:cancelAllertButton];
    [alert addAction:okAllertButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageViewCell.image = [UIImage imageNamed:[_imageArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _imageView.image = [UIImage imageNamed:[_imageArr objectAtIndex:indexPath.row]];
    _finalImageName = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    
}

@end
