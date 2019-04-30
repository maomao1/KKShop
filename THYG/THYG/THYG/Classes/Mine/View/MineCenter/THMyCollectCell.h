//
//  THMyCollectCell.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THMyCollectModel;
typedef void(^addCartBlock)(void);
@interface THMyCollectCell : THBaseCell

@property (nonatomic,copy) addCartBlock addCartAction;

@property (nonatomic, strong) THMyCollectModel *modelData;

@end
