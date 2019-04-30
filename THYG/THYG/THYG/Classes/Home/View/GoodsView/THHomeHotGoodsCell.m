//
//  THHomeHotGoodsCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeHotGoodsCell.h"
#import "THGoodsModel.h"

@interface THHomeHotGoodsCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsMarketPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *highOpinionLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumber;

@end

@implementation THHomeHotGoodsCell

- (void)setGoodsModel:(THGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.original_img] placeholderImage:nil];
    self.goodNameLabel.text = _goodsModel.goods_name;
    self.goodsMarketPriceLabel.text = _goodsModel.shop_price;
    self.highOpinionLabel.text = [NSString stringWithFormat:@"%@条评价",_goodsModel.comment_count];
    self.saleNumber.text = [NSString stringWithFormat:@"%@好评",_goodsModel.goods_ratio];
}

- (IBAction)addCartBtnClick:(id)sender {
    if (self.addCartAction) {
        self.addCartAction();
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = GRAY_COLOR(229).CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
}

@end
