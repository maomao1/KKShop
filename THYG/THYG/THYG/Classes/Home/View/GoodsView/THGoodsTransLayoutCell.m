//
//  THGoodsTransLayoutCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsTransLayoutCell.h"
#import "THGoodsModel.h"

@interface THGoodsTransLayoutCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView; // 商品图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 商品名称
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel; // 商品价格
@property (weak, nonatomic) IBOutlet UILabel *commentRateLabel; // 好评率
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel; // 订单数量

@end

@implementation THGoodsTransLayoutCell

- (void)setGoodsModel:(THGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.original_img] placeholderImage:nil];
    self.nameLabel.text = _goodsModel.goods_name;
    self.marketPriceLabel.text = _goodsModel.shop_price;
    self.commentRateLabel.text = [NSString stringWithFormat:@"%@条评价",_goodsModel.comment_count];
    self.orderCountLabel.text = [NSString stringWithFormat:@"%@好评",_goodsModel.goods_ratio];
}

- (IBAction)addCartBtnClick:(id)sender {
    if (self.addCartAction) {
        self.addCartAction();
    }
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(135, self.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    [GRAY_COLOR(229) set];
    [path fill];
}

@end
