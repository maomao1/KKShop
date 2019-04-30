//
//  UIButton+CHExtension.h
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^endtimeCallback)();
@interface UIButton (CHExtension)

/**
 * 快速创建UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImg fontSize:(UIFont *)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor radius:(CGFloat)radius target:(id)target action:(SEL)action;

/**
 * 创建UIButton (文字，图片)
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image fontSize:(UIFont *)size textColor:(UIColor *)textColor  target:(id)target action:(SEL)action;

/**
 * 通过图片创建按钮
 */
+ (instancetype)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImg target:(id)target action:(SEL)action;

/**
 * 通过背景图片创建按钮
 */
+ (instancetype)buttonWithBackgroundImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 * 通过标题创建按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title fontSize:(UIFont *)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action;

/**
 * 倒计时按钮
 */
- (void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle endTimeFinish:(endtimeCallback)endTimeFinishComplete;


@end
