//
//  Utils.h
//  THYG
//
//  Created by Victory on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/**
 MD5加密
 @param inputString 输入的字符串
 @result 加密后的字符串
 */
+ (NSString *)md5:(NSString *)inputString;

/**
 校验手机号码
 @param inputString 输入的手机号
 @result 是否是有效的手机号码
 */
+(BOOL)CheckPhoneNum:(NSString *)inputString;

/**
 正则匹配用户密码8-12位数字和字母组合
 @param inputString 输入的密码
 @result 校验密码是否符合要求
 */
+ (BOOL)checkPassword:(NSString *)inputString;

@end
