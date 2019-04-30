//
//  THScreeningGoodsCtl.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScreeningGoodsCtl.h"
#import "THHomeHotGoodsCell.h"
#import "THGoodsTransLayoutCell.h"
#import "THGoodsPageSiftView.h"
#import "THGoodsDetailVC.h"

#import "UISearchBar+FMAdd.h"
#import "THScreeningView.h"
#import "THGoodsModel.h"

#define itemWidth   (SCREEN_WIDTH - 3 * 10) * 0.5
#define MenuTableWidth (SCREEN_WIDTH-SCREEN_WIDTH*0.15)

@interface THScreeningGoodsCtl ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIButton * layoutButton;
@property (nonatomic, strong) THGoodsPageSiftView * siftView;
@property (nonatomic, strong) THScreeningView *screeningView;
@property (nonatomic, copy) NSString *sortParma;
@property (nonatomic, copy) NSString *sort_ascParma;
@property (nonatomic, copy) NSString *start_priceParma;
@property (nonatomic, copy) NSString *end_priceParma;
@property (nonatomic, copy) NSArray *categoryData;

//是否是横向布局
@property (nonatomic) BOOL isTransLayout;
@end

@implementation THScreeningGoodsCtl
{
    NSMutableDictionary *_siftDict; // 筛选字典 包含品牌和价格区间
    NSInteger _currentSelectIndex; // 当前选择筛选视图的位置
    NSInteger _sectionNum; // 分组
    CGFloat _cellHeight; // cell高度
    UITextField *_searchTextField;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self isNavigationNormal];
    [self statusBarDefault];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self statusBarLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getFilterData];
    [self requestData:NO];
}

#pragma mark - 设置UI界面
- (void)setupUI {
    [self.view addSubview:self.siftView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.screeningView];
    
    self.pageIndex = 1;
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex += 1;
        [self requestData:NO];
    }];
    
    self.collectionView.mj_footer.hidden = YES;
    
    if (self.isShowSearchBar) {
        UIView *titleView = [[UIView alloc] init];
        self.searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
        [titleView addSubview:self.searchBar];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
            if (@available(iOS 9.0, *)) {
                [NSLayoutConstraint activateConstraints:@[
                                                          [self.searchBar.topAnchor constraintEqualToAnchor:titleView.topAnchor],
                                                          [self.searchBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor constant:-10],
                                                          [self.searchBar.rightAnchor constraintEqualToAnchor:titleView.rightAnchor constant:-10],
                                                          [self.searchBar.bottomAnchor constraintEqualToAnchor:titleView.bottomAnchor]
                                                          ]];
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
        
        self.navigationItem.titleView = titleView;
        self.searchBar.placeholder = @"搜索关键词";
        self.searchBar.barTintColor = [UIColor whiteColor];
        [self.searchBar setImage:[UIImage imageNamed:@"bSearch"]forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        self.searchBar.delegate = self;
        
        for (UIView *subView in [[self.searchBar.subviews lastObject] subviews]) {
            if ([[subView class] isSubclassOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.font = [UIFont systemFontOfSize:14];
                textField.textColor = GRAY_COLOR(17);
                textField.backgroundColor = BGColor;
                self.searchText.length ? textField.placeholder = self.searchText : nil;
                _searchTextField = textField;
                break;
            }
        }
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.layoutButton];
    
    _siftDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [self.dataSourceArray removeAllObjects];
    
    @weakify(self);
    // 综合 0  销量 1  价格 2  筛选 3
    self.siftView.siftClickBlock = ^(NSInteger idx) {
        //排序类型，有 goods_id（综合），comment_count（评论），sales_sum（销量），shop_price（价格）
        @strongify(self);
        if (idx != 3) {
            self.sortParma = (idx == 0) ? @"goods_id" : (idx == 1) ? @"sales_sum" : @"shop_price";
            if (idx == 2) {
                
                if (self.sort_ascParma && !self.sort_ascParma.length) {
                    self.sort_ascParma = @"asc";
                } else {
                    if ([self.sort_ascParma isEqualToString:@"asc"]) {
                        self.sort_ascParma = @"desc";
                    } else {
                        self.sort_ascParma = @"asc";
                    }
                }
            }
            
            [self requestData:YES];
            
        } else {
            [self.screeningView show];
        }
        
    };
    
    // 筛选回调
    self.screeningView.siftResultBlock = ^(NSString *cat_id, NSString *startPrice, NSString *endPrice) {
        @strongify(self);
        self.cat_id = cat_id;
        self.start_priceParma = startPrice;
        self.end_priceParma = endPrice;
        [self requestData:YES];
    };
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
        self.searchBar.x = 15;
        self.layoutButton.width = 44;
        self.searchBar.width = SCREEN_WIDTH - self.layoutButton.width - 10 * 7 - 8;
        self.searchBar.height = SCREEN_WIDTH > self.view.height ? 24 : 30;
        _searchTextField.frame = _searchBar.bounds;
    } else {
        UIView *titleView = self.navigationItem.titleView;
        titleView.x = 10 * 1.5;
        titleView.y = self.view.width > self.view.height ? 3 : 7;
        titleView.width = self.view.width - self.layoutButton.width - titleView.x * 2 - 3;
        titleView.height = self.view.width > self.view.height ? 24 : 30;
    }
    _searchTextField.layer.cornerRadius = self.searchBar.height/2;
    _searchTextField.clipsToBounds = YES;
}

#pragma mark -- 获取筛选条件数据
- (void)getFilterData {
    [THNetworkTool POST:API(@"/Goods/getGoodsCategory") parameters:nil completion:^(id responseObject, NSDictionary *allResponseObject) {
//        self.categoryData = responseObject[@"info"];
        self.screeningView.dataArray = responseObject[@"info"];
    }];
}


- (void)requestData:(BOOL)isClearDataSource {
    
     [THNetworkTool POST:API(@"/Goods/getGoodsList")
              parameters:@{@"keyword":self.searchBar.text.length ? self.searchBar.text : @"",
                           @"page":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"sort":self.sortParma.length ? self.sortParma : @"",//排序类型，有 goods_id（综合），comment_count（评论），sales_sum（销量），shop_price（价格）
                           @"sort_asc":self.sort_ascParma.length ? self.sort_ascParma : @"",//排序是升还是降， asc 升， desc 降
                           @"cat_id":self.cat_id.length ? self.cat_id : @"",//分类id
                           @"start_price":self.start_priceParma.length ? self.start_priceParma : @"",//最低价
                           @"end_price":self.end_priceParma.length ? self.end_priceParma : @"",//最高价
                           @"page": @(self.pageIndex)
                           }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                
                 if (isClearDataSource) {
                     [self.dataSourceArray removeAllObjects];
                 }
                 self.collectionView.mj_footer.hidden = NO;
                 NSArray *data = [THGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
                 [self.dataSourceArray addObjectsFromArray:data];
                 [self.collectionView reloadData];
                 if (!data.count) {
                     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                 }else{
                     [self.collectionView.mj_footer resetNoMoreData];
                 }
                 
             }];
    
}

#pragma mark -- 添加购物车
- (void)addCart:(THGoodsModel *)goodsModel {
    
    [THNetworkTool POST:API(@"/Cart/addCart")
             parameters:@{@"goods_id":goodsModel.goods_id,
                          @"goods_num":@"1",
                          @"item_id":@"",
                          @"token":TOKEN
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                
                 [THHUD showSuccess:@"成功加入购物车"];
                 
             }];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    THGoodsModel *goodsModel = self.dataSourceArray[ROW];
    if (self.isTransLayout) {
        THGoodsTransLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THGoodsTransLayoutCell) forIndexPath:indexPath];
        cell.goodsModel = goodsModel;
        cell.addCartAction = ^{
          
            [self addCart:goodsModel];
        };
        return cell;
    }
    THHomeHotGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THHomeHotGoodsCell) forIndexPath:indexPath];
    cell.goodsModel = goodsModel;
    cell.addCartAction = ^{
      
        [self addCart:goodsModel];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsModel *goodsModel = self.dataSourceArray[ROW];
    THGoodsDetailVC *detail = [[THGoodsDetailVC alloc]init];
    detail.goodsId = goodsModel.goods_id;
    [self pushVC:detail];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_isTransLayout) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.isTransLayout) {
        return 0;
    }
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.isTransLayout) {
        return 0;
    }
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isTransLayout) {
        return CGSizeMake(SCREEN_WIDTH, 120);
    }
    return CGSizeMake(itemWidth, 260);
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
#if 0
    KBSearchVC *searchVc = [[KBSearchVC alloc] init];
    searchVc.searchType = self.searchType;
    searchVc.searchText = self.searchText;
    [self presentVC:searchVc];
    return YES;
