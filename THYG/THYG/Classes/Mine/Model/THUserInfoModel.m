//
//  THUserInfoModel.m
//  THYG
//
//  Created by Colin on 2018/3/30.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserInfoModel.h"

@implementation THUserInfoModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"nickname"] && [oldValue isKindOfClass:[NSNull class]]) {
        return self.mobile;
    }
    return oldValue;
}

@end
