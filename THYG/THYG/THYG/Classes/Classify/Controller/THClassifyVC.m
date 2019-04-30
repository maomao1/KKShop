//
//  THClassifyVC.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THClassifyVC.h"
#import "THHomeHeaderItemCell.h"
#import "THClassifyHeaderView.h"
#import "THClassifyItemCell.h"
#import "THSearchView.h"
#import "THSpellGroupCtl.h"
#import "THLimitSpellGroupCtl.h"
#import "THFlashCtl.h"
#import "THScreeningGoodsCtl.h"

@interface THClassifyVC () <UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray <NSArray *>*_itemsArray;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THSearchView *searchView;

@end

@implementation THClassifyVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.navigationItem.leftBarButtonItem = self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = ({
        self.searchView = [[THSearchView alloc] initWithFrame:CGRectMake(WIDTH(20),0, SCREEN_WIDTH - WIDTH(40),30)];
        self.searchView;
    });
    
    [self getGoodsCategoryData];
    
}

- (void)getGoodsCategoryData {
    
    [THHUD show];
    [THNetworkTool POST:API(@"/Goods/getGoodsCategory") parameters:nil completion:^(id responseObject, NSDictionary *allResponseObject) {
        NSArray *categoryData = responseObject[@"info"];
        if (categoryData.count) {
            [THHUD dismiss];
        }
        _itemsArray = @[
                        @[
                            @{@"image":@"dingliangtuantubiao",
                              @"mobile_name":@"定量团"},
                            @{@"image":@"pintuantubiao",
                              @"mobile_name":@"拼团"},
                            @{@"image":@"miaoshatubiao",
                              @"mobile_name":@"秒杀"}
                            ],
                        categoryData,
                        @[
                            @{}
                            ]
                        ];
        [self.collectionView reloadData];
        
    }];
    
    if (!_itemsArray.count) {
        [THHUD dismiss];
        _itemsArray = @[
                        @[
                            @{@"image":@"dingliangtuantubiao",
                              @"mobile_name":@"定量团"},
                            @{@"image":@"pintuantubiao",
                              @"mobile_name":@"拼团"},
                            @{@"image":@"miaoshatubiao",
                              @"mobile_name":@"秒杀"}
                            ],
                        @[
                            @{@"image":@"mjmc",
                              @"title":@"名酒茗茶"},
                            @{@"image":@"zsyb",
                              @"title":@"滋生养补"},
                            @{@"image":@"msxc",
                              @"title":@"美食小吃"},
                            @{@"image":@"lysp",
                              @"title":@"粮油食品"},
                            @{@"image":@"hxsc",
                              @"title":@"海鲜水产"},
                            @{@"image":@"rldp",
                              @"title":@"肉类蛋品"},
                            @{@"image":@"scgg",
                              @"title":@"蔬菜瓜果"},
                            @{@"image":@"yxsg",
                              @"title":@"优选水果"},
                            ],
                        @[
                            @{}
                            ]
                        ];
         [self.collectionView reloadData];
    }

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return _itemsArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _itemsArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = nil;
	if (SECTION < 2) {
		THHomeHeaderItemCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THHomeHeaderItemCell) forIndexPath:indexPath];
		headerCell.isClassifyItem = YES;
		headerCell.itemDict = _itemsArray[SECTION][ROW];
		cell = headerCell;
	
	} else {
		THClassifyItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THClassifyItemCell) forIndexPath:indexPath];
		cell = itemCell;
	}
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *headerView = nil;
	
	if (kind == UICollectionElementKindSectionHeader) {
		THClassifyHeaderView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THClassifyHeaderView) forIndexPath:indexPath];
		headerV.title = @[@"精彩活动", @"商品分类",@"地方馆"][SECTION];
		headerView = headerV;
	}
	return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (SECTION) {
        case 0:
        {
            switch (ROW) {
                    //定量团
                case 0:
                {
                    THLimitSpellGroupCtl *limitSpellGroup = [[THLimitSpellGroupCtl alloc] init];
                    limitSpellGroup.title = _itemsArray[SECTION][ROW][@"title"];
                    [self pushVC:limitSpellGroup];
                }
                    break;
                    //拼团
                case 1:
                {
                    THSpellGroupCtl *spellGroup = [[THSpellGroupCtl alloc] init];
                    spellGroup.title = _itemsArray[SECTION][ROW][@"title"];
                    [self pushVC:spellGroup];
                }
                    break;
                    //秒杀
                case 2:
                {
                    THFlashCtl *flash = [[THFlashCtl alloc] init];
                    flash.title = _itemsArray[SECTION][ROW][@"title"];
                    [self pushVC:flash];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            THScreeningGoodsCtl *screening = [[THScreeningGoodsCtl alloc] init];
            screening.cat_id = [NSString stringWithFormat:@"%@", _itemsArray[SECTION][ROW][@"id"]];
            screening.isShowSearchBar = YES;
            [self pushVC:screening];
        }
            break;
        case 2:
        {
        }
            break;
        default:
            break;
    } 
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (SECTION < 2) return CGSizeMake(SCREEN_WIDTH / 4, HEIGHT(76));
	return CGSizeMake(SCREEN_WIDTH, HEIGHT(180));
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionVertical;
		layout.minimumLineSpacing = 0;
		layout.minimumInteritemSpacing = 0;
		layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 44);
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-kTabBarHeight) collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = WHITE_COLOR;
		_collectionView.pagingEnabled = YES;
		
		[_collectionView registerNib:NIB(@"THHomeHeaderItemCell") forCellWithReuseIdentifier:STRING(THHomeHeaderItemCell)];
		
		[_collectionView registerNib:NIB(@"THClassifyItemCell") forCellWithReuseIdentifier:STRING(THClassifyItemCell)];
		
		[_collectionView registerNib:NIB(@"THClassifyHeaderView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THClassifyHeaderView)];
		
	}
	return _collectionView;
}

@end
