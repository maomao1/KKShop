//
//  THMineVC.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineVC.h"
#import "THMineSectionCell.h"
#import "THMineAdCell.h"
#import "THMineOrderHeaderCell.h"
#import "THMineHeaderView.h"
#import "THLoginVC.h"
#import "THMineShareQRCodeVC.h"
#import "THMineSubmitApplicationVC.h"
#import "THMyCollectCtl.h"
#import "THMyFootprintCtl.h"
#import "THCouponsCtl.h"
#import "THInvitationManageCtl.h"
#import "THMyTaskCtl.h"
#import "THMineOrderManageVC.h"
#import "THMineWalletVC.h"
#import "THUserInfoEditCtl.h"
#import "THSettingCtl.h"
#import "THMineApplymentVC.h"
#import "THFavouriteGoodsModel.h"
#import "THTeCtl.h"
#import "THGoodsListOfCollectionLayoutCell.h"

@interface THMineVC () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray *_dataArray;
    CGFloat _lastOffsetY;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THMineHeaderView *headView;
@end

@implementation THMineVC

- (void)initUI {
    UIBarButtonItem *menuAction = [UIBarButtonItem itemWithImage:@"dingbugengduo" highLightImage:@"dingbugengduo" target:self action:@selector(menuAction)];
    UIBarButtonItem *settingAction = [UIBarButtonItem itemWithImage:@"shezhi" highLightImage:@"shezhi" target:self action:@selector(settingBtnClick)];
    self.navigationItem.rightBarButtonItems = @[menuAction,settingAction];
}

#pragma mark - 菜单
- (void)menuAction {
    
}

#pragma mark - 账户设置
- (void)settingBtnClick {
    THSettingCtl *setting = [[THSettingCtl alloc] init];
    setting.title = @"账户设置";
    [self pushVC:setting];
}

#pragma mark - 更新用户信息
- (void)updateUserInfo {
    [self.headView refreshUI];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat alpha = MIN(1, 1 - ((10 + kNaviHeight - _lastOffsetY) / kNaviHeight));
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[GLOBAL_RED_COLOR colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self isNavigationClear];
	[self.view addSubview:self.tableView];
	// iOS 11 适配
	if (@available(iOS 11, *)) {
		self.tableView.estimatedRowHeight = 0.0;
		self.tableView.estimatedSectionFooterHeight = 0;
		self.tableView.estimatedSectionHeaderHeight = 0;
	}
	
	@weakify(self);
	self.headView.checkOnBlock = ^{
		@strongify(self);
		[self signRequest];
	};
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserInfo) name:UPDATE_USERINFO_NOTIFICATION object:nil];
    
	_dataArray = @[@[
					   @{@"image":@"",
						 @"title":@""},
					   ],
				   @[
					   @{@"image":@"tuiguangerweima_red",
						 @"title":@"推广二维码"},
					   @{@"image":@"gongyingzhuanyuanshenqing",
						 @"title":@"供应专员申请"},
					   @{@"image":@"chengweigongyingshang",
						 @"title":@"成为供应商"},
					   ],
				   @[
					   @{@"image":@"youhuiquan",
						 @"title":@"优惠券"},
					   @{@"image":@"qianbao",
						 @"title":@"钱包"},
					   ],
				   @[
					   @{@"image":@"yaoqingguanli",
						 @"title":@"邀请管理"},
					   @{@"image":@"wodeguanzhu",
						 @"title":@"我的关注"},
					   @{@"image":@"liulanjilu",
						 @"title":@"浏览记录"},
					   @{@"image":@"wodetechanquan",
						 @"title":@"我的晒单"},
					   @{@"image":@"woderenwu",
						 @"title":@"我的任务"},
					   ],
				   @[
					   @{@"image":@"",
						 @"title":@""},
					   ],
				   @[
					   @{@"image":@"",
						 @"title":@"猜你喜欢"},
					   ],
				   ];
    
    
    [self.collectionView addHeaderWithHeaderClass:nil beginRefresh:YES delegate:self animation:YES];
    [self.collectionView addFooterWithFooterClass:nil automaticallyRefresh:NO delegate:self];
	
}

