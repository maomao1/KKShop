//
//  THScreeningView.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THScreeningView : UIControl

@property (nonatomic, copy) NSArray <NSDictionary *>*dataArray;

- (void)show;

/**
 筛选结果回调 分类id， 开始价， 结束价
 */
@property (nonatomic, copy) void (^siftResultBlock)(NSString *cat_id, NSString *startPrice, NSString *endPrice);

@end

@interface THScreeningViewSectionHead : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

@end

