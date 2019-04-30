//
//  THNewFeatureVC.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THNewFeatureVC.h"
#import "THNewFeatureCell.h"

@interface THNewFeatureVC () <UICollectionViewDataSource,UICollectionViewDelegate>
/** 引导页图片数组 */
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation THNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
//	@{@"image":@"引导页1",
//	  @"title":@"特惠易购",
//	  @"subTitle":@"特产汇聚 简单易购"},
//
//	@{@"image":@"引导页2",
//	  @"title":@"商品全新升级",
//	  @"subTitle":@"品类细分一目了然"},
//
//	@{@"image":@"引导页3",
//	  @"title":@"各大活动来袭",
//	  @"subTitle":@"应有尽有 一逛不停"}
	
	self.itemArray = @[
					   @{@"image":@"引导页1"},
					   @{@"image":@"引导页2"},
					   @{@"image":@"引导页3"}
					   ];
	
	// 设置CollectionView
	[self setupCollectionView];
	
	// 设置pageControl
	[self setupPageControl];
	
}

#pragma mark - 设置CollectionView
- (void)setupCollectionView {
	self.collectionView = ({
		UICollectionViewFlowLayout *layout = ({
			UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
			layout.minimumInteritemSpacing = 0;
			layout.minimumLineSpacing = 0;
			layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-50);
			layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
			
			layout;
		});
		
		UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
		collectionView.pagingEnabled = YES;
		collectionView.backgroundColor = [UIColor whiteColor];
		collectionView.delegate = self;
		collectionView.dataSource = self;
		collectionView.bounces = NO;
		collectionView.showsHorizontalScrollIndicator = false;
		collectionView.showsVerticalScrollIndicator = false;
		
		collectionView;
	});
	
	[self.collectionView registerClass:[THNewFeatureCell class] forCellWithReuseIdentifier:STRING(THNewFeatureCell)];
	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

#pragma mark - 设置pageControl
- (void)setupPageControl {
	self.pageControl = ({
		UIPageControl *pageControl = [[UIPageControl alloc]init];
		pageControl.numberOfPages = self.itemArray.count;
		pageControl.currentPage = 0;
		// 改变小圆点的颜色
		pageControl.currentPageIndicatorTintColor = RGB(255, 167, 30);
		pageControl.pageIndicatorTintColor = RGB(255, 237, 206);
		
		[pageControl setValue:IMAGENAMED(@"yuandian") forKey:@"pageImage"];
		[pageControl setValue:IMAGENAMED(@"yuandiandongxiao") forKey:@"currentPageImage"];
	
		pageControl;
	});
	
	[self.view addSubview:self.pageControl];
	[self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(10);
		make.centerX.equalTo(self.view.mas_centerX);
		make.bottom.equalTo(self.view.mas_bottom).offset(-30 * KBHeightRatio);
	}];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	THNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THNewFeatureCell) forIndexPath:indexPath];
	// 设置cell ImageView
	cell.itemDict = self.itemArray[indexPath.row];
	
	// 给最后一个cell添加按钮
	[cell setLastIndexPath:indexPath count:self.itemArray.count];
	
	return cell;
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSInteger index = (scrollView.contentOffset.x + self.view.frame.size.width * 0.5)/ self.view.frame.size.width;
	self.pageControl.currentPage = index;
}


@end
