//
//  THHomeHeaderView.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "THHomeHeaderItemCell.h"
#import "THHomeHeaderItemModel.h"

@interface THHomeHeaderView () <SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray *_images, *_titles;
	NSMutableArray *_itemsArray;
}
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIPageControl * pageControl;
@end

static NSString * const THHomeHeaderItemCellId = @"THHomeHeaderItemCell";

@implementation THHomeHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self addSubview:self.cycleScrollView];
		[self addSubview:self.collectionView];
		[self addSubview:self.pageControl];
		_cycleScrollView.imageURLStringsGroup = @[@"banner"];
		_images = @[@"zhongbulingqutebi",@"zhongbutechanguan",@"zhongbutechanguan",@"zhongbumeirituijian",@"zhongbu-tuangou",@"zhongjianmiaosha"];
		_titles = @[@"我的特币",@"农副批发",@"时令预售",@"每日推荐",@"团购",@"秒杀"];
		_itemsArray = [NSMutableArray arrayWithCapacity:0];
		for (NSInteger i = 0; i < _images.count; i++) {
			THHomeHeaderItemModel *model = [[THHomeHeaderItemModel alloc] init];
			model.image = _images[i];
			model.name = _titles[i];
			[_itemsArray addObject:model];
		}
		self.pageControl.numberOfPages = _images.count / 5;
		
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.offset(0);
		make.height.offset(HEIGHT(180));
	}];
	
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.offset(0);
		make.top.equalTo(self.cycleScrollView.mas_bottom);
		make.height.offset(HEIGHT(76));
	}];
	
	[self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.collectionView.mas_bottom).offset(HEIGHT(10));
		make.bottom.equalTo(self.mas_bottom);
		make.centerX.equalTo(self.collectionView.mas_centerX);
	}];
	
}

- (void)setImageUrls:(NSArray *)imageUrls {
	_imageUrls = imageUrls;
	self.cycleScrollView.imageURLStringsGroup = imageUrls;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	THHomeHeaderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:THHomeHeaderItemCellId forIndexPath:indexPath];
	THHomeHeaderItemModel *model = _itemsArray[indexPath.item];
	cell.itemModel = model;
	return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickMenuItem) {
        
        THHomeHeaderItemModel *model = _itemsArray[indexPath.item];
        self.clickMenuItem(indexPath.row,model.name);
    }
}

- (SDCycleScrollView *)cycleScrollView {
	if (!_cycleScrollView) {
		_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "]];
	}
	return _cycleScrollView;
}

- (UIPageControl *)pageControl {
	if (!_pageControl) {
		_pageControl = [[UIPageControl alloc] init];
		_pageControl.numberOfPages = 1;
		_pageControl.tintColor = GRAY_COLOR(151);
		_pageControl.currentPageIndicatorTintColor = GRAY_COLOR(51);
	}
	return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	self.pageControl.currentPage = (int)(scrollView.contentOffset.x / SCREEN_WIDTH);
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		layout.minimumLineSpacing = 0;
		layout.minimumInteritemSpacing = 0;
		layout.itemSize = CGSizeMake(SCREEN_WIDTH / 5, HEIGHT(76));
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = BGColor;
		_collectionView.pagingEnabled = YES;
		[_collectionView registerNib:NIB(@"THHomeHeaderItemCell") forCellWithReuseIdentifier:THHomeHeaderItemCellId];
	}
	return _collectionView;
}


@end
