//
//  THMoreLimitSpellGroupCell.h
//  THYG
//
//  Created by Colin on 2018/3/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THFlashSaleModel;

@interface THMoreLimitSpellGroupCell : UICollectionViewCell

@property (nonatomic, strong) THFlashSaleModel *flashModel;

@property (nonatomic, copy) void (^gotoBuyClick)(void);

@end
