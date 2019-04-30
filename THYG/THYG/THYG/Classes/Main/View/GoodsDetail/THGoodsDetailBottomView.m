//
//  THGoodsDetailBottomView.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsDetailBottomView.h"
#define kSmallWidth SCREEN_WIDTH * 0.5
#define kBigWidth   SCREEN_WIDTH * 0.5

@interface THGoodsDetailBottomView ()

@end

@implementation THGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *titles = @[@"客服"/*,@"关注"*/,@"购物车",@"加入购物车"/*,@"立即购买"*/];
    NSArray *norImages = @[@"kefu"/*,@"guanzhu"*/,@"tianjiagouwuche"];
    NSArray *selImages = @[@"kefu"/*,@"guanzhu"*/,@"gouwuche_sel"];
    CGFloat bX = 0;
    CGFloat bW = 0;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (i < 2) {
            [btn setImage:IMAGENAMED(norImages[i]) forState:UIControlStateNormal];
            [btn setImage:IMAGENAMED(selImages[i]) forState:UIControlStateSelected];
//            if (i==1) {
//                [btn setTitle:@"已关注" forState:UIControlStateSelected];
//            }
        }
        btn.titleLabel.font = i < 2 ? Font11 : Font14;
        [btn setTitleColor:(i < 2)?GRAY_COLOR(110):WHITE_COLOR forState:UIControlStateNormal];
        [btn setBackgroundColor:((i == 2) ?  GLOBAL_RED_COLOR : WHITE_COLOR)];
//        [btn setBackgroundColor:((i > 2) ? ((i == 3) ? RGB(252, 85, 8): GLOBAL_RED_COLOR) : WHITE_COLOR)];
        if (i<2) {
            bW = kSmallWidth / 2 ;
            bX = bW * i;
        } else {
            bW = kBigWidth;
            bX = bW;
        }
        
        
//        if (i <= 3) {
//            if (i<3) {
//                bX = bW * i;
//            } else {
//                bX += kSmallWidth / 3;
//            }
//        } else {
//            bX += kBigWidth * 0.5;
//        }
        btn.frame = CGRectMake(bX, 0.8, bW, self.height-0.8);
        [btn addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i < 2) {
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
        }
    }
}

- (void)buttomButtonClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    !self.buttomButtonBlock?:self.buttomButtonBlock(tag);
}

@end
