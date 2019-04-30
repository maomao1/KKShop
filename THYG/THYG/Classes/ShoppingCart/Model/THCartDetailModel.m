//
//  THCartDetailModel.m
//  THYG
//
//  Created by Victory on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCartDetailModel.h"

@implementation THCartDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userCartCouponList":@"user_cart_coupon_list",
             @"cartGoodsList":@"cart_goods_list",
             @"payPoints":@"member.pay_points",
             @"totalFee":@"cart_price_info.total_fee",
             @"goodsNum":@"cart_price_info.goods_num",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"shippingList":@"THShippingListModel",
             @"cartGoodsList":@"THCartGoodListModel",
             @"userCartCouponList":@"THCouponsModel"
             };
}

@end

@implementation THShippingListModel

@end


@implementation THCartGoodListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id"};
}

@end


@implementation THCartGoodModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"goodsSn":@"goods_sn"};
}

@end


