//
//  THMineOrderHeaderCell.m
//  THYG
//
//  Created by Victory on 2018/3/16.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderHeaderCell.h"
#define bX SCREEN_WIDTH / 5

@interface THMineOrderHeaderCell () {
	NSArray * _imageArr;
	NSArray * _titleArr;
}

@end

@implementation THMineOrderHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
	_imageArr = @[@"daifukuan", @"daishouhuo", @"daipingjia", @"tuihuanhuo", @"quanbudingdan"];
	_titleArr = @[@"待付款", @"待收货", @"待评价", @"退/换货", @"全部订单"];
	for (NSInteger i = 0; i <5; i++) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = i + bX;
		[button setTitle:_titleArr[i] forState:UIControlStateNormal];
		[button setTitleColor:GRAY_COLOR(51) forState:UIControlStateNormal];
		[button setImage:IMAGENAMED(_imageArr[i]) forState:UIControlStateNormal];
		button.titleLabel.font = Font13;
		[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
		button.frame = CGRectMake(bX * i, 0, bX, 65);
		[button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:12];
		[self.contentView addSubview:button];
	}
}

- (void)buttonAction:(UIButton *)button {
	!self.orderAction?:self.orderAction(button.tag - bX);
}

@end
