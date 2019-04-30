//
//  UIBarButtonItem+CHExtension.m
//  CheHu
//
//  Created by Victory on 2017/6/12.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import "UIBarButtonItem+CHExtension.h"

@implementation UIBarButtonItem (CHExtension)

+ (instancetype)itemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleFont == 0) {
        titleFont = 17.0;
    }
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
