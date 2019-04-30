//
//  THCouponsCell.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THCouponsModel;
typedef void(^btnClickBlock)(void);
@interface THCouponsCell : THBaseCell

@property (nonatomic,copy) btnClickBlock btnClickAcion;

/*
 type:
 0.已经领取，用户拥有的券
 1.未领取，领券中心
 */
- (void)refreshWithModel:(THCouponsModel *)model type:(NSInteger)type;

@property (nonatomic, strong) THCouponsModel *modelData;

@end
