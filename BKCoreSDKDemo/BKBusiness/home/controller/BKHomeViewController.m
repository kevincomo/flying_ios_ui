//
//  BKHomeViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKHomeViewController.h"
#import "BKCoinsTableViewCell.h"
#import "BKCoinTableViewHeader.h"
#import "BKCoinDetailViewController.h"
#import "BKCoinQCCodeView.h"


@interface BKHomeViewController ()
{
    BKCoinTableViewHeader* tableViewHeader;
}
@property (strong, nonatomic) BKBalanceModel* totalBalance;

@property (strong, nonatomic) UITableView* tableViewMain;
@property (copy, nonatomic) NSArray* arrCoins;
@end

@implementation BKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.customNavTitleLabel setText:@"我的钱包"];
    self.customNavTitleLabel.textColor = [UIColor whiteColor];
    [self addView];
    [self.view addSubview:self.customNavTitleLabel];
    
    
    [self.rightButton setImage:[UIImage imageNamed:@"nav_add"] forState:0];
    [self.view addSubview:self.rightButton];
    
    MJWeakSelf;
    
    self.arrCoins = [[NSArray alloc] init];
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    //首页轮播图
    dispatch_group_enter(downloadGroup);
    
    
    [[BKCore sharedInstance] getCoinsWithType:@"default" withPage:1 withPageCount:10 withResult:^(NSArray<BKCoinDetailModel *> * arr, NSInteger total) {
        weakSelf.arrCoins = arr;
        
        dispatch_group_leave(downloadGroup);
    } withFail:^(BKErrorModel * err) {
        dispatch_group_leave(downloadGroup);
    }];
    
    
    dispatch_group_enter(downloadGroup);
    
    [[BKCore sharedInstance] getTotalBalance:^(BKBalanceModel *balanceModel) {
        
        weakSelf.totalBalance = balanceModel;
        dispatch_group_leave(downloadGroup);
    } withFail:^(BKErrorModel *errModel) {
        dispatch_group_leave(downloadGroup);
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        //结束刷新UI
        tableViewHeader.labelAmount.text = [NSString stringWithFormat:@"%@：%@",weakSelf.totalBalance.symbol,weakSelf.totalBalance.amount];
        [weakSelf.tableViewMain reloadData];
    });
    
}

- (void)addView
{
    _tableViewMain = [[UITableView alloc] initWithFrame:NEWFRAME(0, -40, 750, (1334-88+40)) style:UITableViewStylePlain];
    if(is5_8inch_retina)
    {
        _tableViewMain.frame = NEWFRAME(0, -88, 750, (1624));
    }
    _tableViewMain.backgroundColor = MAIN_BG_GRAY;
    self.view.backgroundColor = MAIN_BG_GRAY;
    _tableViewMain.dataSource = (id)self;
    _tableViewMain.delegate = (id)self;
    _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableViewMain];
    
    
    tableViewHeader = [[BKCoinTableViewHeader alloc] initWithFrame:NEWFRAME(0, 0, 750, 360)];
    if(is5_8inch_retina)
    {
        tableViewHeader.frame = NEWFRAME(0, 0, 750, 360+45);
    }
    _tableViewMain.tableHeaderView = tableViewHeader;
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
    BKCoinsTableViewCell *cell = (BKCoinsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKCoinsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MJWeakSelf;
    cell.coinDetail = [self.arrCoins objectAtIndex:indexPath.row];
    cell.blockQCCode = ^(BKCoinDetailModel* coinDetail){
        BKCoinQCCodeView* qcView = [[BKCoinQCCodeView alloc] initWithFrame:NEWFRAME(0, 0, 750, 1700)];
        qcView.coinDetail = [weakSelf.arrCoins objectAtIndex:indexPath.row];
        [weakSelf.view addSubview:qcView];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKCoinDetailViewController* coinDetail = [[BKCoinDetailViewController alloc] init];
   BKCoinDetailModel* coinDetailModel = [self.arrCoins objectAtIndex:indexPath.row];
    coinDetail.coinDetailModel = coinDetailModel;
    coinDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:coinDetail animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190*SCREEN_WIDTH/750;
    
}


//添加币种
- (void)rightBtnAction
{
    BKCoinDetailViewController* coinDetail = [[BKCoinDetailViewController alloc] init];
    coinDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:coinDetail animated:YES];
    
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
