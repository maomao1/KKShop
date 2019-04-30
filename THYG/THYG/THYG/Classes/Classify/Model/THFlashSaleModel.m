//
//  THFlashSaleModel.m
//  THYG
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THFlashSaleModel.h"

@implementation THFlashSaleModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"iD":@"id", @"descript":@"description"};
}

@end
