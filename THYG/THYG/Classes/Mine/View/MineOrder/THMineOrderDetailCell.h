//
//  THMineOrderDetailCell.h
//  THYG
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THBaseCell.h"

typedef NS_ENUM(NSUInteger, DetailCellType) {
    DetailCellTypeOrderStatus = 0, // 订单状态
    DetailCellTypeOrderInfo, // 订单信息
    DetailCellTypeShippingInfo, // 物流信息
    DetailCellTypeAddress, // 收货地址
    DetailCellTypeOthers // 其他
};

@interface THMineOrderDetailCell : THBaseCell

// cell 类型
@property (nonatomic, assign) DetailCellType detailType;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSDictionary *dataSourceDict;

@end
