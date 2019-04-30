//
//  THUserBaseInfo.m
//  THYG
//
//  Created by Colin on 2018/3/30.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserBaseInfo.h"


@implementation THUserBaseInfo

+ (THUserBaseInfo *)sharedUserBaseInfo
{
    static THUserBaseInfo *userinfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userinfo = [[THUserBaseInfo alloc]init];
    });
    return userinfo;
}

- (THUserInfoModel *)userInfoModel {
    if (!_userInfoModel) {
        _userInfoModel = [[THUserInfoModel alloc] init];
    }
    return _userInfoModel;
}

@end
