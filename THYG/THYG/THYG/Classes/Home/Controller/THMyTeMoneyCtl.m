//
//  THMyTeMoneyCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyTeMoneyCtl.h"
#import "THTeMoneyHead.h"
#import "THGoodsListOfCollectionLayoutCell.h"
#import "THHomeSectionHead.h"
#import "THFavouriteGoodsModel.h"

@interface THMyTeMoneyCtl ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation THMyTeMoneyCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的特币";
    [self.view addSubview:self.collectionView];
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
    [self.collectionView addHeaderWithHeaderClass:nil beginRefresh:YES delegate:self animation:YES];
    [self.collectionView addFooterWithFooterClass:nil automaticallyRefresh:NO delegate:self];
}
- (void)onRefreshing:(id)control {
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self requestNetWorkingWithPageNum:pageNum.integerValue isHeader:NO];
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


#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return !section ? 0 : self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
        
        return nil;
        
    } else {
        THGoodsListOfCollectionLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THGoodsListOfCollectionLayoutCell) forIndexPath:indexPath];
        cell.favModel = self.dataSourceArray[indexPath.item];
        return cell;
        
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section==0) {
            THTeMoneyHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THTeMoneyHead) forIndexPath:indexPath];
            reusableview = head;
            
        } else {
            THHomeSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:STRING(THHomeSectionHead) forIndexPath:indexPath];
            reusableview = sectionHead;
        }
        
    }
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (SECTION > 0 ) {
        
    }
    
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SECTION == 0) return CGSizeMake(SCREEN_WIDTH , HEIGHT(264));
    return CGSizeMake((SCREEN_WIDTH-4)/2, (SCREEN_WIDTH-4)/2+80);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) return CGSizeMake(SCREEN_WIDTH, HEIGHT(150));
    if (section == 1) return CGSizeMake(SCREEN_WIDTH, 45);
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return UIEdgeInsetsMake(0, MARGIN, MARGIN, MARGIN);
    }
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
    return 0.0000001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 1;
    }
    return 0.0000001;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THGoodsListOfCollectionLayoutCell) bundle:nil] forCellWithReuseIdentifier:STRING(THGoodsListOfCollectionLayoutCell)];
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THTeMoneyHead) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THTeMoneyHead)];
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THHomeSectionHead) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THHomeSectionHead)];
        
    }
    return _collectionView;
}

@end
