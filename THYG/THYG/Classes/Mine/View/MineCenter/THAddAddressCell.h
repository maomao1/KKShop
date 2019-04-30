//
//  THAddAddressCell.h
//  THYG
//
//  Created by Mac on 2018/5/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THAddressModel;

@interface THAddAddressCell : THBaseCell

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) THAddressModel *modelData;

@property (nonatomic,copy) void(^getInsertValue)(NSString *value);

@end
