//
//  SettingsViewController.m
//  HWCollectionView
//
//  Created by Наталья on 27.11.16.
//  Copyright © 2016 com.itis.iosLab. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "Preferences.h"
#import "SettinsCellModel.h"
#import "HeaderTableView.h"


@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource, HeaderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *resources;
@property (nonatomic, strong) Preferences *preferences;
@property (nonatomic, strong) HeaderTableView *headerView;

@end

@implementation SettingsViewController
static NSString *reuseIdentifiere = @"settingsCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotification];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsTableViewCell" bundle: [NSBundle mainBundle]]  forCellReuseIdentifier:reuseIdentifiere];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonDidClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferences"];
    Preferences *preferences = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.preferences = preferences ? preferences : [[Preferences alloc] init];
    [self buildSourceFromSettings:preferences];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    if(!preferences){
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Work With Keyboard

-(void)dismissKeyboard {
    [self.tableView endEditing:YES];
}

- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) registerNotification {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWillShow: (NSNotification *) notification {
    
    NSValue *value = [notification.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey];
    CGRect keyEndFrame = [value CGRectValue];
    NSNumber *duration = [notification.userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey];
    
    [self showKeyBoardWithKeyFrame:keyEndFrame andDuration:[duration doubleValue]];
}

- (void) showKeyBoardWithKeyFrame:(CGRect)keyFrame andDuration:(NSTimeInterval) duration {
   
    CGFloat keyboardHeight = keyFrame.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsZero;
   self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resources[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifiere forIndexPath:indexPath];
    
    NSArray *section = self.resources[indexPath.section];
    SettinsCellModel *settingsModel = section[indexPath.row];

    [cell configWithModel:settingsModel andIndexPath:indexPath];
    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 150;
    }
    if (section == 1) {
        return 30;
    }
    return tableView.sectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (section == 0)
    {
        HeaderTableView *header =  [[HeaderTableView alloc] init];
        header.delegate = self;
        self.headerView = header;
        self.headerView.personImageView.image = [UIImage imageWithData:self.preferences.profileImageData];
        return header;
    }
    if (section == 1)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 0, 0)];
        headerLabel.font = [UIFont systemFontOfSize:12];
        headerLabel.text = @"Личная информация";
        headerLabel.textColor = [UIColor grayColor];
        [headerLabel sizeToFit];
        
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    return nil;
}

#pragma mark - Action

- (IBAction)saveButtonDidClicked:(id)sender
{
    for (NSArray *section in self.resources)
    {
        for (SettinsCellModel *cellModel in section)
        {
            [self.preferences setValue:cellModel.value forKey:cellModel.key];
        }
    }
    
    if (!(self.preferences.nikName.length && self.preferences.email.length && self.preferences.profileImageData.length))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Что-то забыли" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.preferences];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"preferences"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
       
      
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
       
             [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)changePhotoDidClickedInView:(HeaderTableView *)view
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
    //show date picker
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.8);
    self.preferences.profileImageData = imageData;
    
    
    //    [_imageView setImage:photo];
    self.headerView.personImageView.image = [UIImage imageWithData:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Utilites

- (void)buildSourceFromSettings:( Preferences *)preferences
{
    
    NSMutableArray *mutableSource = [NSMutableArray new];
    NSArray *firstSection = @[
                              [[SettinsCellModel alloc]initWithName:@"Имя" value:preferences.name format:kCellFormatString key:@"name"],
                              [[SettinsCellModel alloc]initWithName:@"Имя пользователя" value:preferences.nikName format:kCellFormatString key:@"nikName"],
                              [[SettinsCellModel alloc]initWithName:@"Веб-сайт" value:preferences.webPage format:kCellFormatString key:@"webPage"],
                              [[SettinsCellModel alloc]initWithName:@"О себе" value:preferences.about format:kCellFormatString key:@"about"],
                            
                              ];
    NSArray *secondSection = @[
                               [[SettinsCellModel alloc]initWithName:@"Электронная почта" value:preferences.email format:kCellFormatEmail key:@"email"],
                               [[SettinsCellModel alloc]initWithName:@"Телефон" value:preferences.phoneNumber format:kCellFormatNumber key:@"phoneNumber"],
                               [[SettinsCellModel alloc]initWithName:@"Пол" value:preferences.sex format:kCellFormatString key:@"sex"]
                               ];
    
    [mutableSource addObject:firstSection];
    [mutableSource addObject:secondSection];
    
    self.resources = [mutableSource copy];
}


@end
