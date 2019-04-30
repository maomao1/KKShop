//
//  THAddressEditVC.h
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
@class THAddressModel;
typedef NS_ENUM(NSInteger, optionType) {
    /*新建*/
    newOption = 0,
    /*编辑*/
    editOption
};

@interface THAddressEditVC : THBaseVC

@property (nonatomic,assign) optionType optiontype;

@property (nonatomic,strong) THAddressModel *modelData;

@property (nonatomic,copy) void(^optionSuccessBlock)(void);

@end
