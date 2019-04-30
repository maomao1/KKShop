//
//  THSpellGroupCtl.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupCtl.h"
#import "THSpellGroupSectionHead.h"
#import "THAceSpellGroupListCell.h"
#import "THMoreSpellGroupListCell.h"
#import "THSpellGroupHead.h"

@interface THSpellGroupCtl ()

@end

@interface THSpellGroupCtl () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THSpellGroupHead *headView;
@end

@implementation THSpellGroupCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB(59, 59, 59)] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 4;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        THAceSpellGroupListCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THAceSpellGroupListCell) forIndexPath:indexPath];
        return cell;
    }
    THMoreSpellGroupListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THMoreSpellGroupListCell) forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        THSpellGroupSectionHead *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:STRING(THSpellGroupSectionHead) forIndexPath:indexPath];
        headerV.sectionTitle = @[@"王牌拼团",@"更多精彩拼团"][SECTION];
        reusableview = headerV;
        
    }else{
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
    }
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SECTION == 0) return CGSizeMake((SCREEN_WIDTH-4)/2, (SCREEN_WIDTH-4)/2+210);
    return CGSizeMake(SCREEN_WIDTH, 130);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 45);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headView.height, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-self.headView.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THAceSpellGroupListCell) bundle:nil] forCellWithReuseIdentifier:STRING(THAceSpellGroupListCell)];
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THMoreSpellGroupListCell) bundle:nil] forCellWithReuseIdentifier:STRING(THMoreSpellGroupListCell)];

        [_collectionView registerClass:[THSpellGroupSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:STRING(THSpellGroupSectionHead)];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        
        
    }
    return _collectionView;
}

- (THSpellGroupHead *)headView
{
    if (!_headView) {
        _headView = [[THSpellGroupHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    }
    return _headView;
}

@end

