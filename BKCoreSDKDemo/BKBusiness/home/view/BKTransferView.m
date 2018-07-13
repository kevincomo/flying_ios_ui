//
//  BKTransferView.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKTransferView.h"
#import "BKTextField.h"
#import "BKTransferFeeTableViewCell.h"


typedef NS_ENUM(NSInteger, BTN_TYPE) {
    BTN_ALL = 100,  //全部提现
    BTN_OK          //确认转账
};

@interface BKTransferView ()

//转入地址
@property (nonatomic,strong) BKTextField* textFieldAddress;

//转入数量
@property (strong, nonatomic) BKTextField* textFieldAmount;

@property (strong, nonatomic) UITableView* tableViewMain;

@property (strong, nonatomic) UILabel* labelBalance;

@end

@implementation BKTransferView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        //获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(notice:) name:NOTICE_GET_QC object:nil];
        
        self.backgroundColor = HEXCOLOR(0xF4F4F4);
        UILabel* labelAccount = [[UILabel alloc] initWithFrame:NEWFRAME(40, 30, 200, 30)];
        labelAccount.text = [BKUtils DPLocalizedString:@"到账账号"];
        labelAccount.font = [UIFont systemFontOfSize:FONTNUMBER-3];
        labelAccount.backgroundColor = [UIColor clearColor];
        labelAccount.textColor = HEXCOLOR(0x3D4660);
        [self addSubview:labelAccount];
        
        
        BKTextField* textField = [BKTextField new];
        
        //完全自定义
        [textField addTextFieldToSuperView:self TextFieldFrame:NEWFRAME(30, 65, 690, 104) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"输入或者粘贴地址（如输错后果自负）"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor whiteColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"QC_icon" RightViewText:@""];
        
        _textFieldAddress = textField;
        
        MJWeakSelf;
        
        //点击右视图回调唤起扫描二维码
        _textFieldAddress.blockClickRight = ^{
            weakSelf.blockQC();
        };
        //监听文案的输入
        _textFieldAddress.clickTextFieldBlock = ^(NSString *text) {
            weakSelf.blockAdress(text);
        };
        
        
        int y = 155+44;
        UILabel* labelAmount = [[UILabel alloc] initWithFrame:NEWFRAME(40, y, 200, 30)];
        labelAmount.text = [BKUtils DPLocalizedString:@"提现数额"];
        labelAmount.font = [UIFont systemFontOfSize:FONTNUMBER-3];
        labelAmount.backgroundColor = [UIColor clearColor];
        labelAmount.textColor = HEXCOLOR(0x3D4660);
        [self addSubview:labelAmount];
        
        
        y+=35;
        BKTextField* textFieldAmount = [BKTextField new];
        
        //完全自定义
        [textFieldAmount addTextFieldToSuperView:self TextFieldFrame:NEWFRAME(30, y, 690, 104) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"请填写数额"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor whiteColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"login_icon_mob" RightViewText:@"BTC"];
        
        _textFieldAmount = textFieldAmount;
        
        
        _textFieldAmount.clickTextFieldBlock = ^(NSString *text) {
            weakSelf.blockAmount(text);
        };
        
        y+=65+44;
        //可用余额
        _labelBalance = [[UILabel alloc] initWithFrame:NEWFRAME(35, y, 300, 50)];
        
        _labelBalance.font = [UIFont systemFontOfSize:FONTNUMBER-3];
        _labelBalance.backgroundColor = [UIColor clearColor];
        _labelBalance.textColor = HEXCOLOR(0x9DA2B1);
        [self addSubview:_labelBalance];
        
        UIButton* btnPutCash = [UIButton buttonWithType:0];
        btnPutCash.tag = BTN_ALL;
        [btnPutCash setFrame:NEWFRAME(335, y, 100, 50)];
        [btnPutCash setTitleColor:HEXCOLOR(0x6195EB) forState:0];
        [btnPutCash setTitle:[BKUtils DPLocalizedString:@"全部提现"] forState:0];
        [btnPutCash addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnPutCash.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER-3];
        btnPutCash.backgroundColor = [UIColor clearColor];
        [self addSubview:btnPutCash];
        
        y+=80;
        //手续费
        
        _tableViewMain = [[UITableView alloc] initWithFrame:NEWFRAME(30, y, 690, 98*3) style:UITableViewStylePlain];
        if(is5_8inch_retina)
        {
            _tableViewMain.frame = NEWFRAME(30, y, 690, 98*3);
        }
        _tableViewMain.hidden = YES;
        _tableViewMain.backgroundColor = [UIColor whiteColor];
        _tableViewMain.dataSource = (id)self;
        _tableViewMain.delegate = (id)self;
        _tableViewMain.layer.cornerRadius = 8.0f;
        _tableViewMain.layer.masksToBounds = YES;
        _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableViewMain];
        
        y+=98*3+80;
        
        UIButton* btnOk = [UIButton buttonWithType:0];
        [btnOk setFrame:NEWFRAME(30, y, 690, 100)];
        btnOk.tag = BTN_OK;
        [btnOk setTitleColor:[UIColor whiteColor] forState:0];
        [btnOk setTitle:[BKUtils DPLocalizedString:@"确认转账"] forState:0];
        [btnOk addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnOk.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER];
        btnOk.backgroundColor = HEXCOLOR(0x5A647B);
        [self addSubview:btnOk];
        btnOk.layer.cornerRadius = 8.0f;
        btnOk.layer.masksToBounds = YES;
    }
    return self;
}

/**
 通知

 @param sender <#sender description#>
 */
-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    _textFieldAddress.textField.text = (NSString*)[sender object];
}

/**
 按钮

 @param btn <#btn description#>
 */
- (void)buttonDown:(UIButton*)btn
{
    if( btn.tag==BTN_ALL)
    {
        _textFieldAmount.text = _coinDetailModel.amount;
    }
    else if(btn.tag==BTN_OK)
    {
        _blockTransfer();
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
    
    return self.arrFee.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BKTransferFeeTableViewCell *cell = (BKTransferFeeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKTransferFeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MJWeakSelf;
    cell.coinFeeModel = [self.arrFee objectAtIndex:indexPath.row];
    cell.blockClickSec = ^{
        for(int i=0;i<weakSelf.arrFee.count;i++)
        {
            BKCoinFeeSecModel* feeModel = [weakSelf.arrFee objectAtIndex:i];
            if(i==indexPath.row)
            {
                feeModel.boolSec = YES;
                _blockCoinFee(feeModel);
            }
            else
            {
                feeModel.boolSec = NO;
            }
            
        }
        [tableView reloadData];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 98*SCREEN_WIDTH/750;
    
}

- (void)setCoinDetailModel:(BKCoinDetailModel *)coinDetailModel{
    _coinDetailModel = coinDetailModel;
    _textFieldAmount.rightViewText = coinDetailModel.coin;
    _labelBalance.text = [NSString stringWithFormat:[BKUtils DPLocalizedString:@"提现数额：%@"],coinDetailModel.amount];
}

- (void)setArrFee:(NSArray *)arrFee
{
    _arrFee = arrFee;
    _tableViewMain.hidden = NO;
    [_tableViewMain reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTICE_GET_QC object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
