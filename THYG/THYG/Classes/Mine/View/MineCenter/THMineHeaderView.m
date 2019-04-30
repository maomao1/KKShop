//
//  THMineHeaderView.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineHeaderView.h"

@interface THMineHeaderView()
@property (nonatomic,strong) UIImageView *userImgView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *checkOnBtn;
@end

@implementation THMineHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self addSubview:self.headImgView];
		[self addSubview:self.userImgView];
		[self addSubview:self.userNameLabel];
        [self addSubview:self.checkOnBtn];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.offset(25);
		make.bottom.offset(-25);
		make.width.height.offset(56);
	}];
	
	[self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.userImgView.mas_right).offset(10);
		make.centerY.equalTo(self.userImgView.mas_centerY);
	}];
    
    [self.checkOnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.width.offset(60);
        make.height.offset(25);
    }];
	
}

- (void)refreshUI
{
    if ([TOKEN length]) {
        self.headImgView.image = IMAGENAMED(@"beijing");
        [self.userImgView sd_setImageWithURL:[NSURL URLWithString:UserInfo.head_pic] placeholderImage:IMAGENAMED(@"touxiang")];
        self.userNameLabel.text = UserInfo.nickname;
    } else {
        self.headImgView.image = IMAGENAMED(@"noLogin");
        self.userImgView.image = IMAGENAMED(@"touxiang");
        self.userNameLabel.text = @"登录 / 注册";
    }
}

- (void)gotoMotifyPage {
	if (self.gotoMotifyInfoPage) {
		self.gotoMotifyInfoPage();
	}
}

- (void)setIsSigned:(BOOL)isSigned {
	_isSigned = isSigned;
	self.checkOnBtn.selected = _isSigned;
}

#pragma mark - 签到
- (void)checkOnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    btn.backgroundColor = btn.selected ? RGB(255, 216, 0) : CLEARCOLOR;
    !self.checkOnBlock?:self.checkOnBlock();
}

- (UIImageView*)headImgView {
	if (_headImgView == nil) {
		_headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IOS_VERSION >= 11 ? 100 : 150)];
		_headImgView.image = [UIImage imageNamed:@"noLogin"];
	}
	return _headImgView;
}

- (UIImageView*)userImgView {
	if (_userImgView == nil) {
		_userImgView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"touxiang")];
		_userImgView.contentMode = UIViewContentModeScaleAspectFill;
		_userImgView.layer.cornerRadius = 28;
		_userImgView.clipsToBounds = YES;
		_userImgView.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMotifyPage)];
		[_userImgView addGestureRecognizer:tap];
	}
	return _userImgView;
}

- (UILabel*)userNameLabel {
	if (_userNameLabel==nil) {
		_userNameLabel = [[UILabel alloc]init];
		_userNameLabel.textColor = WHITE_COLOR;
        if (@available(iOS 8.2, *)) {
            _userNameLabel.font = [UIFont systemFontOfSize:16 weight:2];
        } else {
            // Fallback on earlier versions
        }
		_userNameLabel.text = @"登录 / 注册";
		_userNameLabel.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMotifyPage)];
		[_userNameLabel addGestureRecognizer:tap];
	}
	return _userNameLabel;
}

- (UIButton *)checkOnBtn {
    if (!_checkOnBtn) {
        _checkOnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkOnBtn setTitleColor:RGB(255, 216, 0) forState:UIControlStateNormal];
        [_checkOnBtn setTitleColor:RED_COLOR forState:UIControlStateSelected];
        [_checkOnBtn setBackgroundColor:CLEARCOLOR];
        _checkOnBtn.titleLabel.font = Font12;
        [_checkOnBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_checkOnBtn addTarget:self action:@selector(checkOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _checkOnBtn.layer.borderWidth = 1;
        _checkOnBtn.layer.cornerRadius = 12.5;
        _checkOnBtn.layer.borderColor = RGB(255, 216, 0).CGColor;
    }
    return _checkOnBtn;
}

@end
