//
//  SystemTools.h
//  Comment
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemTools : NSObject

/**
 获取APP版本号
 */
+ (NSString *)getAppVersion;

/**
 获取设备唯一标识
 */
+ (NSString *)getDeviceId;

/**
 获取设备型号
 */
+ (NSString *)getDeviceModel;

/**
 获取设备类型
 */
+ (NSString *)getDeviceType;

/**
 获取设备操作系统版本号
 */
+ (NSString *)getDeviceVersion;

/**
 当前系统语言 规范：小写+下划线（如：zh_cn,zh_tw,en_us）
 */
+ (NSString *)getLanguage;




@end
