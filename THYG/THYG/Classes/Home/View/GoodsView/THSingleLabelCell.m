//
//  THSingleLabelCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSingleLabelCell.h"

@implementation THSingleLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        self.contentView.backgroundColor = GLOBAL_RED_COLOR;
        self.singleLabel.textColor = WHITE_COLOR;
    }else{
        self.contentView.backgroundColor = GRAY_COLOR(234);
        self.singleLabel.textColor = GRAY_COLOR(66);
    }
}

@end
