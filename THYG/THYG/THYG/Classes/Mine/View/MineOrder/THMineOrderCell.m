//
//  THMineOrderCell.m
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderCell.h"
#import "THOrderModel.h"

@implementation THMineOrderCell
{
    __weak IBOutlet UILabel *orderNumberLabel;
    __weak IBOutlet UILabel *orderStatusLabel;
    __weak IBOutlet UILabel *goodsNameLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
    __weak IBOutlet UILabel *marketPriceLabel;
    __weak IBOutlet UILabel *unitLabel;
    __weak IBOutlet UILabel *specLabel;
    __weak IBOutlet UILabel *goosNumLabel;
    __weak IBOutlet UILabel *descriptLabel;
    __weak IBOutlet UIButton *deleteBtn;
    __weak IBOutlet NSLayoutConstraint *topLayout;
    
}

#pragma mark - 删除订单
- (IBAction)deleteOrder {
    !self.deleteOrderBlock?:self.deleteOrderBlock();
}

- (void)setCellType:(OrderCell)cellType {
    _cellType = cellType;
    orderNumberLabel.hidden = orderStatusLabel.hidden = deleteBtn.hidden = _cellType;
    topLayout.constant = _cellType ? -1 : 44;
}

- (void)setOrderListModel:(THOrderListModel *)orderListModel {
    _orderListModel = orderListModel;
    
    orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@", _orderListModel.order_sn];
    orderStatusLabel.text = _orderListModel.order_status_desc;
    goodsNameLabel.text = _orderListModel.goods_list[0].goods_name;
    goodsPriceLabel.text = _orderListModel.goods_list[0].goods_price;
    marketPriceLabel.text = _orderListModel.goods_list[0].market_price;
    goosNumLabel.text = [@"x" stringByAppendingString:_orderListModel.goods_list[0].goods_num];
    descriptLabel.text = [NSString stringWithFormat:@"共%@%@商品 合计：%.2f（含运费%@）", _orderListModel.goods_list[0].goods_num, _orderListModel.goods_list[0].unit, [_orderListModel.goods_list[0].goods_num floatValue] * [_orderListModel.goods_list[0].market_price floatValue], _orderListModel.shipping_price];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
