//
//  THCommentCateView.m
//  THYG
//
//  Created by 廖辉 on 2018/6/11.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentCateView.h"
#import "THCommentCateViewCell.h"
#import "THCommentCateModel.h"

@interface THCommentCateView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation THCommentCateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = @[].mutableCopy;
        NSArray *array = @[@"全部",@"好评",@"中评",@"差评",@"有图"];
        for (NSInteger i = 0; i < array.count; i++) {
            THCommentCateModel *model = [[THCommentCateModel alloc] init];
            [self.data addObject:model];
        }
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
    THCommentCateViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THCommentCateViewCell" forIndexPath:indexPath];
    THCommentCateModel *model = self.data[indexPath.item];
    cell.isSelct = model.isSelect;
    return cell;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 30);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"THCommentCateViewCell" bundle:nil] forCellWithReuseIdentifier:@"THCommentCateViewCell"];
    }
    return _collectionView;
}

@end
