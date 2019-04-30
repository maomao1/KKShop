//
//  THWalletHeaderModel.h
//  THYG
//
//  Created by Victory on 2018/6/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THWalletHeaderModel : NSObject

@property (nonatomic, copy) NSString * distribut_money; // 购物分享奖励金额
@property (nonatomic, copy) NSString * frozen_money; // 冻结金额
@property (nonatomic, copy) NSString * invite_user_money; // 消费推荐奖励
@property (nonatomic, assign) NSInteger pay_points; // （消费积分）特币
@property (nonatomic, copy) NSString * supplier_money; // 供应推荐奖励
@property (nonatomic, copy) NSString * user_money; // 预存金额

@end
