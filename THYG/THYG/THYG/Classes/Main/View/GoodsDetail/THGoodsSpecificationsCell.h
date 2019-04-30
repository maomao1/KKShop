//
//  THGoodsSpecificationsCell.h
//  THYG
//
//  Created by Mac on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"

@interface THGoodsSpecificationsCell : THBaseCell

@property (nonatomic, copy) void(^selectSpecBtnBlock)(void);

@property (nonatomic, copy) NSString *defaultSpec;

@end
