//
//  THHomeMallActivityCell.h
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THHomeMallActivityCell : UICollectionViewCell

@property (nonatomic, copy) void (^selectItemBlock)(NSInteger item);

@end
