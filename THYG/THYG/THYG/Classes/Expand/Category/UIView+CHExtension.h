//
//  UIView+CHExtension.h
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CHExtension)

@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGPoint origin;

@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize  size;

/**
 *  返回view的控制器
 */
- (UIViewController *)viewController;

@end
