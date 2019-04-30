//
//  THGoodsSpecModel.m
//  THYG
//
//  Created by Mac on 2018/4/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsSpecModel.h"

@implementation THGoodsSpecModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"defaultSpec":@"default"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"filter_spec":[THFilterSpecModel class],
             @"spec_goods_price":[THSpecDefaultModel class]
             };
}

@end


@implementation THFilterSpecModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"spec":[THItemSpecModel class]};
}

@end


@implementation THSpecDefaultModel

@end

@implementation THItemSpecModel

@end


