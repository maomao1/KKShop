//
//  THNavigationController.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THNavigationController.h"

@interface THNavigationController () <UINavigationControllerDelegate>

@end

@implementation THNavigationController

#pragma mark - 设置UIUINavigationBar的主题
+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:GLOBAL_RED_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{/*NSFontAttributeName:[UIFont systemFontOfSize:19],*/ NSForegroundColorAttributeName:WHITE_COLOR}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.delegate = self;
}

#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;

        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }

        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        viewController.hidesBottomBarWhenPushed = YES;
        // 就有滑动返回功能
        
    }
    // 跳转
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark - 点击
- (void)backButtonTapClick {
	[self popViewControllerAnimated:YES];
}


@end
