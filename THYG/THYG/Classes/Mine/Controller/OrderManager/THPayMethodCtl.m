
//
//  THPayMethodCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPayMethodCtl.h"
#import "THPay.h"
#import "THPayMethodCell.h"
#import "THPaySuccessBlockPage.h"

@interface THPayMethodCtl ()
@property (weak, nonatomic) IBOutlet UILabel *payTotalMoneyLabel;

@end

@implementation THPayMethodCtl
{
    NSInteger _curSelectIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收银台";
    [self.view addSubview:self.dataTableView];
    self.dataTableView.height -= 50;
    self.payTotalMoneyLabel.text = [NSString stringWithFormat:@"实付款：%.2lf",self.totalPrice];
    [self.dataTableView registerNib:NIB(@"THPayMethodCell") forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THPayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *imgName = @[@"bank",@"pay",@"wx"][ROW];
    cell.icon.image = IMAGENAMED(imgName);
    cell.titleLabel.text = @[@"银行卡",@"支付宝支付",@"微信支付"][ROW];
    if (indexPath.row==_curSelectIndex) {
        cell.selectStatus.selected = YES;
    }else{
        cell.selectStatus.selected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _curSelectIndex = indexPath.row;
    [tableView reloadData];
}
- (IBAction)payBtnClick:(id)sender {
    
    [THNetworkTool POST:API(@"/pay/payOrder")
             parameters:@{@"token":TOKEN,
                          @"order_id":self.orderId,
                          @"pay_code":!_curSelectIndex ? @"unionpay" : (_curSelectIndex == 1 ? @"alipay" : @"weixin")
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 
                 if (!_curSelectIndex) {
                     [[THPay sharePay] weChatPay:responseObject[@"info"][@"pay"]];
                 }else{
                     [[THPay sharePay] aliPay:responseObject[@"info"][@"pay"]];
                 }
                 
             }];
    
    //微信支付成功回调
    [THPay sharePay].paySuccessByWeChatCallBack = ^(PayResp *resp) {
        
        [THHUD showSuccess:@"微信支付成功"];
        THPaySuccessBlockPage *page = [[THPaySuccessBlockPage alloc] init];
        [self pushVC:page];
        
    };
    
    //支付宝支付成功回调
    [THPay sharePay].paySuccessByAliPayCallBack = ^{
        
        [THHUD showSuccess:@"支付宝支付成功"];
        THPaySuccessBlockPage *page = [[THPaySuccessBlockPage alloc] init];
        [self pushVC:page];
        
    };
    
}



@end
