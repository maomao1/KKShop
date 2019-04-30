//
//  NSString+CHExtension.h
//  CheHu
//
//  Created by Victory on 2017/6/14.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CHExtension)
/**
 *  传入一个NSString，分割的标识符，返回一个NSAttributedString
 *  例如：@"123456<abcdefg>" ,从"<" 分割， "<"前面的字符串文字颜色和大小分别是font和color，从"<"直到结束文字的颜色和大小分别是subFont和subColor
 */
+ (NSAttributedString *)attributedStringWith:(NSString *)string charaterString:(NSString *)str color:(UIColor*)color subColor:(UIColor *)subColor font:(CGFloat)font subFont:(CGFloat)subFont;

// 时间戳转换
+ (NSString *)convertTimestamp:(NSString *)timeString;

+ (NSString *)convertSubTimestamp:(NSString *)timeString;

+ (NSString *)convertTimes:(NSString *)timeString;

+ (NSMutableAttributedString *)attributedStringWith:(NSString *)string charaterString:(NSString *)str superDick:(NSDictionary*)superDick subDick:(NSDictionary*)subDic;

/**
 *  得到当前时间
 *
 *  @return yyyyMMddHHmmssSSS
 */
+ (NSString *)getNowDate;


/**
 处理返回的html脏数据, 并适配Html中的图片
 @param string html脏数据
 @return 处理后的字符串
 */
+ (NSString *)fixImagesInHtmlString:(NSString *)string;

@end
