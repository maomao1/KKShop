//
//  THAddressModel.m
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressModel.h"

@implementation THAddressModel

@end

@implementation THAddressPCDModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"iD":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cityList":@"THAddressPCDModel",
             @"districtList":@"THAddressPCDModel"
             };
}

@end
