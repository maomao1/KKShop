//
//  UILabel+CHExtension.h
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CHExtension)

/**
 * 快速创建UILabel
 */
+ (instancetype)labelWithText:(NSString *)text fontSize:(UIFont *)font color:(UIColor *)color;

@end
