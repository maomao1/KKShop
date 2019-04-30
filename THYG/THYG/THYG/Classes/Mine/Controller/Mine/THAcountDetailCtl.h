//
//  THAcountDetailCtl.h
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

typedef NS_ENUM(NSInteger, balanceType) {
    
    //账户余额
    acountBlanceType = 0,
    
    //红包余额
    redPackageBalanceType,
    
    //推荐佣金
    recommandBalanceType,
    
    //特币
    teMoneyBalanceType
};

@interface THAcountDetailCtl : THBaseVC

@property (nonatomic, assign) balanceType balanceCateType;

@end
