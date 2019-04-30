//
//  THAddressCell.m
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressCell.h"
#import "THAddressModel.h"

@interface THAddressCell ()
// 收货人
@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;
// 手机号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
// 收货地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation THAddressCell

- (void)setAddressModel:(THAddressModel *)addressModel {
    _addressModel = addressModel;
    self.consigneeLabel.text = _addressModel.consignee;
    self.phoneLabel.text = _addressModel.mobile;
    self.addressLabel.text = _addressModel.full_address;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (CGFloat)cellHeight
{
    return 70;
}

@end
