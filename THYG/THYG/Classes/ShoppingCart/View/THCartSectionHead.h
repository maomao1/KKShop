//
//  THCartSectionHead.h
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THSuppliersModel;
@interface THCartSectionHead : UITableViewHeaderFooterView

@property (nonatomic, strong) THSuppliersModel *modelData;

@property (nonatomic, copy) void(^selectBtnClick)(void);

@end
