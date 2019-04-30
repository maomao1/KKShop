//
//  THTabBarController.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTabBarController.h"
#import "THNavigationController.h"
#import "THHomeVC.h"
#import "THMineVC.h"
#import "THClassifyVC.h"
#import "THShoppingCartCtl.h"
#import "THTeHuiCenterVC.h"
#import "THTeCtl.h"


@interface THTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *middleButton;

@end

@implementation THTabBarController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextAttributes];
    [self addChildViewControllers];
    self.delegate = self;
}

#pragma mark - 设置文字属性
- (void)setTextAttributes {
    // 设置文字正常时的属性
    NSMutableDictionary * normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = GRAY_COLOR(102);
    normalAttrs[NSFontAttributeName] = Font10;
    // 选中文字的属性
    NSMutableDictionary * selectedAtrrs = [NSMutableDictionary dictionary];
    selectedAtrrs[NSForegroundColorAttributeName] = RED_COLOR;
    selectedAtrrs[NSFontAttributeName] = Font10;
    // 设置
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR]];
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupMiddleButton];
}

#pragma mark - 设置中间按钮
- (void)setupMiddleButton {
    CGRect rect = self.tabBar.bounds;
    CGFloat w = rect.size.width / self.childViewControllers.count - 1;
    self.middleButton.frame = CGRectInset(rect, 2 * w, 0);
    self.middleButton.height = 49;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[THTeHuiCenterVC class]]) {
        self.middleButton.selected = NO;
    }
}


#pragma mark - 设置子控制器
- (void)addChildViewControllers {
	
	[self setupOneChildViewController:[[THHomeVC alloc] init] title:@"首页" image:@"dibu-shouye" selectedImage:@"dibu-shouye-xuanzhong"];
	
    [self setupOneChildViewController:[[THClassifyVC alloc] init] title:@"分类" image:@"dibufenlei" selectedImage:@"dibu-fenleixuanzhong"];
    
    [self setupOneChildViewController:[[THTeHuiCenterVC alloc] init] title:@"" image:@"" selectedImage:@""];
    
	[self setupOneChildViewController:[[THShoppingCartCtl alloc] init] title:@"购物车" image:@"dibugouwuche" selectedImage:@"dibu-gouwuche-xuanzhong"];
	
    [self setupOneChildViewController:[[THMineVC alloc] init] title:@"我的" image:@"dibu-wode" selectedImage:@"dibu-wode-xuanzhong"];
	
}

#pragma mark - 添加一个子控制器
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    vc.view.backgroundColor = BGColor;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageWithOrignalImageNamed:selectedImage];
	THNavigationController *nav = [[THNavigationController alloc] initWithRootViewController:vc];
	[self addChildViewController:nav];
}

#pragma mark - 点击中间按钮
- (void)clickMiddleButton {
    self.middleButton.selected = YES;
    [self setSelectedIndex:2];
}

#pragma mark - 懒加载
- (UIButton *)middleButton {
    if (_middleButton == nil) {
        _middleButton = [[UIButton alloc] init];
        [_middleButton setImage:[UIImage imageNamed:@"dibu-te"] forState:UIControlStateNormal];
        [_middleButton setImage:[UIImage imageNamed:@"dibu-te-xuanzhong"] forState:UIControlStateSelected];
        [_middleButton addTarget:self action:@selector(clickMiddleButton) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:_middleButton];
    }
    return _middleButton;
}

@end
