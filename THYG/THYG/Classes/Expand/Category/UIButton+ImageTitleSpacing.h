//
//  UIButton+ImageTitleSpacing.h
//  YYButton
//
//  Created by Mac on 2016/5/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 *  @parma length 按钮要保留的的文字长度即为：length+1
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


/**
 *  @parma length 按钮要保留的的文字长度即为：length+1
 */
- (void)layoutButtonCustomWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                                   keepLength:(NSInteger)length
                              imageTitleSpace:(CGFloat)space;

/**
 *  @parma width 指定按钮的宽度
 */
- (void)layoutButtonCustomWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                                   width:(CGFloat)width
                              imageTitleSpace:(CGFloat)space;


@end
