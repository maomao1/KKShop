

//
//  THMoreLimitSpellGroupCell.m
//  THYG
//
//  Created by Colin on 2018/3/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMoreLimitSpellGroupCell.h"
#import "THFlashSaleModel.h"

@implementation THMoreLimitSpellGroupCell
{
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *nameLbel;
    __weak IBOutlet UILabel *shopPriceLabel;
    __weak IBOutlet UILabel *priceLabel;
    __weak IBOutlet UILabel *numLabel;
    __weak IBOutlet UIProgressView *percentView;
    __weak IBOutlet UILabel *limmitLabel;
    
}

- (void)setFlashModel:(THFlashSaleModel *)flashModel {
    _flashModel = flashModel;
    
    [imageView sd_setImageWithURL:URL(_flashModel.original_img) placeholderImage:[UIImage imageWithColor:BGColor]];
    nameLbel.text = _flashModel.goods_name;
    shopPriceLabel.text = [NSString stringWithFormat:@"￥%@", _flashModel.shop_price];
    priceLabel.text = [NSString stringWithFormat:@"￥%@", _flashModel.price];;
    numLabel.text = [NSString stringWithFormat:@"剩下%@个", _flashModel.goods_num];
    percentView.progress = [[_flashModel.percent substringToIndex:_flashModel.percent.length-1] integerValue] / 100.0;
    limmitLabel.text = [NSString stringWithFormat:@"成团数量%@个", _flashModel.buy_limit];
}

#pragma mark - 立即参团
- (IBAction)goToBuy {
    !self.gotoBuyClick?:self.gotoBuyClick();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
