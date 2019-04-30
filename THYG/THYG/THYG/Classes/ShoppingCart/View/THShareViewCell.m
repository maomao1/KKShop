//
//  THShareViewCell.m
//  THYG
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareViewCell.h"

@interface THShareViewCell ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation THShareViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.btn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.btn.frame = self.bounds;
    [self.btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:8];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [_btn setImage:[UIImage imageNamed:_imageName] forState:UIControlStateNormal];
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    [_btn setTitle:_iconName forState:UIControlStateNormal];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _btn.titleLabel.font = Font12;
        _btn.userInteractionEnabled = NO;
    }
    return _btn;
}

@end
