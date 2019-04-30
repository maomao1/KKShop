//
//  THAPI.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAPI.h"

#if DevelopSever
NSString *const THYGPrefix = @"http://47.98.148.224/api/v100";

#elif TestSever
NSString *const THYGPrefix = @"http://mp.wushibu.cn/index.php/api/v100";

#elif ProductSever
NSString *const THYGPrefix = @"http://th1818.bingogd.com/api/v100";

#endif

NSString *const USER_INFO_KEY = @"USER_INFO_KEY"; // 用户信息归档的key

/**
 统一格式： NSString *const k(接口名称<与.h里一一对应>) = @"拼接路径";
 */

/*-----------------------------  常量 ----------------------------------*/
//NSString *const xxx = @""
NSString *const kGetDeviceSession = @"/System/getDeviceSession"; // 服务器返回的唯一设备标识
