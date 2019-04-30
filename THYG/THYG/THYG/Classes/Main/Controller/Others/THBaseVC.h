//
//  THBaseVC.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIScrollView+MJRefreshExtension.h"
#import "THHomeShowMenuView.h"

@interface THBaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate, YYRefreshExtensionDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) THHomeShowMenuView *menuView;

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

// tableView headView的样式  是否是漂浮的
@property (assign, nonatomic) BOOL isGrouped;

//配置网络刷新
- (void)configRefresh;

//上拉加载刷新页码
@property (nonatomic,assign) NSInteger pageIndex;

//刷新加载数据的网络请求 isUP = YES, 上拉刷新  反之，下拉刷新
@property (nonatomic,copy) void(^refreshData)(void);

@property (nonatomic) BOOL isUp;

/*****是否要展示没有数据的空白页*****/
@property (nonatomic) BOOL isShowEmptyView;

/*****用户信息发生改变*****/
@property (nonatomic,copy) void(^userInfoUpdateBlock)(void);

//下拉刷新 停止刷新
- (void)refreshEndOfPulldownWithResponseData:(NSArray*)responseData;
//上拉刷新 停止刷新
- (void)refreshEndOfPullUpWithResponseData:(NSArray*)responseData;

- (void)pushVC:(UIViewController *)controller; // push

- (void)popVC; // pop

- (void)popTo:(UIViewController *)controller; // pop to vc

- (void)presentVC:(UIViewController *)vc; // present

- (void)isNavTitleWhite; // 导航栏标题是否为白色

- (void)isNavigationClear; // 导航栏透明

- (void)isNavigationNormal; // 导航栏不透明（普通状态下）

- (void)statusBarLightContent; // 状态栏白色

- (void)statusBarDefault;  // 状态栏默认（黑色）

- (void)menuAction;

@end
