//
//  THSpellGroupHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHead.h"
#import "THSpellGroupHeadCell.h"
#define TIME_KEY @"time"
#define STATUS_KEY @"status"
#define IS_ING_KEY @"is_ing"

@interface THSpellGroupHead()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation THSpellGroupHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    THSpellGroupHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THSpellGroupHeadCell) forIndexPath:indexPath];
    [cell refreshWithDic:self.data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSMutableDictionary *dic in self.data) {
        dic[IS_ING_KEY] = @"0";
    }
    NSMutableDictionary *dic = self.data[indexPath.row];
    dic[IS_ING_KEY] = @"1";
    [collectionView reloadData];
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:@[@{TIME_KEY:@"18:00",STATUS_KEY:@"团购中",IS_ING_KEY:@"1"}.mutableCopy,
                                     @{TIME_KEY:@"19:00",STATUS_KEY:@"即将开始",IS_ING_KEY:@"0"}.mutableCopy,
                                     @{TIME_KEY:@"20:00",STATUS_KEY:@"即将开始",IS_ING_KEY:@"0"}.mutableCopy,
                                     @{TIME_KEY:@"21:00",STATUS_KEY:@"即将开始",IS_ING_KEY:@"0"}.mutableCopy,
                                     @{TIME_KEY:@"22:00",STATUS_KEY:@"即将开始",IS_ING_KEY:@"0"}.mutableCopy
                                     ]];
    }
    return _data;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-self.data.count-1)/5, 50);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:STRING(THSpellGroupHeadCell) bundle:nil] forCellWithReuseIdentifier:STRING(THSpellGroupHeadCell)];
    }
    return _collectionView;
}

@end
