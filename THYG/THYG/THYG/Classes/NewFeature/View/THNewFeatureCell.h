//
//  THNewFeatureCell.h
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNewFeatureCell : UICollectionViewCell

@property (nonatomic, copy) NSDictionary * itemDict;

/** 告诉cell是不是最后一个cell */
- (void)setLastIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
