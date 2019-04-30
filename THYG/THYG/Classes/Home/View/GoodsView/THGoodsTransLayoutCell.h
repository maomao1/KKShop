//
//  THGoodsTransLayoutCell.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THGoodsModel;
@interface THGoodsTransLayoutCell : UICollectionViewCell

@property (nonatomic, strong) THGoodsModel *goodsModel;

@property (nonatomic, copy) void(^addCartAction)();

@end
