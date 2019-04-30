//
//  THRegisterNextStepCtl.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

@interface THRegisterNextStepCtl : THBaseVC

@property (nonatomic, copy) NSString *phoneString;

@property (nonatomic, copy) NSString * uniqueId;

@property (assign, nonatomic) BOOL isForgetPwd; // 是否忘记密码

@end
