//
//  THMineOrderDetailVC.m
//  THYG
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THMineOrderDetailVC.h"
#import "THMineOrderDetailCell.h"
#import "THMineOrderCell.h"
#import "THMineOrderFooterView.h"
#import "THMineOrderDetailToolView.h"
#import "THOrderModel.h"

@interface THMineOrderDetailVC ()
@property (nonatomic, strong) THOrderModel *orderModel;
@property (nonatomic, strong) THMineOrderDetailToolView *toolView;
@end

@implementation THMineOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getOrderDetails];
}

#pragma mark - setupUI
- (void)setupUI {
    self.title = @"订单详情";
    self.dataTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNaviHeight);
    [self.dataTableView registerClass:[THMineOrderDetailCell class] forCellReuseIdentifier:STRING(THMineOrderDetailCell)];
    [self.dataTableView registerNib:NIB(@"THMineOrderCell") forCellReuseIdentifier:STRING(THMineOrderCell)];
    [self.dataTableView registerClass:[THMineOrderFooterView class] forHeaderFooterViewReuseIdentifier:STRING(THMineOrderFooterView)];
    [self.view addSubview:self.dataTableView];
    
    [self.view addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(49);
    }];
    
}

#pragma mark - 获取订单详情
- (void)getOrderDetails {
    
    [THNetworkTool POST:API(@"/Order/detail") parameters:@{@"token":TOKEN, @"order_id":self.orderId} completion:^(id responseObject, NSDictionary *allResponseObject) {
        self.orderModel = [THOrderModel mj_objectWithKeyValues:responseObject[@"info"]];
        [self.dataTableView reloadData];
    }];

}

#pragma mark - 代理 & 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) return 4;
    if (section == 4) return 5;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *baseCell = nil;

    if (indexPath.section != 2 ) {
        
        THMineOrderDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineOrderDetailCell)];
        
        if (indexPath.section < 2 ) {
            detailCell.detailType = 0;
            detailCell.dataSourceDict = indexPath.section == 0 ? @{@"title":@"订单状态：", @"detail":self.orderModel ? self.orderModel.order_info.order_status_desc : @""} : @{@"title":@"物流信息： ", @"detail":@"占位"};
            
        } else if (indexPath.section == 3) {
            detailCell.detailType = [(@[@0, @1, @1, @3][indexPath.row]) integerValue];
            detailCell.dataSourceDict = @[@{@"title":@"收货信息"},
                                          @{@"title":@"收货人", @"detail":self.orderModel ? self.orderModel.order_info.consignee : @""},
                                          @{@"title":@"联系方式", @"detail":self.orderModel ? self.orderModel.order_info.mobile : @""},
                                          @{@"title":@"收货地址", @"detail":self.orderModel ? self.orderModel.order_info.address : @""}][indexPath.row];
            
        } else {
            detailCell.detailType = [(@[@0, @4, @1, @1, @3][indexPath.row]) integerValue];
            detailCell.dataSourceDict = @[@{@"title":@"订单信息"},
                                          @{@"title":@"订单号", @"detail":self.orderModel ? self.orderModel.order_info.order_sn : @""},
                                          @{@"title":@"支付方式", @"detail":self.orderModel ? self.orderModel.order_info.pay_name : @""},
                                          @{@"title":@"下单时间", @"detail":self.orderModel ? self.orderModel.order_info.add_time : @""},
                                          @{@"title":@"订单备注", @"detail":self.orderModel ? self.orderModel.order_info.user_note : @""}][indexPath.row];
            detailCell.orderId = self.orderModel.order_info.order_sn;
        }
        
        baseCell = detailCell;
    
    } else {
        
        THMineOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineOrderCell)];
        orderCell.cellType = 1;
        if (self.orderModel) {
            orderCell.orderListModel = self.orderModel.order_info;
        }
        baseCell = orderCell;
        
    }
    
    return baseCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        THMineOrderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STRING(THMineOrderFooterView)];
        THOrderListModel *model = self.orderModel.order_info;
        footer.orderStatus = self.type? [model.status integerValue] : [THOrderListModel orderTypeWithCode:model.order_status_code];
        footer.isReturnOrExchange = self.type;

        return footer;
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 130;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return DEFAULT_TABLEVIEW_HEADER_HEAGHT;
    }
    return MinFloat;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 44;
    }
    return DEFAULT_TABLEVIEW_HEADER_HEAGHT;
}

- (THMineOrderDetailToolView *)toolView {
    if (!_toolView) {
        _toolView = [THMineOrderDetailToolView toolView];
    }
    return _toolView;
}

@end
