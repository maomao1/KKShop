//
//  THOrderConfirmPaymentCell.m
//  THYG
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THOrderConfirmPaymentCell.h"

@implementation THOrderConfirmPaymentCell
{
    __weak IBOutlet UIImageView *iconImgView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UIButton *selButton;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    selButton.selected = _isSelected;
}

- (void)setCellDict:(NSDictionary *)cellDict {
    _cellDict = cellDict;
    iconImgView.image = [UIImage imageNamed:_cellDict[@"iconImage"]];
    titleLabel.text = _cellDict[@"title"];
}

- (IBAction)selectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !self.selectedBlock?:self.selectedBlock(sender.selected);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


@end
