//
//  THOrderConfirmCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THOrderConfirmCtl.h"
#import "THAddressCell.h"
#import "THBuyGoodsCell.h"
#import "THLogisticsCell.h"
#import "THOrderConfirmListCell.h"
#import "THAddressVC.h"
#import "THAddressModel.h"
#import "THCartDetailModel.h"
#import "THCouponsModel.h"
#import "THOrderCouponModel.h"
#import "THUseCouponCtl.h"
#import "THPayMethodCtl.h"

@interface THOrderConfirmCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic, strong) NSArray *addressList;
@property (weak, nonatomic) IBOutlet UILabel *paytotalMoneyLabel;
@property (nonatomic, strong) THCartDetailModel *modelData;
@property (nonatomic, copy) NSString *invoiceNameParma;//发票抬头名称
@property (nonatomic, strong) THCouponsModel *couponsModel;
@property (nonatomic, strong) THAddressModel *selectAddressModel;//当前选择的地址
@property (nonatomic, strong) THOrderCouponModel *orderCouponModel;
@property (nonatomic, assign) NSInteger sectionCount;
@end

@implementation THOrderConfirmCtl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.invoiceNameParma = @"未开发票";
        self.couponsModel = [[THCouponsModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionCount = 7;
    // iOS11 适配
    if (@available(iOS 11, *)) {
        self.mTable.estimatedRowHeight = 0;
        self.mTable.estimatedSectionFooterHeight = 0;
        self.mTable.estimatedSectionHeaderHeight = 0;
    }
    [self.view addSubview:self.mTable];
    
    [self getOrder];
    
    [self getDefaultAddress];
    
}

#pragma mark - 订单页面相关数据
- (void)getOrder {
    
    [THNetworkTool POST:API(@"/Order/create") parameters:@{@"token":TOKEN, @"action":@"cart", @"cart_ids":self.cart_ids} completion:^(id responseObject, NSDictionary *allResponseObject) {
        self.modelData = [THCartDetailModel mj_objectWithKeyValues:responseObject[@"info"]];
        [self.mTable reloadData];
    }];
    
}

#pragma mark - 获取默认地址
- (void)getDefaultAddress {
    [THNetworkTool POST:API(@"/Address/getUserAddressList") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
        self.addressList = [THAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        for (THAddressModel *model in self.addressList) {
            if (model.is_default) {
                self.selectAddressModel = model;
            }
        }
        [self.mTable reloadData];
        [self caculateOrderPriceWithAct:nil];
    }];
}

#pragma mark -- 计算订单价格
- (void)caculateOrderPriceWithAct:(NSString *)act
{
    [THNetworkTool POST:API(@"/Order/submit")
             parameters:@{@"token":TOKEN,
                          @"goods_id":@"0",
                          @"goods_num":@"0",
                          @"item_id":@"0",
                          @"action":@"cart",
                          @"address_id":self.selectAddressModel.address_id.length?self.selectAddressModel.address_id:@"",
                          @"shipping_code":self.modelData.shippingList.count?self.modelData.shippingList[0].code:@"",
                          @"invoice_title":@"",
                          @"invoice_type":@"",//当invoice_title不为空时，这个参数必须传
                          @"pay_points":@"",
                          @"user_note":@"",
                          @"coupon_id":@(self.couponsModel.idField),
                          @"act":act?act:@""
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
        
                 if (!responseObject || [allResponseObject[@"status"] integerValue] == -3) {
                     [THHUD showMsg:allResponseObject[@"msg"]];
                     _sectionCount = 6;
                 }
                
                 //计算订单价格
                 if (!act.length) {
                     
                     self.orderCouponModel = [THOrderCouponModel mj_objectWithKeyValues:responseObject[@"info"][@"car_price"]];
                     self.paytotalMoneyLabel.text = [NSString stringWithFormat:@"实付款：%.2lf",self.orderCouponModel.payables];
                     [self.mTable reloadData];
                     
                 } else {
                     
                     if (!self.selectAddressModel) {
                         [HDAlertView showAlertViewWithTitle:nil message:@"您还没有收获地址哦，赶快去设置一个吧!" cancelButtonTitle:@"取消" otherButtonTitles:@[@"去设置"] handler:^(HDAlertView *alertView, NSInteger buttonIndex) {
                             THAddressVC *address = [[THAddressVC alloc] init];
                             address.getSelectAddress = ^(THAddressModel *addressModel) {
                                 self.selectAddressModel = addressModel;
                                 [self.mTable reloadData];
                                 [self caculateOrderPriceWithAct:nil];
                             };
                             [self pushVC:address];
                         }];
                     }else{
                         //生成订单
                         THPayMethodCtl *createSuccessCtl = [[THPayMethodCtl alloc] init];
                         createSuccessCtl.orderId = responseObject[@"info"][@"order_id"];
                         createSuccessCtl.totalPrice = self.orderCouponModel.payables;
                         [self pushVC:createSuccessCtl];
                     }
                 }
                 
    }];
}

#pragma mark -- 提交订单
- (IBAction)submitOrderAction:(id)sender {
    if (_sectionCount == 7) {
        [self caculateOrderPriceWithAct:@"submit_order"];
    } else {
        [THHUD showMsg:@"请先填写收货地址"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_sectionCount == 7) {
        
        if (section == 0 || section == 2 || section == 5) {
            return 1;
        } else if (section == 1) {
            return self.modelData.cartGoodsList.count;
        } else {
            return 2;
        }
        
    } else {
        
        if (section == 1 || section == 4) {
            return 1;
        } else if (section == 0) {
            return self.modelData.cartGoodsList.count;
        } else {
            return 2;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_sectionCount == 7) {
        if (SECTION == 0) {
            return [THAddressCell cellHeight];
        } else if (SECTION == 1) {
            return [THBuyGoodsCell cellHeight];
        } else if (SECTION == 2) {
            return [THLogisticsCell cellHeight];
        } else {
            return [THOrderConfirmListCell cellHeight];
        }
        
    } else {
        
        if (SECTION == 0) {
            return [THBuyGoodsCell cellHeight];
        } else if (SECTION == 1) {
            return [THLogisticsCell cellHeight];
        } else {
            return [THOrderConfirmListCell cellHeight];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return MinFloat;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_sectionCount == 7) {
        if (SECTION < 3) {
            if (SECTION == 0) {
                return [self addressCell:tableView];
            } else if (SECTION == 1) {
                return [self buyGoodsCell:tableView indexPath:indexPath];
            } else {
                return [self logisticsCell:tableView];
            }
            
        } else {
            return [self orderConfirmListCell:tableView indexPath:indexPath];
        }
        
    } else {
        if (SECTION < 2) {
            if (SECTION == 0) {
                return [self buyGoodsCell:tableView indexPath:indexPath];
            } else {
                return [self logisticsCell:tableView];
            }
        } else {
            return [self orderConfirmListCell:tableView indexPath:indexPath];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (!SECTION) {
        //选择收货地址
        THAddressVC *addressVc = [[THAddressVC alloc] init];
        addressVc.getSelectAddress = ^(THAddressModel *addressModel) {
            self.selectAddressModel = addressModel;
            [self.mTable reloadData];
            [self caculateOrderPriceWithAct:nil];
        };
        [self pushVC:addressVc];
    }else if (SECTION == 4 && ROW == 0){
        //选择优惠券
        THUseCouponCtl *selectCouponCtl = [[THUseCouponCtl alloc] init];
        selectCouponCtl.dataSourceArray = self.modelData.userCartCouponList.mutableCopy;
        selectCouponCtl.selectCouponBlock = ^(THCouponsModel *couponModel) {
            self.couponsModel = couponModel;
            [self.mTable reloadData];
            [self caculateOrderPriceWithAct:nil];
        };
        [self pushVC:selectCouponCtl];
    }
    
}

#pragma mark - 地址cell
- (UITableViewCell*)addressCell:(UITableView *)tableView {
    THAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THAddressCell)];
    cell.addressModel = self.selectAddressModel;
    return cell;
}

#pragma mark - THBuyGoodsCell
- (UITableViewCell*)buyGoodsCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THBuyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THBuyGoodsCell)];
    cell.modelData = self.modelData.cartGoodsList[indexPath.row];
    return cell;    
}

#pragma mark - THLogisticsCell
- (UITableViewCell*)logisticsCell:(UITableView *)tableView {
    THLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THLogisticsCell)];
    cell.modelData = self.modelData.shippingList;
    return cell;
}

