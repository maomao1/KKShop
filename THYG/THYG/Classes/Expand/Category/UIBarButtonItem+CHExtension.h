//
//  UIBarButtonItem+CHExtension.h
//  CheHu
//
//  Created by Victory on 2017/6/12.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CHExtension)

/** 设置导航栏按钮图片，高亮图片，监听事件*/
+ (instancetype)itemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action;

/** 设置导航栏按钮标题， 标题颜色，文字大小，监听事件*/
+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont target:(id)target action:(SEL)action;

@end
