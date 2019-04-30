//
//  THGoodsTopInfoCell.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsTopInfoCell.h"
#import "THGoosDetailModel.h"

@implementation THGoodsTopInfoCell
{
    __weak IBOutlet UILabel *goodsTitleLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
    __weak IBOutlet UILabel *kdPriceLabel;
    __weak IBOutlet UILabel *saleNumLabel;
    __weak IBOutlet UILabel *goodsFromLabel;
    __weak IBOutlet UIButton *focusBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [focusBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
}

- (void)setGoodsDetailModel:(THGoosDetailModel *)goodsDetailModel
{
    _goodsDetailModel = goodsDetailModel;
    goodsTitleLabel.text = _goodsDetailModel.goods_name;
    goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",_goodsDetailModel.shop_price];
    kdPriceLabel.text = @"快递：缺少字段值";
    saleNumLabel.text = [NSString stringWithFormat:@"月销%@笔",_goodsDetailModel.sales_sum];
    goodsFromLabel.text = @"缺少地点字段值";
    focusBtn.selected = _goodsDetailModel.isCollected;
}

- (IBAction)focusBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.focusBtnAction) {
        self.focusBtnAction(sender.selected);
    }
    
}


@end
