
//
//  YYRefreshExtensionDelegate.h
//  THYG
//
//  Created by Mac on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYRefreshExtensionDelegate <NSObject>

@optional
/**
 *    下拉 重新加载数据
 */
- (void)onRefreshing:(id)control;

@optional
/**
 *    上拉 加载更多数据
 */
- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum;

@end