#pragma mark - YYRefreshExtensionDelegate
- (void)onRefreshing:(id)control {
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self requestNetWorkingWithPageNum:pageNum.integerValue isHeader:NO];
}

#pragma mark - 签到
- (void)signRequest {
	
	[THNetworkTool POST:API(@"/User/sign") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
		if ([responseObject[@"status"] integerValue] == 200) {
			[THHUD showMsg:@"签到成功"];
			BOOL isSigned = [(responseObject[@"info"][@"is_sign"]) integerValue];
			self.headView.isSigned = isSigned;
		} else {
			self.headView.isSigned = NO;
		}
	}];

}

#pragma mark - 猜你喜欢
- (void)requestNetWorkingWithPageNum:(NSInteger)pageNum isHeader:(BOOL)isHeader {
    
    [THHUD show];
    [THNetworkTool POST:API(@"/Goods/favouriteGoods") parameters:@{@"page":@(pageNum)} completion:^(id responseObject, NSDictionary *allResponseObject) {
        [THHUD dismiss];
        NSArray *tempArr = [THFavouriteGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        
        if (tempArr.count) {
            if (isHeader) {
                [self.collectionView endHeaderRefreshWithChangePageIndex:YES];
                [self.dataSourceArray removeAllObjects];
                [self.dataSourceArray addObjectsFromArray:tempArr];
                
            } else {
                [self.collectionView endFooterRefreshWithChangePageIndex:YES];
                if (tempArr.count) {
                    [self.dataSourceArray addObjectsFromArray:tempArr];
                }else {
                    [self.collectionView noMoreData];
                }
            }
            
        } else {
            NSLog(@"请求失败");
            if (isHeader) {
                [self.collectionView endHeaderRefreshWithChangePageIndex:NO];
            }else {
                [self.collectionView endFooterRefreshWithChangePageIndex:NO];
            }
        }
        [self.collectionView reloadData];
    }];
    
}

#pragma mark - 更新用户信息
- (void)reloadUserInfo {
    [THNetworkTool POST:API(@"/User/userinfo") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
        UserInfo = [THUserInfoModel mj_objectWithKeyValues:responseObject[@"info"]];
        if (!UserInfo) {
            [WZXArchiverManager clearAll];
        } else {
            [UserInfo wzx_archiveToName:USER_INFO_KEY];
        }
        
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.headView.frame;
        rect.origin.y = offset.y;
        rect.size.height = CGRectGetHeight(rect)-offset.y;
        self.headView.headImgView.frame = rect;
    }
    
    UIColor * color = GLOBAL_RED_COLOR;
    CGFloat offsetY = scrollView.contentOffset.y;
    _lastOffsetY = offsetY;
    CGFloat alpha = 0;
    if (offsetY > 10) {
        alpha = MIN(1, 1 - ((10 + kNaviHeight - offsetY) / kNaviHeight));
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[color colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"个人中心";
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[color colorWithAlphaComponent:0.0]] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"";
    }
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) return 3;
	else if (section == 2) return 2;
	else if (section == 3) return 5;
	else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = nil;
	
	if (SECTION == 0) {
		THMineOrderHeaderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineOrderHeaderCell)];
        
        orderCell.orderAction = ^(NSInteger index) {
            THMineOrderManageVC *manageVc = [[THMineOrderManageVC alloc] init];
            if (index != 3) {
                manageVc.selectIndex = (index==0) ? 1 : (index == 1) ? 3 : (index == 2) ? 4 : 0;
            } else {
                manageVc.type = 1;
                manageVc.selectIndex = 0;
            }
            [self pushVC:manageVc];
        };
        
		cell = orderCell;
        
        
	} else if ((SECTION > 0 && SECTION < 4) || SECTION == 5) {
		THMineSectionCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineSectionCell)];
		sectionCell.dataDict = _dataArray[SECTION][ROW];
		sectionCell.accessoryType = SECTION == 5 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
		cell = sectionCell;
	} else {
		THMineAdCell *adCell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineAdCell)];
		cell = adCell;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self pushWithIndexPath:indexPath];
}

- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            THMineShareQRCodeVC *shareVc = [[THMineShareQRCodeVC alloc] init];
            [self pushVC:shareVc];
        } else if (indexPath.row == 1) {
            THMineSubmitApplicationVC *submitVc = [[THMineSubmitApplicationVC alloc] init];
            [self pushVC:submitVc];
        } else {
            THMineApplymentVC *applyVc = [[THMineApplymentVC alloc] init];
            [self pushVC:applyVc];
        }
        
    } else if (indexPath.section == 2){
        
        if (indexPath.row==0) {
            
            THCouponsCtl *coupons = [[THCouponsCtl alloc] init];
            coupons.title = _dataArray[SECTION][ROW][@"title"];
            [self pushVC:coupons];
            
        }else if (indexPath.row==1){
            THMineWalletVC *walletVc = [[THMineWalletVC alloc] init];
            [self pushVC:walletVc];
        }
        
    }else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            
            THInvitationManageCtl *invitationManage = [[THInvitationManageCtl alloc] init];
            invitationManage.title = _dataArray[SECTION][ROW][@"title"];
            [self pushVC:invitationManage];
            
        } else if (indexPath.row < 3){
            
            THMyCollectCtl *collect = [[THMyCollectCtl alloc] init];
            collect.title = _dataArray[SECTION][ROW][@"title"];
            collect.type = indexPath.row == 2 ? MineGoodsTypeScanHistory : MineGoodsTypeMyAttention;
            [self pushVC:collect];
            
        } else if (indexPath.row == 3) {
            THTeCtl *te = [[THTeCtl alloc] init];
            te.title = @"我的晒单";
            [self pushVC:te];
        } else if (indexPath.row == 4) {
            
            THMyTaskCtl *taskCtl = [[THMyTaskCtl alloc] init];
            taskCtl.title = _dataArray[SECTION][ROW][@"title"];
            [self pushVC:taskCtl];
            
        }
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return self.collectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (SECTION == 0) return 67;
	if (SECTION == 4) return 150;
	return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return SCREEN_HEIGHT-kNaviHeight-kTabBarHeight;
    }
    
	return 0.000001;
    
}

#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsListOfCollectionLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THGoodsListOfCollectionLayoutCell) forIndexPath:indexPath];
    cell.favModel = self.dataSourceArray[indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return UIEdgeInsetsMake(0, MARGIN, MARGIN, MARGIN);
    }
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight) style:UITableViewStyleGrouped];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[_tableView registerNib:NIB(@"THMineSectionCell") forCellReuseIdentifier:STRING(THMineSectionCell)];
		[_tableView registerNib:NIB(@"THMineAdCell") forCellReuseIdentifier:STRING(THMineAdCell)];
		[_tableView registerClass:[THMineOrderHeaderCell class] forCellReuseIdentifier:STRING(THMineOrderHeaderCell)];
        _tableView.tableHeaderView = self.headView;
	}
	return _tableView;
}

- (THMineHeaderView *)headView {
	if (_headView == nil) {
		_headView = [[THMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IOS_VERSION >= 11 ? 100 : 150)];
        WEAKSELF;
		_headView.gotoMotifyInfoPage = ^{
            if ([TOKEN length]) {
                THUserInfoEditCtl *edit = [[THUserInfoEditCtl alloc] init];
                edit.title = @"个人资料编辑";
                [weakSelf pushVC:edit];
            } else {
                THLoginVC *loginVc = [[THLoginVC alloc] init];
                [weakSelf pushVC:loginVc];
            }
		};
	}
	return _headView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/2, (SCREEN_WIDTH-4)/2+80);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-kTabBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THGoodsListOfCollectionLayoutCell) bundle:nil] forCellWithReuseIdentifier:STRING(THGoodsListOfCollectionLayoutCell)];
    }
    return _collectionView;
}

@end