#endif
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchText = searchBar.text;
    [self.dataSourceArray removeAllObjects];
    [self requestData:YES];
}

#pragma mark - 切换布局
- (void)changeLayout:(UIButton *)button {
    button.selected = !button.selected;
    self.isTransLayout = button.selected;
}

- (void)setIsTransLayout:(BOOL)isTransLayout {
    _isTransLayout = isTransLayout;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-44) collectionViewLayout:layout];
        _collectionView.backgroundColor = BGColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THHomeHotGoodsCell) bundle:nil]  forCellWithReuseIdentifier:STRING(THHomeHotGoodsCell)];
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THGoodsTransLayoutCell) bundle:nil] forCellWithReuseIdentifier:STRING(THGoodsTransLayoutCell)];
    }
    return _collectionView;
}

- (UIButton *)layoutButton {
    if (!_layoutButton) {
        _layoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_layoutButton setImage:IMAGENAMED(@"liebiao") forState:UIControlStateNormal];
        [_layoutButton setImage:IMAGENAMED(@"liebiaozhanshi") forState:UIControlStateSelected];
        [_layoutButton addTarget:self action:@selector(changeLayout:) forControlEvents:UIControlEventTouchUpInside];
        _layoutButton.frame = CGRectMake(0, 0, 44, 44);
    }
    return _layoutButton;
}

- (THGoodsPageSiftView *)siftView {
    if (!_siftView) {
        _siftView = [[THGoodsPageSiftView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    }
    return _siftView;
}

- (THScreeningView *)screeningView
{
    if (!_screeningView) {
        _screeningView = [[THScreeningView alloc] init];
    }
    return _screeningView;
}

- (NSArray *)categoryData {
    if (!_categoryData) {
        _categoryData = [NSArray array];
    }
    return _categoryData;
}

@end
