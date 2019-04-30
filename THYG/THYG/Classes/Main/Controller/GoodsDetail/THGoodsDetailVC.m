//
//  THGoodsDetailVC.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsDetailVC.h"
#import "THGoodsVC.h"
#import "THCommentVC.h"
#import "THBaseWebVC.h"
#import "THShoppingCartCtl.h"
#import "THGoodsDetailBottomView.h"
#import "THGoosDetailModel.h"
#import "THGoodsCommentModel.h"
#import "THGoodsSpecModel.h"

@interface THGoodsDetailVC () <UIScrollViewDelegate>
@property (nonatomic, strong) THGoodsDetailBottomView *bottomView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bgView;@property (weak, nonatomic)   UIButton *selectBtn;  // 记录上一次选中的Button
@property (weak, nonatomic)   UIView *indicatorView; // 标题按钮地下的
/** 商品详情数组*/
@property (nonatomic, strong) THGoosDetailModel *detailModel;

@property (nonatomic, strong) THGoodsVC *goodsVc;

@property (nonatomic, strong) THBaseWebVC *webVc;

// 所选规格id和商品数量
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *count;

@end

@implementation THGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getGoodsDetail];
    [self getComments];
    [self getCartSpec];
}

#pragma mark - 设置UI
- (void)setupUI {
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];
    [self setUpChildViewControllers];
    [self addChildViewController];
    [self setUpTopButtonView];
    self.scrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    
    WEAKSELF;
    self.bottomView.buttomButtonBlock = ^(NSInteger tag) {
      
        //数据还没有请求回来，不响应按钮事件
        if (!weakSelf.detailModel) {
            return;
        }
        switch (tag) {
                // 客服
            case 0:
                [THHUD showMsg:@"没有客服电话"];
                break;
                // 购物车
            case 1: {
                THShoppingCartCtl *shoppingVc = [[THShoppingCartCtl alloc] init];
                shoppingVc.title = @"购物车";
                [weakSelf pushVC:shoppingVc];
            }
                
                break;
                // 添加购物车
            case 2:
                [weakSelf addCart];
                break;
                
            default:
                break;
        }
        
    };
    
    self.goodsVc.specBlock = ^(NSString *itemId, NSString *count) {
        weakSelf.itemId = itemId;
        weakSelf.count = count;
        NSLog(@"itemId%@, count%@", weakSelf.itemId, weakSelf.count);
    };
    
}

#pragma mark - 获取商品详情
- (void)getGoodsDetail {

    [THNetworkTool POST:API(@"/Goods/getGoodsDetail") parameters:@{@"token":TOKEN, @"goods_id":self.goodsId} completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        if (responseObject) {
            self.detailModel = [THGoosDetailModel mj_objectWithKeyValues:responseObject[@"info"][@"goods"]];
            self.goodsVc.bannerArr = [THGoodsDetailBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"][@"goods_images_list"]];
            self.detailModel.isCollected = [responseObject[@"info"][@"collect"] integerValue];
            self.goodsVc.detailModel = self.detailModel;
            self.webVc.webContent = self.detailModel.goods_content;
        }
        
    }];
}

#pragma mark -- 添加购物车
- (void)addCart {
    
    if (!self.itemId || !self.count) {
        self.itemId = @"0";
        self.count = @"1";
    }
    
    [THNetworkTool POST:API(@"/Cart/addCart")
             parameters:@{@"goods_id":self.detailModel.goods_id,
                          @"goods_num":self.count,
                          @"item_id":self.itemId,
                          @"token":TOKEN
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 
                 [THHUD showSuccess:@"成功加入购物车"];
                 
             }];
}

#pragma mark - comment
- (void)getComments {
    [THNetworkTool POST:API(@"/Goods/getCommentList") parameters:@{@"token":TOKEN, @"goods_id":self.goodsId} completion:^(id responseObject, NSDictionary *allResponseObject) {
        if (responseObject) {
            self.goodsVc.commentArr = [THGoodsCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
            [self.goodsVc.commentArr enumerateObjectsUsingBlock:^(THGoodsCommentModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                int columnCount = obj.img.count < 4 ? 1 : (obj.img.count%4 ? obj.img.count%4+1 : obj.img.count%4);
                CGFloat picHeight = obj.img.count == 0 ? 0 : ((SCREEN_WIDTH - 10 * (4+1)) / 4) * columnCount + (columnCount - 1)*10;
                obj.cellHeight = [obj.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(11)} context:nil].size.height + picHeight + 120;
                
            }];
            self.goodsVc.commentRatio = responseObject[@"goods_ratio"];
        }
        
    }];
}

#pragma mark - 获取商品规格
- (void)getCartSpec {
    [THNetworkTool POST:API(@"/Cart/getCartSpec") parameters:@{@"token":TOKEN, @"goods_id":self.goodsId} completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        self.goodsVc.goodsSpecModel = [THGoodsSpecModel mj_objectWithKeyValues:responseObject[@"info"]];
    
    }];
    
}


#pragma mark - 添加子控制器View
- (void)addChildViewController {
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    UIViewController *childVc;
    if (self.childViewControllers.count) {
        childVc = self.childViewControllers[index];
    }
    
    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - 添加子控制器
- (void)setUpChildViewControllers {
    
    [self addChildViewController:self.goodsVc];
    [self addChildViewController:self.webVc];
    
    THCommentVC *commentVc = [[THCommentVC alloc] init];
    commentVc.goods_id = self.goodsId;
    commentVc.view.backgroundColor = BGColor;
    [self addChildViewController:commentVc];
    
}

#pragma mark - 头部View
- (void)setUpTopButtonView {
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.centerX = SCREEN_WIDTH * 0.5;
        _bgView.height = 44;
        _bgView.width = (_bgView.height + margin) * titles.count;
        _bgView.y = 0;
    }
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.height;
    CGFloat buttonH = _bgView.height;
    CGFloat buttonY = _bgView.y;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:GRAY_COLOR(17) forState:UIControlStateNormal];
        [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        button.tag = i;
        button.titleLabel.font = Font(16);
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_bgView addSubview:button];
        
    }
    
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.height = 2;
    indicatorView.y = _bgView.height - indicatorView.height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.width = firstButton.titleLabel.width;
    indicatorView.centerX = firstButton.centerX;
    
    [_bgView addSubview:indicatorView];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildViewController];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = _bgView.subviews[index];
    [self topBottonClick:button];
    [self addChildViewController];
}

#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button {
    
    for (UIView *v in self.bgView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            ((UIButton*)v).selected = NO;
        }
    }
    button.selected = YES;

    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = _scrollView.contentOffset;
    offset.x = _scrollView.width * button.tag;
    [_scrollView setContentOffset:offset animated:YES];
}

#pragma mark - LazyLoad
- (THGoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[THGoodsDetailBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-kNaviHeight-50, SCREEN_WIDTH, 50)];
    }
    return _bottomView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-50);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        //_scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (THGoodsVC *)goodsVc {
    if (!_goodsVc) {
        _goodsVc = [[THGoodsVC alloc] init];
    }
    return _goodsVc;
}

- (THBaseWebVC *)webVc {
    if (!_webVc) {
        _webVc = [[THBaseWebVC alloc] init];
    }
    return _webVc;
}

@end
