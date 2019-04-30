//
//  THHomeMallActivityItemCell.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeMallActivityItemCell.h"

@interface THHomeMallActivityItemCell ()
@property (nonatomic, strong) UIImageView * iconImgView;
@property (nonatomic, strong) UIImageView * goodsOneImgView;
@property (nonatomic, strong) UIImageView * goodsTwoImgView;
@property (nonatomic, strong) UILabel * iconLabel;
@property (nonatomic, strong) UILabel * subLabel;
@property (nonatomic, strong) UIView * timeView;
@end

@implementation THHomeMallActivityItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
	self.contentView.backgroundColor = WHITE_COLOR;
	[self.contentView addSubview:self.iconImgView];
	[self.contentView addSubview:self.goodsOneImgView];
	[self.contentView addSubview:self.goodsTwoImgView];
	[self.contentView addSubview:self.iconLabel];
	[self.contentView addSubview:self.subLabel];
	[self.contentView addSubview:self.timeView];
}

- (void)setItemType:(ActivityItemCellType)itemType {
	_itemType = itemType;
	self.timeView.hidden = itemType ? YES : NO;
	self.subLabel.hidden = !itemType ? YES : NO;
}

- (void)setItemDict:(NSDictionary *)itemDict {
	_itemDict = itemDict;
	self.iconImgView.image = IMAGENAMED(itemDict[@"icon"]);
	self.goodsOneImgView.image = IMAGENAMED(itemDict[@"oneImage"]);
	self.goodsTwoImgView.image = IMAGENAMED(itemDict[@"twoImage"]);
	self.iconLabel.text = itemDict[@"iconTitle"];
	self.subLabel.text = itemDict[@"subTitle"];
	
	if ([itemDict[@"iconTitle"] isEqualToString:@"团购"]) {
		self.iconLabel.textColor = RGB(61, 175, 239);
	}
	
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.offset(WIDTH(12));
		make.top.offset(HEIGHT(8));
		make.width.height.offset(WIDTH(17));
	}];
	
	[self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.iconImgView.mas_top);
		make.left.equalTo(self.iconImgView.mas_right).offset(WIDTH(5));
	}];
	
	[self.goodsTwoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.iconImgView.mas_top);
		make.right.bottom.offset(-WIDTH(8));
		make.width.offset(WIDTH(77));
		make.height.offset(HEIGHT(92));
	}];
	
	[self.goodsOneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.goodsTwoImgView.mas_bottom);
		make.right.equalTo(self.goodsTwoImgView.mas_left).offset(-WIDTH(8));
		make.width.offset(WIDTH(82));
		make.height.offset(HEIGHT(55));
	}];
	
	[self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImgView.mas_left);
		make.top.equalTo(self.iconImgView.mas_bottom).offset(HEIGHT(4));
	}];
	
	self.timeView.backgroundColor = RANDOMCOLOR;
	[self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImgView.mas_left);
		make.top.equalTo(self.iconImgView.mas_bottom).offset(HEIGHT(4));
		make.width.offset(60);
		make.height.offset(13);
	}];
	
}

- (UIImageView *)iconImgView {
	if (!_iconImgView) {
		_iconImgView = [[UIImageView alloc] init];
	}
	return _iconImgView;
}

- (UIImageView *)goodsOneImgView {
	if (!_goodsOneImgView) {
		_goodsOneImgView = [[UIImageView alloc] init];
	}
	return _goodsOneImgView;
}

- (UIImageView *)goodsTwoImgView {
	if (!_goodsTwoImgView) {
		_goodsTwoImgView = [[UIImageView alloc] init];
	}
	return _goodsTwoImgView;
}

- (UILabel *)iconLabel {
	if (!_iconLabel) {
		_iconLabel = [UILabel labelWithText:@"" fontSize:Font15 color:RED_COLOR];
	}
	return _iconLabel;
}

- (UILabel *)subLabel {
	if (!_subLabel) {
		_subLabel = [UILabel labelWithText:@"" fontSize:Font12 color:GRAY_COLOR(151)];
	}
	return _subLabel;
}

- (UIView *)timeView {
	if (!_timeView) {
		_timeView = [[UIView alloc] init];
	}
	return _timeView;
}

@end
