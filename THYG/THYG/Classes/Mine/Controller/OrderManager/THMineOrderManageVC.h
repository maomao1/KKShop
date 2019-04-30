//
//  THMineOrderManageVC.h
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <YZDisplayViewController/YZDisplayViewController.h>

typedef NS_ENUM(NSUInteger, MineOrderManageVCType) {
    MineOrderManageVCTypeOrder, // 订单
    MineOrderManageVCTypeReturnOrExchange, // 退换货
};


@interface THMineOrderManageVC : YZDisplayViewController

/** 订单类型，0为 普通， 1为 退换货*/
@property (nonatomic, assign) MineOrderManageVCType type;

@end
