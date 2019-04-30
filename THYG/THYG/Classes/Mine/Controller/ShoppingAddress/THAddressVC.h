//
//  THAddressVC.h
//  THYG
//
//  Created by Mac on 2018/4/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
@class THAddressModel;

@interface THAddressVC : THBaseVC

@property (nonatomic, copy) void (^getSelectAddress)(THAddressModel *addressModel);

@end
