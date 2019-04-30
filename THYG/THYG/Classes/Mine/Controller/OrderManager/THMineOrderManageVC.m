//
//  THMineOrderManageVC.m
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderManageVC.h"
#import "THMineOrderListPageVC.h"

@interface THMineOrderManageVC ()

@end

@implementation THMineOrderManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = self.type ? @"退/换货订单" : @"我的订单";
    NSArray *titleArray = self.type ? @[@"全部",@"待确认",@"待退回",@"已完成"] : @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    NSArray *statusArray = self.type ? @[@"", @"0", @"1", @"3"] : @[@"", @"WAITPAY", @"WAITSEND",@"WAITRECEIVE",@"WAITCCOMMENT"];
    NSInteger index = 0;
    for (NSString *title in titleArray) {
        THMineOrderListPageVC *pageVc = [[THMineOrderListPageVC alloc]init];
        pageVc.title = title;
        pageVc.status = statusArray[index++];
        pageVc.type = self.type;
        [self addChildViewController:pageVc];
    }
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleScrollViewColor = WHITE_COLOR;
        *norColor = RGB(102, 102, 102);
        *selColor = GLOBAL_RED_COLOR;
        *titleFont = Font(14);
        *titleHeight = 40;
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineDelayScroll = NO;
        *underLineH = 2;
        *underLineColor = GLOBAL_RED_COLOR;
        *isUnderLineEqualTitleWidth = NO;
    }];
    
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNaviHeight);
    }];
    
    [self refreshDisplay];
    
}


@end
