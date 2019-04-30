//
//  THTeHuiCell.h
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THTeHuiModel;

@interface THTeHuiCell : THBaseCell

/** 查看全文*/
@property (nonatomic, copy) void (^moreClickBlock)(NSIndexPath *indexpath);

@property (nonatomic, strong) THTeHuiModel *teModel;


@end
