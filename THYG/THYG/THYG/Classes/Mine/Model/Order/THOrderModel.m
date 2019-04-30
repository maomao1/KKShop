//
//  THOrderModel.m
//  THYG
//
//  Created by Victory on 2018/6/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THOrderModel.h"

@implementation THOrderModel

@end

@implementation THOrderListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods_list":@"THOrderGoodsListModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"iD":@"id"};
}

/**
 'WAITPAY' => '待支付',
 'WAITSEND'=>'待发货',
 'PORTIONSEND'=>'部分发货',
 'WAITRECEIVE'=>'待收货',
 'WAITCCOMMENT'=> '待评价',
 'CANCEL'=> '已取消',
 'FINISH'=> '已完成', //
 'CANCELLED'=> '已作废'
 */

#pragma mark - 返回订单类型
+ (NSInteger)orderTypeWithCode:(NSString *)code {
    if ([code isEqualToString:@"WAITPAY"]) return 0;
    if ([code isEqualToString:@"WAITSEND"]) return 1;
    if ([code isEqualToString:@"PORTIONSEND"]) return 2;
    if ([code isEqualToString:@"WAITRECEIVE"]) return 3;
    if ([code isEqualToString:@"WAITCCOMMENT"]) return 4;
    if ([code isEqualToString:@"CANCEL"]) return 5;
    if ([code isEqualToString:@"FINISH"]) return 6;
    if ([code isEqualToString:@"CANCELLED"]) return 7;
    return 100;
}

@end

@implementation THOrderGoodsListModel

@end
