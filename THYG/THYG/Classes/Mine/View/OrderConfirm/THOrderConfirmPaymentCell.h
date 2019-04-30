//
//  THOrderConfirmPaymentCell.h
//  THYG
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THBaseCell.h"

@interface THOrderConfirmPaymentCell : THBaseCell

@property (nonatomic, copy) NSDictionary *cellDict;

@property (nonatomic, assign) BOOL isSelected;

/** 选择回调*/
@property (nonatomic, copy) void (^selectedBlock)(BOOL isSelected);

@end
