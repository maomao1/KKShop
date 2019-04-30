//
//  THTeHuiCenterVC.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCenterVC.h"
#import "THTeHuiCell.h"
#import "THTeHuiModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface THTeHuiCenterVC ()
@property (nonatomic, strong) UIButton *titleBtnView;
@property (nonatomic, strong) UIView *topView;
@end

@implementation THTeHuiCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
//    for (int i = 0; i < 10; i++) {
//
//        THTeHuiModel *model = [[THTeHuiModel alloc] init];
//        model.userName = [NSString stringWithFormat:@"用户%d",i];
//        model.time = [NSString stringWithFormat:@"%d分钟前",i+arc4random_uniform(40)];
//        model.content = @"这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论";
//        model.images = @[@"shangpin1",@"shangpin2",@"shangpin3"];
//        model.goodsName = @"假数据假数据假数据假数据假数据假数据";
//        [self.dataSourceArray addObject:model];
//    }
    
    [self getMyCommentList:@"1"];
    
}

- (void)setupUI {
    self.navigationItem.leftBarButtonItem = self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = self.titleBtnView;
    [self.view addSubview:self.topView];
    
    self.isGrouped = YES;
    self.dataTableView.frame = CGRectMake(0, 44+8, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-kTabBarHeight-52);
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerClass:[THTeHuiCell class] forCellReuseIdentifier:STRING(THTeHuiCell)];
    
    self.menuView.data = @[@"晒单",@"特"];
    [self.view addSubview:self.menuView];
    
}

#pragma mark - 获取晒单列表
- (void)getMyCommentList:(NSString *)type {
    [THNetworkTool POST:API(@"/Order/myCommentList") parameters:@{@"token":@"35c93d3dfeaf485acb9676ba2aa5b586", @"type":type} completion:^(id responseObject, NSDictionary *allResponseObject) {
//        NSLog(@"responseObject %@", responseObject);
        self.dataSourceArray = [THTeHuiModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        [self.dataTableView reloadData];
        
    }];
}


#pragma mark - UITableView 代理 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THTeHuiCell * cell = [tableView dequeueReusableCellWithIdentifier:STRING(THTeHuiCell)];
    cell.teModel = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    id model = self.dataSourceArray[indexPath.row];
//    return [self.dataTableView cellHeightForIndexPath:indexPath model:model keyPath:@"teModel" cellClass:[THTeHuiCell class] contentViewWidth:SCREEN_WIDTH];
    return 320;
}

//- (CGFloat)cellContentViewWith
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//
//    // 适配ios7横屏
//    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//        width = [UIScreen mainScreen].bounds.size.height;
//    }
//    return width;
//}

#pragma mark - 按钮点击事件
- (void)btnClick {
    [self.menuView show];
    self.titleBtnView.selected = YES;
    WEAKSELF
    self.menuView.selectedAction = ^(NSInteger index) {
        weakSelf.titleBtnView.selected = NO;
        
    };
}

- (void)topViewClick:(UIButton *)sender {
    NSInteger tag = sender.tag - SCREEN_WIDTH;
    NSLog(@"tag %ld", tag);
    [self getMyCommentList:[NSString stringWithFormat:@"%ld", tag+1]];
}

#pragma mark - titleBtnView
- (UIButton*)titleBtnView {
    if (!_titleBtnView) {
        _titleBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtnView.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtnView setTitle:@"晒单" forState:UIControlStateNormal];
        [_titleBtnView setImage:IMAGENAMED(@"down") forState:UIControlStateNormal];
        [_titleBtnView setImage:IMAGENAMED(@"up") forState:UIControlStateSelected];
        _titleBtnView.titleLabel.font = Font(15);
        [_titleBtnView layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:3];
        [_titleBtnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtnView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _topView.backgroundColor = BGColor;
        NSArray *titles = @[@"综合",@"评论数",@"好评率"];
        CGFloat bW = (SCREEN_WIDTH - 2) / 3;
        CGFloat bX = 0;
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i + SCREEN_WIDTH;
            btn.titleLabel.font = Font14;
            btn.backgroundColor = WHITE_COLOR;
            [btn setTitleColor:GRAY_51 forState:UIControlStateNormal];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            bX = i > 0 ? (bW + 1) * i  : 0;
            btn.frame = CGRectMake(bX, 0, bW, 44);
            [btn addTarget:self action:@selector(topViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [_topView addSubview:btn];
        }
        
    }
    return _topView;
}

@end
