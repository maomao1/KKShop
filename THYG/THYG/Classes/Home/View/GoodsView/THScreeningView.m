//
//  THScreeningView.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScreeningView.h"
#import "THSingleLabelCell.h"
#import "THScreeningPriceCell.h"

#define LeftSpace     40
#define SpaceWidth    10
#define RowNumbers    4

@interface THScreeningView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *_catId, *_startPrice, *_endPrice;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation THScreeningView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight);
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.6];
        [self addSubview:self.collectionView];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        [self addTarget:self action:@selector(dismissMasView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttomButtonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            // 重置选择项
            _catId = _startPrice = _endPrice = @"";
            [self.collectionView reloadData];
            break;
        case 1: {
            //执行回调事件
            !self.siftResultBlock?:self.siftResultBlock(_catId, _startPrice, _endPrice);
            [self dismissMasView];
        }
            break;
        default:
            break;
    }
}

- (void)show
{
    self.x = 0;
    [UIView animateWithDuration:0.3 animations:^{
       
        self.collectionView.x = LeftSpace;
        self.topView.x = LeftSpace;
        self.bottomView.x = LeftSpace;
        
    }];
}

- (void)dismissMasView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.collectionView.x = SCREEN_WIDTH;
        self.topView.x = SCREEN_WIDTH;
        self.bottomView.x = SCREEN_WIDTH;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.x = SCREEN_WIDTH;
    });
}

- (void)setDataArray:(NSArray<NSDictionary *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

#pragma mark - collectionView 数据源代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SECTION==0) {
        THScreeningPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THScreeningPriceCell) forIndexPath:indexPath];
        cell.resetValue = YES;
        cell.siftPriceBlock = ^(NSString *startPrice, NSString *endPrice) {
            NSLog(@"startPrice%@, endPrice%@", startPrice, endPrice);
            _startPrice = startPrice;
            _endPrice = endPrice;
        };
        
        return cell;
    }
    THSingleLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THSingleLabelCell) forIndexPath:indexPath];
    cell.contentView.backgroundColor = GRAY_COLOR(234);
    cell.singleLabel.text = self.dataArray[indexPath.row][@"mobile_name"];
    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
        cell.isSelected = YES;
    }else{
        cell.isSelected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        [[collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * cell, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([cell isKindOfClass:[THSingleLabelCell class]]) {
                ((THSingleLabelCell *)cell).isSelected = NO;
            }
        }];
        
        THSingleLabelCell *cell = (THSingleLabelCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.isSelected = YES;

        _catId = self.dataArray[indexPath.row][@"id"];
        NSLog(@"cat_id %@", _catId);
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SECTION==0) {
        return CGSizeMake(self.collectionView.width, 60);
    }
    return CGSizeMake((SCREEN_WIDTH - LeftSpace - (RowNumbers + 1) * SpaceWidth) / RowNumbers, (SCREEN_WIDTH - LeftSpace - (RowNumbers + 1) * SpaceWidth) / RowNumbers / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(SpaceWidth, SpaceWidth, SpaceWidth, SpaceWidth);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.width, 5);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        THScreeningViewSectionHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        head.titleLabel.text = @[@"价格区间",@"全部分类",@"属性1",@"属性2",@"属性3"][SECTION];
        return head;
    }
    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
    foot.backgroundColor = BGColor;
    return foot;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 40, SCREEN_WIDTH-LeftSpace, SCREEN_HEIGHT-kNaviHeight-44-40) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor = WHITE_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THSingleLabelCell) bundle:nil] forCellWithReuseIdentifier:STRING(THSingleLabelCell)];
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THScreeningPriceCell) bundle:nil] forCellWithReuseIdentifier:STRING(THScreeningPriceCell)];
        [_collectionView registerClass:[THScreeningViewSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    }
    return _collectionView;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH-SpaceWidth, 40)];
        _topView.backgroundColor = WHITE_COLOR;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _topView.width, _topView.height)];
        title.font = Font(15);
        title.textColor = GRAY_COLOR(81);
        title.text = @"筛选";
        [_topView addSubview:title];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-44, SCREEN_WIDTH-LeftSpace, 44)];
        _bottomView.backgroundColor = BGColor;
        for (NSInteger  i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@[@"重置",@"确定"][i] forState:UIControlStateNormal];
            btn.titleLabel.font = Font(15);
            [btn addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = i?GLOBAL_RED_COLOR:WHITE_COLOR;
            [btn setTitleColor:(i?WHITE_COLOR:GRAY_COLOR(100)) forState:UIControlStateNormal];
            btn.frame = CGRectMake(_bottomView.width*0.5*i, 1, _bottomView.width*0.5, 44);
            btn.tag = i;
            [_bottomView addSubview:btn];
        }
    }
    return _bottomView;
}

@end


@implementation THScreeningViewSectionHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITE_COLOR;
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = GRAY_COLOR(81);
        _titleLabel.font = Font(15);
    }
    return _titleLabel;
}

@end

