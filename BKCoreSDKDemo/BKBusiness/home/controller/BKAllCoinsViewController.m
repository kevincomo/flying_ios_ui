//
//  BKAllCoinsViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/11.
//  Copyright © 2018年 wxl. All rights reserved.
//



#import "BKAllCoinsTableViewCell.h"

#import "BKAllCoinsViewController.h"


#define pageNumber  10


@interface BKAllCoinsViewController ()
{
    NSInteger page;
}
@property (strong, nonatomic) UITableView* tableViewMain;
@property (strong, nonatomic) NSMutableArray* arrCoins;

@end

@implementation BKAllCoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    [self.customNavTitleLabel setText:[BKUtils DPLocalizedString:@"选择货币"]];;
    [self addView];
    [self.view addSubview:self.customNavTitleLabel];
    
}

- (void)addView
{
    _tableViewMain = [[UITableView alloc] initWithFrame:NEWFRAME(0, 128, 750, (1334-88+40)) style:UITableViewStylePlain];
    if(is5_8inch_retina)
    {
        _tableViewMain.frame = NEWFRAME(0, 176, 750, (1624));
    }
    _tableViewMain.backgroundColor = MAIN_BG_GRAY;
    self.view.backgroundColor = MAIN_BG_GRAY;
    _tableViewMain.dataSource = (id)self;
    _tableViewMain.delegate = (id)self;
    _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableViewMain];
    
    self.arrCoins = [[NSMutableArray alloc] init];

    [self loadOnceData];
}


- (void)loadOnceData
{
    MJWeakSelf;
    [[BKCore sharedInstance] getCoinsWithType:@"all" withPage:page withPageCount:pageNumber withResult:^(NSArray<BKCoinDetailModel *> * arr, NSInteger total) {
        [weakSelf.arrCoins addObjectsFromArray:arr] ;
        
        if(weakSelf.arrCoins.count == total)
        {
            [self.tableViewMain reloadData];
            self.tableViewMain.mj_footer = nil;
        }
        else
        {
            page++;
            [self.tableViewMain reloadData];
            [ self.tableViewMain.mj_footer endRefreshing];
            
        }
    } withFail:^(BKErrorModel * err) {
        
    }];
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
    [[BKCore sharedInstance] addCoins:coinModel.cId withResult:^(BOOL bl) {
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
    [[BKCore sharedInstance] deleteCoin:coinModel.cId withResult:^(BOOL bl) {
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
