//
//  THShoppingCartModel.m
//  THYG
//
//  Created by Colin on 2018/4/10.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartModel.h"

@implementation THSuppliersModel

@end

@implementation THGoodsInfoModel

@end

@implementation THCartGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}
@end

@implementation THShoppingCartModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cart":@"THCartGoodsModel"
             };
}

@end
