//
//  THMineOrderHeaderCell.h
//  THYG
//
//  Created by Victory on 2018/3/16.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"

@interface THMineOrderHeaderCell : THBaseCell
@property (nonatomic, copy) void (^orderAction)(NSInteger index);
@end
