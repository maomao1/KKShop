
//
//  THMyCollectCell.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyCollectCell.h"
#import "THMyCollectModel.h"

@implementation THMyCollectCell
{
    __weak IBOutlet UIImageView *goodsImgV;
    __weak IBOutlet UILabel *goodsNameLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
    
}

- (IBAction)addCartClick:(id)sender {
    
    if (self.addCartAction) {
        self.addCartAction();
    }
    
}

- (void)setModelData:(THMyCollectModel *)modelData {
    _modelData = modelData;
    if (![modelData.original_img containsString:@"http://"]) {
        modelData.original_img = [@"http://th1818.bingogd.com/" stringByAppendingString:modelData.original_img];
    }
    [goodsImgV sd_setImageWithURL:URL(modelData.original_img) placeholderImage:nil];
    goodsNameLabel.text = _modelData.goods_name;
    goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",_modelData.shop_price];
}

@end
