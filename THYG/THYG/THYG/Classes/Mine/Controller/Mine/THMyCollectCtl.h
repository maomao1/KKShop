//
//  THMyCollectCtl.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

typedef NS_ENUM(NSUInteger, MineGoodsType) {
    MineGoodsTypeMyAttention = 0, // 我的关注
    MineGoodsTypeScanHistory,     // 浏览记录
};


@interface THMyCollectCtl : THBaseVC

/**
 用来区分 我的关注 和 浏览记录
 */
@property (nonatomic, assign) MineGoodsType type;

@end
