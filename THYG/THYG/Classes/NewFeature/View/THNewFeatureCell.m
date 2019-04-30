//
//  THNewFeatureCell.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THNewFeatureCell.h"
#import "THTabBarController.h"

@interface THNewFeatureCell ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subLabel;
@end

@implementation THNewFeatureCell

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// 图片
		if (!_imageView) {
			_imageView = [[UIImageView alloc]init];
			[self.contentView addSubview:_imageView];
		}
		
//		if (!_titleLabel) {
//			_titleLabel = [UILabel labelWithText:@"" fontSize:Font(30) color:BLACK_COLOR];
//			[self.contentView addSubview:_titleLabel];
//		}
//
//		if (!_subLabel) {
//			_subLabel = [UILabel labelWithText:@"" fontSize:Font(18) color:BLACK_COLOR];
//			[self.contentView addSubview:_subLabel];
//		}
		
		// 全新起航按钮
		if (!_button) {
			_button = [[UIButton alloc]init];
			_button.layer.cornerRadius = 4;
			_button.clipsToBounds = YES;
			[_button setBackgroundColor:RGB(254, 85, 46)];
			[_button setTitle:@"立即体验" forState:UIControlStateNormal];
//			[_button setBackgroundColor:CLEARCOLOR];
			_button.hidden = true;
			[_button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:_button];
		}
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
//	[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.mas_equalTo(UIEdgeInsetsZero);
//	}];
	
	[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.offset(0);
		make.left.offset(12);
		make.right.offset(-12);
		make.height.offset(SCREEN_WIDTH-24);
	}];
	
//	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(self.imageView.mas_bottom).offset(55);
//		make.centerX.equalTo(self.contentView.mas_centerX);
//	}];
//
//	[self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
//		make.centerX.equalTo(self.contentView.mas_centerX);
//	}];
	
	[self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.equalTo(self.contentView.mas_centerX);
//		make.height.offset(SCREEN_HEIGHT/2);
//		make.width.offset(SCREEN_WIDTH);
//		make.bottom.offset(0);
		
		make.centerX.equalTo(self.contentView.mas_centerX);
		make.height.offset(44);
		make.width.offset(100);
		make.top.equalTo(self.imageView.mas_bottom).offset(50);
		
	}];
	
}

- (void)setItemDict:(NSDictionary *)itemDict {
	_itemDict = itemDict;
	self.imageView.image = IMAGENAMED(itemDict[@"image"]);
//	self.titleLabel.text = itemDict[@"title"];
//	self.subLabel.text = itemDict[@"subTitle"];
}

// 点击立即体验按钮调用
- (void)start {
	
	// 修改窗口的根控制器 TabBarVC
	THTabBarController *tabbarVc = [[THTabBarController alloc] init];
	[UIApplication sharedApplication].keyWindow.rootViewController = tabbarVc;
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	// 在点击全新起航的按钮才记录 版本号
	NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
	[defaults setObject:currentVersion forKey:versionKey];
	[defaults synchronize];
}

- (void)setLastIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
	if (indexPath.item == count - 1) { // 当前cell是最后一个cell
		self.button.hidden = NO;
	}else{ // 如果不是最后一个cell,
		self.button.hidden = YES;
	}
}

@end
