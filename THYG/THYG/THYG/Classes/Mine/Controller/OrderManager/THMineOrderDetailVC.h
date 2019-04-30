//
//  THMineOrderDetailVC.h
//  THYG
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THBaseVC.h"

@interface THMineOrderDetailVC : THBaseVC

@property (nonatomic, copy) NSString *orderId;

/** 普通订单 / 退换货订单*/
@property (nonatomic, assign) NSInteger type;

@end
