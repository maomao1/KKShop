//
//  THAddressCell.h
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THAddressModel;

@interface THAddressCell : THBaseCell

+ (CGFloat)cellHeight;

@property (nonatomic, strong) THAddressModel *addressModel;

@end
