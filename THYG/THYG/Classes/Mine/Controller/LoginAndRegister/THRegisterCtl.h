//
//  THRegisterCtl.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

typedef NS_ENUM(NSUInteger, THRegisterCtlType) {
	THRegisterCtlTypeRegister = 0, // 注册
	THRegisterCtlTypeForgetPwd, // 忘记密码
};

@interface THRegisterCtl : THBaseVC

@property (assign, nonatomic) THRegisterCtlType type;

@end
