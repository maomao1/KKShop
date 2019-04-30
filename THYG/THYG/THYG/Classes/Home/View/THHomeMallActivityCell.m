//
//  THHomeMallActivityCell.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeMallActivityCell.h"
#import "THHomeMallActivityItemCell.h"

@interface THHomeMallActivityCell () <UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray *_itemArray;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

static NSString * const THHomeMallActivityItemCellId = @"THHomeMallActivityItemCellId";

@implementation THHomeMallActivityCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self addSubview:self.titleLabel];
		[self addSubview:self.collectionView];
		_itemArray = @[
					   @{@"icon":@"3xianshimiaosha",
						 @"iconTitle":@"限时秒杀",
						 @"subTitle":@"",
						 @"oneImage":@"miaosha",
						 @"twoImage":@"miaosha1"
						 },
					  
					   @{@"icon":@"3tuangou",
						 @"iconTitle":@"团购",
						 @"subTitle":@"限时团购",
						 @"oneImage":@"tuangou1",
						 @"twoImage":@"tuangou2"
						 },
					   
					   @{@"icon":@"3meirituijian",
						 @"iconTitle":@"每日推荐",
						 @"subTitle":@"戳此马上了解",
						 @"oneImage":@"tuijian1",
						 @"twoImage":@"tuijian2"
						 },
					   
  						@{@"icon":@"3bimaiqingdan",
						 @"iconTitle":@"必买清单",
						 @"subTitle":@"整理好帮手",
						 @"oneImage":@"bimai1",
						 @"twoImage":@"bimai2"
						 },
					   ];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.offset(SCREEN_WIDTH);
		make.top.offset(0);
		make.height.offset(HEIGHT(44));
	}];
	
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom);
		make.left.bottom.right.offset(0);
	}];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { return _itemArray.count;}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	THHomeMallActivityItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:THHomeMallActivityItemCellId forIndexPath:indexPath];
	cell.itemType = (ITEM == 0) ? 0 : 1;
	cell.itemDict = _itemArray[ITEM];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.selectItemBlock?:self.selectItemBlock(indexPath.row);
}


- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [UILabel labelWithText:@"商城活动" fontSize:Font(26) color:RED_COLOR];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.backgroundColor = WHITE_COLOR;
	}
	return _titleLabel;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionVertical;
		layout.minimumLineSpacing = 1;
		layout.minimumInteritemSpacing = 1;
		layout.itemSize = CGSizeMake((SCREEN_WIDTH-2)*0.5, HEIGHT(108));
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.scrollEnabled = NO;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = BGColor;
		[_collectionView registerClass:[THHomeMallActivityItemCell class] forCellWithReuseIdentifier:THHomeMallActivityItemCellId];
	}
	return _collectionView;
}

@end
