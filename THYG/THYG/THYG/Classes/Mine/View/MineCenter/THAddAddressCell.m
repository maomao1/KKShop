//
//  THAddAddressCell.m
//  THYG
//
//  Created by Mac on 2018/5/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddAddressCell.h"
#import "THAddressModel.h"

@interface THAddAddressCell () <UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation THAddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
            make.width.offset(70);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
            make.right.offset(-15);
            make.centerY.offset(0);
        }];
    }
    
    return self;
    
}

- (void)setModelData:(THAddressModel *)modelData {
    _modelData = modelData;
    self.titleLabel.text = _modelData.title;
    self.textField.placeholder = _modelData.placehold;
    if (_modelData.type==2) {
        self.textField.enabled = NO;
    }else{
        self.textField.enabled = YES;
    }
    self.textField.text = _modelData.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.getInsertValue) {
        self.getInsertValue(textField.text);
    }
}

- (UILabel*)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = Font(14);
        _titleLabel.textColor = RGB(17, 17, 17);
    }
    return _titleLabel;
}

- (UITextField*)textField {
    if (_textField==nil) {
        _textField = [[UITextField alloc]init];
        _textField.font = Font(14);
        _textField.textColor = RGB(17, 17, 17);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = @"请输入";
        _textField.delegate = self;
    }
    return _textField;
}


@end
