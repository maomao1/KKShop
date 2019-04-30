//
//  THMineOrderCell.h
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THOrderListModel;

typedef NS_ENUM(NSUInteger, OrderCell) {
    OrderCellNormal = 0, // 订单
    OrderCellDetail, // 订单详情
};

@interface THMineOrderCell : THBaseCell

@property (nonatomic, copy) void (^deleteOrderBlock)(void);

@property (nonatomic, strong) THOrderListModel *orderListModel;

@property (nonatomic, assign) OrderCell cellType;

@end
