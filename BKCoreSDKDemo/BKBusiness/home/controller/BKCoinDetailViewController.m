//
//  BKCoinDetailViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinDetailViewController.h"
#import "BKCoinDetailTableViewHeader.h"
#import "BKCoinDetailTableViewCell.h"
#import "BKTransferViewController.h"
#import "BKCoinQCCodeView.h"


typedef NS_ENUM(NSInteger,BTN_TYPE){
    BTN_RECHARGE = 100,//充值
    BTN_TRANSFER    //转账
};

@interface BKCoinDetailViewController ()
{
    BKCoinDetailTableViewHeader* tableViewHeader;
}
@property (strong, nonatomic) UITableView* tableViewMain;
@property (strong, nonatomic) NSMutableArray* arrCoinDetail;

@end

@implementation BKCoinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.customNavTitleLabel setText:_coinDetailModel.name];
}

- (void)addView
{
    self.arrCoinDetail = [[NSMutableArray alloc] init];
    _tableViewMain = [[UITableView alloc] initWithFrame:NEWFRAME(0, 0, 750, (1334-88-108-40)) style:UITableViewStylePlain];
    if(is5_8inch_retina)
    {
        _tableViewMain.frame = NEWFRAME(0, 8, 750, (1624-176-108));
    }
    _tableViewMain.backgroundColor = MAIN_BG_GRAY;
    self.view.backgroundColor = MAIN_BG_GRAY;
    _tableViewMain.dataSource = (id)self;
    _tableViewMain.delegate = (id)self;
    _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollViewBg addSubview:_tableViewMain];
    
    
    tableViewHeader = [[BKCoinDetailTableViewHeader alloc] initWithFrame:NEWFRAME(0, 0, 750, 340+45)];
    if(is5_8inch_retina)
    {
        tableViewHeader.frame = NEWFRAME(0, 0, 750, 340+45);
    }
    tableViewHeader.coinDetailModel = _coinDetailModel;
    _tableViewMain.tableHeaderView = tableViewHeader;
    
    UIButton* btnRecharge = [UIButton buttonWithType:0];
    [btnRecharge setFrame:NEWFRAME(0, 1334-108, 375, 108)];
    [btnRecharge setTitle:@"充值" forState:0];
    btnRecharge.tag = BTN_RECHARGE;
    [btnRecharge addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
    [btnRecharge setTitleColor:[UIColor blackColor] forState:0];
    btnRecharge.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER-3];
    btnRecharge.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnRecharge];
    
    
    UIButton* btnTransfe = [UIButton buttonWithType:0];
    [btnTransfe setFrame:NEWFRAME(375, 1334-108, 375, 108)];
    [btnTransfe setTitle:@"转账" forState:0];
    [btnTransfe addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
    [btnTransfe setTitleColor:[UIColor whiteColor] forState:0];
    btnTransfe.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER-3];
    btnTransfe.backgroundColor = HEXCOLOR(0x5A647B);
    [self.view addSubview:btnTransfe];
    btnTransfe.tag = BTN_TRANSFER;
    
    if(is5_8inch_retina)
    {
        [btnTransfe setFrame:NEWFRAME(375, 1624-108-44, 375, 108)];
        [btnRecharge setFrame:NEWFRAME(0, 1624-108-44, 375, 108)];
    }
    
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
    
    return self.arrCoinDetail.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BKCoinDetailTableViewCell *cell = (BKCoinDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKCoinDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.tradeItemModel = [self.arrCoinDetail objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 148*SCREEN_WIDTH/750;
    
}


//添加币种
- (void)rightBtnAction
{
    
}

- (void)setCoinDetailModel:(BKCoinDetailModel *)coinDetailModel

{
    _coinDetailModel = coinDetailModel;
    
    [self addView];
    
   
    
    MJWeakSelf;
    //获取币种交易记录
    [[BKCore sharedInstance] getTradeHistory:_coinDetailModel.coin withPage:1 withPageCount:10 withResult:^( NSArray<BKTradeItemModel*>* arr,NSInteger total) {
        [weakSelf.arrCoinDetail addObjectsFromArray:arr];
        if(weakSelf.arrCoinDetail.count==total)
        {
            
            NSLog(@"没有更多了");
        }
        [weakSelf.tableViewMain reloadData];
        
    } withFail:^(BKErrorModel *err) {
       
    }];
    
    
}

//TODO:按钮代理
- (void)buttonDown:(UIButton*)btn
{
    switch(btn.tag)
    {
        case BTN_TRANSFER:
        {
            BKTransferViewController* transferVC = [[BKTransferViewController alloc] init];
            transferVC.coinDetailModel = _coinDetailModel;
            transferVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:transferVC animated:YES];
        }
            break;//转账
        case BTN_RECHARGE:
        {
            BKCoinQCCodeView* qcView = [[BKCoinQCCodeView alloc] initWithFrame:NEWFRAME(0, 0, 750, 1700)];
            qcView.coinDetail = _coinDetailModel;
            [self.view addSubview:qcView];
        }
            break;//充值
    }
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
