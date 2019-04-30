//
//  THCreateOrderSuccessCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCreateOrderSuccessCtl.h"
#import "THPayMethodCtl.h"
#import "THOrderConfirmPayButtomView.h"
#import "THOrderConfirmPaymentCell.h"
#import "THPay.h"
#import "THPaySuccessBlockPage.h"

@interface THCreateOrderSuccessCtl () {
    NSArray * _itemArray;
}
@property (nonatomic, strong) THOrderConfirmPayButtomView *payView;
@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation THCreateOrderSuccessCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI
- (void)setupUI {
    
    self.title = @"收银台";
    [self.view addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kTabBarHeight);
    }];
    
    self.dataTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-kTabBarHeight);
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerNib:NIB(@"THOrderConfirmPaymentCell") forCellReuseIdentifier:STRING(THOrderConfirmPaymentCell)];
    
    _itemArray = @[@{@"iconImage":@"bank", @"title":@"银行卡"},
                   @{@"iconImage":@"pay", @"title":@"支付宝"},
                   @{@"iconImage":@"wx", @"title":@"微信"}];
    
    self.payView.price = [NSString stringWithFormat:@"￥%.2f", self.totalPrice];
    
    #pragma mark - 立即支付
    @weakify(self);
    self.payView.payBlock = ^{
        @strongify(self);
        
        if (self.currentRow > 1) {
            [self payMethod];
        }
        
        if (!self.currentRow) {
            [THHUD showMsg:@"请选择支付方式"];
        }
        
    };
    
}

#pragma mark - payMethod
- (void)payMethod {
    
    [THNetworkTool POST:API(@"/pay/payOrder")
             parameters:@{@"token":TOKEN,
                          @"order_id":self.orderId,
                          @"pay_code":(self.currentRow - 1 == 1) ? @"weixin" : @"alipay"
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 
                 if (self.currentRow == 1) {
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

#pragma mark - tableView 数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THOrderConfirmPaymentCell * cell = [tableView dequeueReusableCellWithIdentifier:STRING(THOrderConfirmPaymentCell)];
    cell.cellDict = _itemArray[indexPath.row];
    
    @weakify(cell);
    cell.selectedBlock = ^(BOOL isSelected) {
        @strongify(cell);
        if (isSelected && indexPath.row) {
            [tableView.visibleCells enumerateObjectsUsingBlock:^(THOrderConfirmPaymentCell * cell, NSUInteger row, BOOL * _Nonnull stop) {
                cell.isSelected = NO;
            }];
            cell.isSelected = YES;
            _currentRow = indexPath.row + 1;
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return MinFloat;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - 懒加载
- (THOrderConfirmPayButtomView *)payView {
    if (!_payView) {
        _payView = [THOrderConfirmPayButtomView payButtomView];
    }
    return _payView;
}

//#pragma mark -- 立即支付
//- (IBAction)payBtnClick:(id)sender {
//    
//    THPayMethodCtl *pay = [[THPayMethodCtl alloc] init];
//    pay.orderId = self.orderId;
//    pay.totalPrice = self.totalPrice;
//    [self pushVC:pay];
//}
//
//#pragma matk -- 再去逛逛
//- (IBAction)viewOtherBtn:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

@end
