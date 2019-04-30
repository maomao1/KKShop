//
//  THGoodsHeaderView.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface THGoodsHeaderView () <SDCycleScrollViewDelegate>
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation THGoodsHeaderView

#pragma mark - Intial
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.contentView.backgroundColor = BGColor;
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView addSubview:self.label];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
//    ZLPhotoActionSheet *sheet = [[ZLPhotoActionSheet alloc]init];
//    sheet.sender = self.sender;
//    sheet.navBarColor = GLOBAL_ORANGE_COLOR;
//    [sheet previewPhotos:self.data index:index hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    
//    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.label.text = [NSString stringWithFormat:@"%ld/%ld", index+1, self.bannerImageArray.count];
}


#pragma mark - Setter Getter Methods
- (void)setBannerImageArray:(NSArray *)bannerImageArray {
    _bannerImageArray = bannerImageArray;
    _cycleScrollView.imageURLStringsGroup = bannerImageArray;
    self.label.text = [NSString stringWithFormat:@"1/%ld", self.bannerImageArray.count];
    //[self.data removeAllObjects];
//    for (NSString *url in _bannerImageArray) {
//        [self.data addObject:[NSURL URLWithString:url]];
//    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(SCREEN_WIDTH);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-MARGIN);
        make.bottom.offset(-MARGIN-5);
        make.width.offset(44);
        make.height.offset(MARGIN+5);
    }];
    
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGENAMED(@"zhutu")];
        _cycleScrollView.pageDotColor = [WHITE_COLOR colorWithAlphaComponent:0.6];
        _cycleScrollView.autoScroll = YES; // 不自动滚动
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.backgroundColor = BGColor;
    }
    return _cycleScrollView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelWithText:@"" fontSize:Font(14) color:WHITE_COLOR];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = GRAY(0, 0.6);
        _label.layer.cornerRadius = 4;
        _label.layer.masksToBounds = YES;
    }
    return _label;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    [LINECOLOR set];
    [path fill];
}

@end
