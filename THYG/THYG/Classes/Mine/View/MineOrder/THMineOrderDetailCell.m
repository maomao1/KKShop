//
//  THMineOrderDetailCell.m
//  THYG
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THMineOrderDetailCell.h"

@interface THMineOrderDetailCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation THMineOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.btn];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.offset(15);
    }];
}

/**
 
 DetailCellTypeOrderStatus = 0, // 订单状态
 DetailCellTypeOrderInfo, // 订单信息
 DetailCellTypeShippingInfo, // 物流信息
 DetailCellTypeAddress, // 收货地址
 DetailCellTypeOthers // 其他
 
 */

- (void)setDetailType:(DetailCellType)detailType {
    _detailType = detailType;
    
    if (_detailType == 0) {
        self.detailLabel.textColor = RED_COLOR;
        self.detailLabel.font = Font14;
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5).priorityLow();
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
        
    } else if (_detailType == 1) {
        self.detailLabel.textColor = GRAY_51;
        self.detailLabel.font = Font12;
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
        
    } else if (_detailType == 2) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(15);
            make.right.offset(-44);
        }];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.bottom.offset(-15);
        }];
        
        
    } else if (_detailType == 3) {
        self.detailLabel.font = Font12;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.offset(15);
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.top.offset(15);
            make.width.offset(SCREEN_WIDTH-30-100-80);
        }];
        
        
    } else {
        self.detailLabel.font = Font12;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.offset(15);
        }];
        
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.btn.mas_left).offset(-20);
            make.centerY.equalTo(self.btn.mas_centerY);
        }];
        
    }
    
}

- (void)setDataSourceDict:(NSDictionary *)dataSourceDict {
    _dataSourceDict = dataSourceDict;
    self.titleLabel.text = _dataSourceDict[@"title"];
    self.subLabel.text = _dataSourceDict[@"sub"];
    self.detailLabel.text = _dataSourceDict[@"detail"];
}

#pragma mark - 复制到剪切板
- (void)copyClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.orderId;
    [THHUD showSuccess:@"复制成功"];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" fontSize:Font14 color:GRAY_51];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel labelWithText:@"" fontSize:Font12 color:GRAY_51];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [UILabel labelWithText:@"" fontSize:Font12 color:GRAY_51];
    }
    return _subLabel;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"复制" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = Font14;
        [_btn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
