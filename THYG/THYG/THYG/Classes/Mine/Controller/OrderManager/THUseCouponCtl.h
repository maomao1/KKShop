//
//  THUseCouponCtl.h
//  THYG
//
//  Created by 廖辉 on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
@class THCouponsModel;

@interface THUseCouponCtl : THBaseVC

@property (nonatomic, copy) void(^selectCouponBlock)(THCouponsModel *couponModel);

@end
