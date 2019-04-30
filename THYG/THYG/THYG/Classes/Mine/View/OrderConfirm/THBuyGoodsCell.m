//
//  THBuyGoodsCell.m
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBuyGoodsCell.h"
#import "THCartDetailModel.h"

@implementation THBuyGoodsCell
{
    __weak IBOutlet UIImageView *goodsImgV;
    __weak IBOutlet UILabel *goodsNameLabel;
    __weak IBOutlet UILabel *goodsSpecValueLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
    __weak IBOutlet UILabel *goodsNumLabel;
}

- (void)setModelData:(THCartGoodListModel *)modelData
{
    _modelData = modelData;
    [goodsImgV sd_setImageWithURL:URL(_modelData.goods.original_img) placeholderImage:IMAGENAMED(@"")];
    goodsNameLabel.text = _modelData.goods_name;
    goodsSpecValueLabel.text = _modelData.spec_key_name;
    goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",_modelData.goods_price];
    goodsNumLabel.text = [NSString stringWithFormat:@"x%@",_modelData.goods_num];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 90;
}

@end
