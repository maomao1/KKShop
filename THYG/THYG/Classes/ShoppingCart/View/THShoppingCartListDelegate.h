//
//  THShoppingCartListDelegate.h
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THShoppingCartListDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

- (void)registerTable:(UITableView*)table;

@property (nonatomic, assign) CGFloat totalPrice;
/** 传入的数据源*/
@property (nonatomic, strong) NSArray *data;
/** 选择购物车商品数据*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UILabel *totalPriceLabel;

@property (nonatomic, copy) void(^selectOptionAllBlock)(BOOL isSelect);

@end
