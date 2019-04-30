//
//  THUserBaseInfo.h
//  THYG
//
//  Created by Colin on 2018/3/30.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THUserInfoModel.h"

@interface THUserBaseInfo : NSObject

@property (nonatomic,strong) THUserInfoModel *userInfoModel;

+ (THUserBaseInfo*)sharedUserBaseInfo;

@end
