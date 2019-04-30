//
//  THOrderCouponModel.h
//  THYG
//
//  Created by 廖辉 on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THOrderCouponModel : NSObject

@property (nonatomic, assign) CGFloat postFee;//物流费

@property (nonatomic, copy) NSString *couponFee;//优惠券

@property (nonatomic, assign) CGFloat balance;//使用用户余额

@property (nonatomic, assign) CGFloat pointsFee;//特比支付

@property (nonatomic, assign) CGFloat payables;//应付金额

@property (nonatomic, assign) CGFloat goodsFee;//商品价格

@property (nonatomic, copy) NSString *order_prom_id;//订单优惠活动id

@property (nonatomic, assign) CGFloat order_prom_amount;// 订单优惠活动优惠了多少钱

@end
