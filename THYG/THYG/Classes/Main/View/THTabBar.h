//
//  THTabBar.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THTabBar;

@protocol THTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBar:(THTabBar *)tabBar didClickBtn:(NSInteger)index;
- (void)specailButtonClickAction;
@end

@interface THTabBar : UIView
/** 选中的索引 */
@property (nonatomic, assign) NSInteger seletedIndex;
// 模型数组(UITabBarItem)
@property (nonatomic, strong) NSArray *items;

@property (weak, nonatomic) id <THTabBarDelegate> delegate;

@end
