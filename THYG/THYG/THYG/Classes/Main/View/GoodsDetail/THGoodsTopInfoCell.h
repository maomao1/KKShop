//
//  THGoodsTopInfoCell.h
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THGoosDetailModel;
@interface THGoodsTopInfoCell : THBaseCell

@property (nonatomic, strong) THGoosDetailModel *goodsDetailModel;

@property (nonatomic, copy) void(^focusBtnAction)(BOOL isSelected);

@end
