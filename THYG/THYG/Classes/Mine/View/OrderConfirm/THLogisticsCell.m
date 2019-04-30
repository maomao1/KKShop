

//
//  THLogisticsCell.m
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THLogisticsCell.h"
#import "THCartDetailModel.h"

@implementation THLogisticsCell
{
    __weak IBOutlet UILabel *shippingLabel;
}

- (void)setModelData:(NSArray *)modelData
{
    _modelData = modelData;
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:@"在线支付\n商品对应物流："];
    for (THShippingListModel *model in modelData) {
        [mutStr appendFormat:@"%@、",model.name];
    }
    if (mutStr.length) {
        shippingLabel.text = [NSString stringWithFormat:@"%@",[mutStr substringToIndex:mutStr.length-1]];
    }
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
    return 100;
}

@end
