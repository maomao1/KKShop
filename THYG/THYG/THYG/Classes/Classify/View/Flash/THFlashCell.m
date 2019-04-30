//
//  THFlashCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THFlashCell.h"
#import "THFlashSaleModel.h"

@implementation THFlashCell
{
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *nameLbel;
    __weak IBOutlet UILabel *shopPriceLabel;
    __weak IBOutlet UILabel *priceLabel;
    __weak IBOutlet UILabel *percentLabel;
    __weak IBOutlet UIProgressView *percentView;
}

- (void)setFlashModel:(THFlashSaleModel *)flashModel {
    _flashModel = flashModel;
    [imageView sd_setImageWithURL:URL(_flashModel.original_img) placeholderImage:[UIImage imageWithColor:BGColor]];
    nameLbel.text = _flashModel.goods_name;
    shopPriceLabel.text = [NSString stringWithFormat:@"￥%@",_flashModel.shop_price];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_flashModel.price];
    percentLabel.text = _flashModel.percent;
    percentView.progress = [[_flashModel.percent substringToIndex:_flashModel.percent.length-1] integerValue] / 100.0;
    
}

#pragma mark - 立即参团
- (IBAction)goToBuy {
    !self.gotoBuyClick?:self.gotoBuyClick();
}

@end

