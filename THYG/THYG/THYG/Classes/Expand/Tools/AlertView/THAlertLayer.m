//
//  THAlertLayer.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAlertLayer.h"
#import "Utils.h"

@interface THAlertLayer ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UIView *textBackground;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *connectButton;
@property (nonatomic, strong) UILabel *errorLabel;

@end
#define kDurationTime 0.35
@implementation THAlertLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITE_COLOR;
        self.layer.cornerRadius = 5.f;
        [self addSubview:self.title];
        [self addSubview:self.content];
        [self addSubview:self.cancel];
        [self addSubview:self.sure];
        [self addSubview:self.textBackground];
        [self addSubview:self.textField];
        [self addSubview:self.connectButton];
        [self addSubview:self.errorLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upMove) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downMove) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneAction:) name:@"phone" object:nil];
    }
    return self;
}

- (void)updateConstraints {
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView.superview).with.insets(UIEdgeInsetsZero);
    }];
    if (self.errorLabel.text.length!=0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.superview);
            make.size.mas_equalTo(CGSizeMake(260, 165));
        }];
    }else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.superview);
            make.size.mas_equalTo(CGSizeMake(260, 155));
        }];
    }
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.title.superview);
        make.height.mas_equalTo(@49);
    }];
    [self.textBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textBackground.superview).with.offset(12);
        make.trailing.equalTo(self.textBackground.superview).with.offset(-12);
        make.top.equalTo(self.title.mas_bottom);
        make.height.mas_equalTo(@36);
    }];
    [self.connectButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textBackground);
        make.trailing.equalTo(self.textBackground).with.offset(-12);
    }];
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textBackground).with.offset(12);
        make.centerY.equalTo(self.textBackground);
        make.trailing.equalTo(self.connectButton.mas_leading);
    }];
    [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.content.superview);
        make.centerY.equalTo(self.textBackground);
        make.left.equalTo(self.textBackground.mas_left).offset(10);
        make.right.equalTo(self.textBackground.mas_right).offset(-10);
    }];
    [self.errorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textBackground);
        make.top.equalTo(self.textBackground.mas_bottom).with.offset(8);
    }];
    [self.cancel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cancel.superview).with.offset(12);
        make.bottom.equalTo(self.cancel.superview).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(112, 35));
    }];
    
    [self.sure mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.cancel.superview).with.offset(-12);
        make.bottom.equalTo(self.cancel.superview).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(112, 35));
    }];
    
    if (!self.alertModel.cancelBtnTitle.length) {
        [self.cancel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.cancel.superview).with.offset(12);
            make.bottom.equalTo(self.cancel.superview).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        [self.sure mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.cancel.superview).with.offset(-12);
            make.bottom.equalTo(self.cancel.superview).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(112*2, 35));
        }];
    }
    
    [super updateConstraints];
}

- (void)setAlertModel:(THAlertViewModel *)alertModel {
    if (_alertModel != alertModel) {
        _alertModel = alertModel;
        [self updateContent];
    }
}

- (void)updateContent {
    self.title.text = self.alertModel.title;
    self.content.text = self.alertModel.content;
    self.textField.placeholder = self.alertModel.placehold;
    self.textField.keyboardType = self.alertModel.keyboradType;
    [self.connectButton setImage:self.alertModel.textFieldRightImage forState:UIControlStateNormal];
    self.title.hidden = self.alertModel.title.length==0;
    self.content.hidden = self.alertModel.content.length==0;
    self.textBackground.hidden = self.alertModel.placehold.length==0;
    self.textField.hidden = self.alertModel.placehold.length==0;
    if (!self.alertModel.title.length) {
        [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.title.superview);
            make.height.mas_equalTo(0);
        }];
        [self.textBackground mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.top).offset(30);
        }];
    }
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}
- (void)upMove {
    if (SCREEN_HEIGHT==480) {
        [UIView animateWithDuration:kDurationTime animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -100);
        }];
    }else if (SCREEN_HEIGHT==568){
        [UIView animateWithDuration:kDurationTime animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -60);
        }];
    }
}

- (void)downMove {
    [UIView animateWithDuration:kDurationTime animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)errorInfo {
    self.errorLabel.text = @"您输入的手机号码有误！";
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

- (void)phoneAction:(NSNotification *)not {
    NSString *phone = not.object;
    self.textField.text = phone;
}

#pragma mark- actions

- (void)sureAction {
    if (![Utils CheckPhoneNum:self.textField.text]&&!self.textField.hidden) {
        [self errorInfo];
        return;
    }
    [self dismiss];
    if (self.sureBlock) {
        self.sureBlock(self.textField.text);
    }
}

- (void)show {
    if (!self.bgView.superview) {
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.bgView];
                break;
            }
        }
    }
    if (!self.superview) {
        [self.bgView addSubview:self];
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.superview);
        make.size.mas_equalTo(CGSizeMake(260, 155));
    }];
}

- (void)dismiss {
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)textFieldRightIconDidTapped {
    if (self.textFieldRightIconTappedHander) {
        self.textFieldRightIconTappedHander();
    }
}

#pragma mark- getter

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _bgView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = Font(16);
        _title.textColor = GRAY_COLOR(51);
    }
    return _title;
}

- (UILabel *)content {
    if (!_content) {
        _content = [UILabel new];
        _content.font = Font(14);
        _content.textColor = GRAY_COLOR(51);
        _content.numberOfLines = 0;
        _content.textAlignment = NSTextAlignmentLeft;
    }
    return _content;
}

- (UIButton *)cancel {
    if (!_cancel) {
        _cancel = [UIButton new];
        _cancel.backgroundColor = GRAY_COLOR(244);
        _cancel.titleLabel.font = Font(14);
        _cancel.layer.cornerRadius = 5.f;
        [_cancel.layer setMasksToBounds:YES];
        [_cancel setTitleColor:GRAY_COLOR(101) forState:UIControlStateNormal];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel;
}

- (UIButton *)sure {
    if (!_sure) {
        _sure = [UIButton new];
        _sure.backgroundColor = GLOBAL_RED_COLOR;
        _sure.titleLabel.font = Font(14);
        _sure.layer.cornerRadius = 5.f;
        [_sure.layer setMasksToBounds:YES];
        [_sure setBackgroundImage:[UIImage imageWithColor:GLOBAL_RED_COLOR] forState:UIControlStateNormal];
        [_sure setBackgroundImage:[UIImage imageWithColor:GLOBAL_RED_COLOR] forState:UIControlStateHighlighted];
        [_sure setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

- (UIView *)textBackground {
    if (!_textBackground) {
        _textBackground = [UIView new];
        _textBackground.layer.borderColor = GRAY_COLOR(244).CGColor;
        _textBackground.layer.borderWidth = .5f;
        _textBackground.layer.cornerRadius = 5.f;
        [_textBackground.layer setMasksToBounds:YES];
    }
    return _textBackground;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = Font(14);
        _textField.textColor = GLOBAL_RED_COLOR;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)connectButton {
    if (!_connectButton) {
        _connectButton = [UIButton new];
        [_connectButton addTarget:self action:@selector(textFieldRightIconDidTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [UILabel new];
        _errorLabel.font = Font(12);
        _errorLabel.textColor = [UIColor colorWithRed:255/255.f green:0 blue:0 alpha:1];
    }
    return _errorLabel;
}

#pragma mark- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.errorLabel.text = nil;
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    NSString * new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (new_text_str.length>self.alertModel.textFieldLength) {
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"phone" object:nil];
}
@end
