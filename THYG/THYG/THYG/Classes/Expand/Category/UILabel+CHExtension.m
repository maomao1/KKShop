//
//  UILabel+CHExtension.m
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import "UILabel+CHExtension.h"

@implementation UILabel (CHExtension)

+ (instancetype)labelWithText:(NSString *)text fontSize:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = color;
    return label;
}

@end
