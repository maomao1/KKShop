//
//  THAddressEditListCell.m
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressEditListCell.h"
#import "THAddressModel.h"

@implementation THAddressEditListCell {
    __weak IBOutlet UILabel *consigneeLabel;
    __weak IBOutlet UILabel *mobileLabel;
    __weak IBOutlet UILabel *addressLabel;
    __weak IBOutlet UIButton *defaultBtn;
    __weak IBOutlet UIButton *editBtn;
    __weak IBOutlet UIButton *deleteBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [defaultBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    [editBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    [deleteBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    [self setLabelSpace:addressLabel value:@"" font:Font12 spacing:6];
}

- (void)setAddressModel:(THAddressModel *)addressModel {
    _addressModel = addressModel;
    consigneeLabel.text = _addressModel.consignee;
    mobileLabel.text = _addressModel.mobile;
    addressLabel.text = _addressModel.full_address;
    defaultBtn.selected = _addressModel.is_default;
}

#pragma mark - 设置默认地址
- (IBAction)setDefaultAddressClick {
    !self.setDefaultBlock?:self.setDefaultBlock();
}

#pragma mark - 删除地址
- (IBAction)deleteAddressClick {
    !self.deleteAddressBlock?:self.deleteAddressBlock();
}

#pragma mark - 修改地址
- (IBAction)editAddressClick {
    !self.motifyAddressBlock?:self.motifyAddressBlock();
}

- (void)setLabelSpace:(UILabel*)label value:(NSString*)str font:(UIFont*)font spacing:(CGFloat) spacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spacing; // 设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    // 设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
