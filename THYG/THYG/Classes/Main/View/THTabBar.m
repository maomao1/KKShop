//
//  THTabBar.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTabBar.h"
#import "THTabBarButton.h"

@interface THTabBar ()
/** 选中的按钮 */
@property (nonatomic, weak) UIButton *selButton;
/** 中间的按钮 */
@property (nonatomic, weak) UIButton * publishButton;
/** 需要选中第几个 */
@property (nonatomic, assign) NSUInteger currentSelectedIndex;

@end

/** tabBarTag */
static NSInteger const THTabBarTag = 100000;

@implementation THTabBar

- (void)setItems:(NSArray *)items {
    _items = items;
    
    // UITabBarItem保存按钮上的图片
    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        if (i == 2) {
            self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.publishButton setImage:item.image forState:UIControlStateNormal];
            [self.publishButton setImage:item.selectedImage forState:UIControlStateSelected];
            [self.publishButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.publishButton.tag = self.subviews.count + THTabBarTag;
            [self addSubview:self.publishButton];
            
        } else {
            THTabBarButton *btn = [THTabBarButton buttonWithType:UIButtonTypeCustom];
            btn.tag = self.subviews.count + THTabBarTag;
            
            // 设置图片
            [btn setImage:item.image forState:UIControlStateNormal];
            [btn setImage:item.selectedImage forState:UIControlStateSelected];
            btn.adjustsImageWhenHighlighted = NO;
            // 设置文字
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:GRAY_102 forState:UIControlStateNormal];
            [btn setTitleColor:RED_COLOR forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:btn];
            // 子控件的个数
            NSInteger subViewsCount = 1;
            if (self.seletedIndex) {
                subViewsCount = self.seletedIndex + 1;
            }
            if (self.subviews.count == subViewsCount) {
                self.currentSelectedIndex = self.subviews.count - 1;
                // 默认选中第一个
                [self btnClick:btn];
            }
        }
    }
}

- (void)setDelegate:(id<THTabBarDelegate>)delegate{
    _delegate = delegate;
    [self btnClick:(THTabBarButton *)[self viewWithTag:self.currentSelectedIndex + THTabBarTag]];
}

- (void)btnClick:(UIButton *)btn {
    _selButton.selected = NO;
    btn.selected = YES;
    _selButton = btn;
    
    // 通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:btn.tag - THTabBarTag];
    }
}

/** 外界设置索引页跟着跳转 */
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    UIButton *button = [self viewWithTag:(THTabBarTag + seletedIndex)];
    [self btnClick:button];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    CGFloat h = 49;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
