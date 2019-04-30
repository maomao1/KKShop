//
//  UIButton+CHExtension.m
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import "UIButton+CHExtension.h"

@implementation UIButton (CHExtension)

/**
 * 快速创建UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImg fontSize:(UIFont *)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor radius:(CGFloat)radius target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (image.length) [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (selectedImg.length) [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    [button setBackgroundColor:bgColor];
    button.titleLabel.font = size;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor;
        button.layer.borderWidth = 1;
    }
    if (radius) {
        button.layer.cornerRadius = radius;
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 * 创建UIButton (文字，图片)
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image fontSize:(UIFont *)size textColor:(UIColor *)textColor  target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (image.length) [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.titleLabel.font = size;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


/**
 * 通过图片创建按钮
 */
+ (instancetype)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImg target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image.length) [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (selectedImg.length) [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 * 通过背景图片创建按钮
 */
+ (instancetype)buttonWithBackgroundImage:(NSString *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image.length) [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
  * 通过标题创建按钮
  */
+ (instancetype)buttonWithTitle:(NSString *)title fontSize:(UIFont *)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = size;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    button.adjustsImageWhenHighlighted = NO;
    
    if (radius) {
        button.layer.cornerRadius = radius;
    }
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

- (void)startTime:(NSInteger)timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle endTimeFinish:(endtimeCallback)endTimeFinishComplete
{
    self.enabled = NO;
    __block NSInteger timeOut = timeout; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
				[self setTitle:tittle forState:UIControlStateNormal];
                self.enabled = YES;
                endTimeFinishComplete();
            });
            
        } else {
            NSString *strTime = [NSString stringWithFormat:@"%ld", (long)timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"重新获取(%@%@)",strTime,waitTittle] forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    
}
@end
