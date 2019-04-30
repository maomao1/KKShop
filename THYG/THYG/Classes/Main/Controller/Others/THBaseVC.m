//
//  THBaseVC.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
#import "THScanQRCodeVC.h"
#import "THAVCaptureSessionManager.h"

@interface THBaseVC ()
@property (nonatomic,strong) UIButton *backButton;
// 是否显示白色的状态栏
@property (nonatomic) BOOL isShowWhiteStatusBar;

@end

@implementation THBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

	// 导航栏默认是红色的
	[self isNavigationNormal];
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = BGColor;
    
    if (self.navigationController.childViewControllers.count < 1) {
        UIButton *left = [UIButton buttonWithImage:@"dingbu-saoyisao" selectedImage:@"dingbu-saoyisao" target:self action:@selector(scanAction)];
        left.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        left.frame = CGRectMake(0, 0, 40, 44);
        [left setTitle:@"扫一扫" forState:UIControlStateNormal];
        left.titleLabel.font = Font(9);
        [left layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
        UIButton *right = [UIButton buttonWithImage:@"dingbugengduo" selectedImage:@"dingbugengduo" target:self action:@selector(menuAction)];
        right.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        right.frame = CGRectMake(0, 0, 40, 44);
        [right setTitle:@"更多" forState:UIControlStateNormal];
        right.titleLabel.font = Font(9);
        [right layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    }
    
}

- (void)configRefresh {
    self.pageIndex = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        self.isUp = NO;
        if (self.refreshData) {
            self.refreshData();
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.dataTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex += 1;
        self.isUp = YES;
        if (self.refreshData) {
            self.refreshData();
        }
        
    }];
    [footer setTitle:@"没有更多数据了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor grayColor];
    footer.stateLabel.font = Font(13);
    self.dataTableView.mj_footer = footer;
    self.dataTableView.mj_footer.hidden = YES;
}

- (void)refreshEndOfPulldownWithResponseData:(NSArray *)responseData
{
    if (!self.isUp) {
        self.dataTableView.mj_footer.hidden = NO;
        [self.dataSourceArray removeAllObjects];
        [self.dataSourceArray addObjectsFromArray:responseData];
        [self.dataTableView.mj_header endRefreshing];
        if (self.dataSourceArray.count < [PageSize integerValue]) {
            self.dataTableView.mj_footer.hidden = YES;
        }
        if (self.dataSourceArray.count) {
            _isShowEmptyView = NO;
        }else{
            _isShowEmptyView = YES;
        }
        [self.dataTableView.mj_header endRefreshing];
    }
}

- (void)refreshEndOfPullUpWithResponseData:(NSArray *)responseData
{
    if (self.isUp) {
        [self.dataTableView.mj_footer endRefreshing];
        [self.dataSourceArray addObjectsFromArray:responseData];
        if (responseData.count==0 || responseData.count < [PageSize integerValue]) {
            [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.dataTableView.mj_footer resetNoMoreData];
        }
    }
}



#pragma mark - 导航栏按钮
- (void)scanAction {
 
    // 检查权限
    [THAVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
        THScanQRCodeVC *scanVc = [[THScanQRCodeVC alloc] init];
        [self pushVC:scanVc];
    } DeniedBlock:^{
        UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:aciton];
        [self presentViewController:controller animated:YES completion:nil];
    }];
    
}


#pragma mark - push
- (void)pushVC:(UIViewController *)controller {
	[self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - pop
- (void)popVC {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)popTo:(UIViewController *)controller {
	[self.navigationController popToViewController:controller animated:YES];
}

#pragma mark - present
- (void)presentVC:(UIViewController *)controller{
	[self.navigationController presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- 页面加载的时候改变状态栏
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	if (self.isShowWhiteStatusBar) {
		[self statusBarLightContent];
	}else{
		[self statusBarDefault];
	}
}

#pragma mark -- 用于pop回来的时候改变状态栏
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (self.isShowWhiteStatusBar) {
		[self statusBarLightContent];
	}else{
		[self statusBarDefault];
	}
}

#pragma mark - 导航栏文字黑色
- (void)isNavTitleWhite {
	self.isShowWhiteStatusBar = NO;
	[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GRAY_COLOR(17),NSForegroundColorAttributeName,nil]];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forBarMetrics:UIBarMetricsDefault];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.backButton setImage:IMAGENAMED(@"back_black") forState:UIControlStateNormal];
    }
	
}

#pragma mark - 导航栏透明
- (void)isNavigationClear {
	self.isShowWhiteStatusBar = YES;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:CLEARCOLOR] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:CLEARCOLOR]];
	[self.navigationController.navigationBar setTranslucent:YES];
	
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WHITE_COLOR,NSForegroundColorAttributeName,nil]];
	
    if (self.navigationController.viewControllers.count > 1) {
        [self.backButton setImage:IMAGENAMED(@"back_white") forState:UIControlStateNormal];
    }
	
}

#pragma mark - 导航栏默认
- (void)isNavigationNormal {
    self.isShowWhiteStatusBar = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WHITE_COLOR,NSForegroundColorAttributeName,nil]];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GLOBAL_RED_COLOR] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - 状态栏白色
- (void)statusBarLightContent {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 状态栏默认黑色
- (void)statusBarDefault {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}

- (UITableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.isGrouped ? UITableViewStylePlain : UITableViewStyleGrouped];
        _dataTableView.backgroundColor = BGColor;
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.emptyDataSetSource = self;
        _dataTableView.emptyDataSetDelegate = self;
        if (@available(iOS 11, *)) {
            _dataTableView.estimatedRowHeight = 0;
            _dataTableView.estimatedSectionFooterHeight = 0;
            _dataTableView.estimatedSectionHeaderHeight = 0;
        }
//        _dataTableView.emptyDataSetSource = self;
//        _dataTableView.emptyDataSetDelegate = self;
//        [_dataTableView registerClass:[KBDefaultSectionView class] forHeaderFooterViewReuseIdentifier:@"sectionDefaultView"];
        [self isRootViewController];
    }
    return _dataTableView;
}

- (void)isRootViewController {
    // NSLog(@"self.navigationController%ld", self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count > 1) {
        _dataTableView.frame = TABLE_NORMAL_FRAME;
    } else {
        _dataTableView.frame = TABLE_FRAME;
    }
}

- (UIButton*)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 20, 30, 44);
        [_backButton setTitleColor:CLEARCOLOR forState:UIControlStateNormal];
        _backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:IMAGENAMED(@"back_black") forState:UIControlStateNormal];
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    return _backButton;
}

- (THHomeShowMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[THHomeShowMenuView alloc] init];
    }
    return _menuView;
}


- (void)backButtonClick {
    [self popVC];
}

@end
