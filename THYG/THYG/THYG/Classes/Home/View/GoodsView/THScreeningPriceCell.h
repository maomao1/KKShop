//
//  THScreeningPriceCell.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THScreeningPriceCell : UICollectionViewCell

/** 重置*/
@property (nonatomic, assign) BOOL resetValue;

/** 筛选价格回调， 开始价、结束价*/
@property (nonatomic, copy) void (^siftPriceBlock)(NSString *startPrice, NSString *endPrice);

@end