#pragma mark - THOrderConfirmListCell
- (UITableViewCell *)orderConfirmListCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THOrderConfirmListCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THOrderConfirmListCell)];
    NSInteger currentRow = _sectionCount == 7 ? 3 : 2;
    NSLog(@"每一行展示的数据>>>>>%@",@[@[@"发票",self.invoiceNameParma],
                               @[@"使用优惠券",self.couponsModel.name.length?self.couponsModel.name:@"暂无优惠"],
                               @[@"备注"],
                               @[@"商品金额",@"运费"]
                               ][SECTION-currentRow][ROW]);
    cell.leftLabel.text = @[@[@"发票",self.invoiceNameParma],
                            @[@"使用优惠券",self.couponsModel.name.length?self.couponsModel.name:@"暂无优惠券可用"],
                            @[@"备注"],
                            @[@"商品金额",@"运费"]
                            ][SECTION-currentRow][ROW];
    cell.rightLabel.text = @[@[@"未开发票",@""],
                             @[[NSString stringWithFormat:@"%ld张可用",self.modelData.userCartCouponList.count],@""],
                             @[@""],
                             @[[NSString stringWithFormat:@"￥%.2lf",self.orderCouponModel.goodsFee],[NSString stringWithFormat:@"￥%.2lf",self.orderCouponModel.postFee]]][SECTION-currentRow][ROW];
    return cell;
}

#pragma mark - 懒加载
- (NSArray *)addressList {
    if (!_addressList) {
        _addressList = [NSArray array];
    }
    return _addressList;
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNaviHeight - 50) style:UITableViewStyleGrouped];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        [_mTable registerNib:NIB(STRING(THAddressCell)) forCellReuseIdentifier:STRING(THAddressCell)];
        [_mTable registerNib:NIB(STRING(THBuyGoodsCell)) forCellReuseIdentifier:STRING(THBuyGoodsCell)];
        [_mTable registerNib:NIB(STRING(THLogisticsCell)) forCellReuseIdentifier:STRING(THLogisticsCell)];
        [_mTable registerNib:NIB(STRING(THOrderConfirmListCell)) forCellReuseIdentifier:STRING(THOrderConfirmListCell)];
    }
    return _mTable;
}

@end
