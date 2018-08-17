//
//  BKSearchCoinViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/20.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKSearchCoinViewController.h"
#import "BKAllCoinsTableViewCell.h"
#import "BKTextField.h"

@interface BKSearchCoinViewController ()

@property (strong, nonatomic) BKTextField* textFieldCoin;
@property (strong, nonatomic) UITableView* tableViewMain;
@property (strong, nonatomic) NSMutableArray* arrCoins;

@end

@implementation BKSearchCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrCoins = [[NSMutableArray alloc] init];
    [self addView];
    
    BKTextField* textFieldCoin = [BKTextField new];
    
    //完全自定义
    [textFieldCoin addTextFieldToSuperView:self.customNavView TextFieldFrame:NEWFRAME(30, 40+11, 600, 65) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"请填写币种"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor lightGrayColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"" RightViewText:@""];
    
    _textFieldCoin = textFieldCoin;
    
    textFieldCoin.textField.delegate = (id)self;
    textFieldCoin.textField.returnKeyType = UIReturnKeySearch;
    textFieldCoin.clickTextFieldBlock = ^(NSString *text) {
        
    };
    
    UIButton* btnPutCash = [UIButton buttonWithType:0];

    [btnPutCash setFrame:NEWFRAME(630, 40, 100, 88)];
    [btnPutCash setTitleColor:HEXCOLOR(0x6195EB) forState:0];
    [btnPutCash setTitle:[BKUtils DPLocalizedString:@"取消"] forState:0];
    [btnPutCash addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
    btnPutCash.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER];
    btnPutCash.backgroundColor = [UIColor clearColor];
    [self.customNavView addSubview:btnPutCash];
    
}

- (void)addView
{
    _tableViewMain = [[UITableView alloc] initWithFrame:NEWFRAME(0, 128, 750, (1334-128)) style:UITableViewStylePlain];
    if(is5_8inch_retina)
    {
        _tableViewMain.frame = NEWFRAME(0, 176, 750, (1624-176));
    }
    _tableViewMain.backgroundColor = MAIN_BG_GRAY;
    self.view.backgroundColor = MAIN_BG_GRAY;
    _tableViewMain.dataSource = (id)self;
    _tableViewMain.delegate = (id)self;
    _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableViewMain];
    
    self.arrCoins = [[NSMutableArray alloc] init];
    
}

- (void)buttonDown:(UIButton*)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - UISearchBarDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MJWeakSelf;
    if(textField.text.length>0)
    {
        [[BKCore sharedInstance] searchCoinWithType:textField.text withResult:^(NSMutableArray<BKCoinDetailModel*> *coin) {
            
            [weakSelf.arrCoins removeAllObjects];
            [weakSelf.arrCoins addObjectsFromArray:coin];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableViewMain reloadData];
            });
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    
    return YES;
}


#pragma mark - Table view data source


//设置tableview底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//设置section的个数


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return self.arrCoins.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BKAllCoinsTableViewCell *cell = (BKAllCoinsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKAllCoinsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MJWeakSelf;
    cell.blockSwitch = ^(BKCoinDetailModel *coinDetailModel) {
        //添加或者删除币种
        if([coinDetailModel.enable isEqualToString:@"on"])
        {
            [[BKCore sharedInstance] addCoins:coinDetailModel.coin withResult:^(BOOL bl) {
                
            } withFail:^(BKErrorModel * err) {
                
            }];
        }
        else
        {
            [[BKCore sharedInstance] deleteCoin:coinDetailModel.coin withResult:^(BOOL bl) {
                
            } withFail:^(BKErrorModel *err) {
                
            }];
        }
    };
    cell.coinDetail = [self.arrCoins objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190*SCREEN_WIDTH/750;
    
}

//添加列表
- (void)addCoins:(BKCoinDetailModel*)coinModel
{
    [[BKCore sharedInstance] addCoins:coinModel.coin withResult:^(BOOL bl) {
        if(bl)
        {
            //添加成功
        }
    } withFail:^(BKErrorModel *error) {
        
    }];
    
}

//删除列表
- (void)deleteCoins:(BKCoinDetailModel*)coinModel
{
    [[BKCore sharedInstance] deleteCoin:coinModel.coin withResult:^(BOOL bl) {
        if(bl)
        {
            //删除成功
        }
    } withFail:^(BKErrorModel *error) {
        
    }];
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

@end
