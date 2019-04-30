//
//  THAPI.h
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever 0
#define TestSever    0
#define ProductSever 1

/** 特惠易购前缀*/
UIKIT_EXTERN NSString *const THYGPrefix;

#pragma mark - 详细接口地址
/**
 接口统一命名格式： UIKIT_EXTERN NSString *const k(接口名称);
 */

/*-----------------------------  ----------------------------------*/
UIKIT_EXTERN NSString *const USER_INFO_KEY; // 用户信息归档的key

// UIKIT_EXTERN NSString *const k
UIKIT_EXTERN NSString *const kGetDeviceSession; // 服务器返回的唯一设备标识
