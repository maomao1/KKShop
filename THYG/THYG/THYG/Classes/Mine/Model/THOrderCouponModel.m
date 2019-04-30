//
//  THOrderCouponModel.m
//  THYG
//
//  Created by 廖辉 on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THOrderCouponModel.h"

@implementation THOrderCouponModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return oldValue;
}

@end
