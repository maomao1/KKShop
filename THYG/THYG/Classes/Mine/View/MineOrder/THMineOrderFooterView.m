//
//  THMineOrderFooterView.m
//  THYG
//
//  Created by Victory on 2018/6/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderFooterView.h"
#define kTag 9999

@interface THMineOrderFooterView ()
#pragma mark - 根据不同订单类型，显示不同按钮标题以及事件，所以这里没有具体指定名称
@property (nonatomic, strong) UIButton *orderBtnOne;
@property (nonatomic, strong) UIButton *orderBtnTwo;
@property (nonatomic, strong) UIButton *orderBtnThr;

@end

@implementation THMineOrderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setupUI {
    [self.contentView addSubview:self.orderBtnOne];
    [self.contentView addSubview:self.orderBtnTwo];
    [self.contentView addSubview:self.orderBtnThr];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = WHITE_COLOR;
    [self.orderBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(-12);
        make.height.offset(28);
        make.width.offset(80);
    }];
    
    [self.orderBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderBtnOne.mas_centerY);
        make.right.equalTo(self.orderBtnOne.mas_left).offset(-8);
        make.width.equalTo(self.orderBtnOne.mas_width);
        make.height.equalTo(self.orderBtnOne.mas_height);
    }];

    [self.orderBtnThr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderBtnTwo.mas_centerY);
        make.right.equalTo(self.orderBtnTwo.mas_left).offset(-8);
        make.width.equalTo(self.orderBtnOne.mas_width);
        make.height.equalTo(self.orderBtnOne.mas_height);
    }];
    
}

/*
待支付 0,
待发货 1,
部分发货 2,
待收货 3,
待评价 4,
交易取消5,
交易成功6,
交易作废7
 */

- (void)setOrderStatus:(OrderStatusType)orderStatus {
    _orderStatus = orderStatus;
    NSLog(@"_orderStatus %ld", _orderStatus);
    
    if (self.isReturnOrExchange) {
        if (_orderStatus == 0) { // 待确认
            [_orderBtnOne setTitle:@"查看详情" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"取消申请" forState:UIControlStateNormal];
            _orderBtnThr.hidden = YES;
            _orderBtnOne.hidden = _orderBtnTwo.hidden = NO;
            
        } else if (_orderStatus == 1) { // 待退回
            _orderBtnOne.hidden = NO;
            _orderBtnThr.hidden = _orderBtnTwo.hidden = YES;
            [_orderBtnOne setTitle:@"查看详情" forState:UIControlStateNormal];
            
        } else if (_orderStatus == 3) { // 已完成
            [_orderBtnOne setTitle:@"评论晒单" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"查看物流" forState:UIControlStateNormal];
            [_orderBtnThr setTitle:@"再次购买" forState:UIControlStateNormal];
            _orderBtnOne.hidden = _orderBtnTwo.hidden = _orderBtnThr.hidden = NO;
        }
        
    } else {
        
        if (_orderStatus == 0) { // 待支付
            [_orderBtnOne setTitle:@"取消订单" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"立即付款" forState:UIControlStateNormal];
            _orderBtnThr.hidden = YES;
            _orderBtnOne.hidden = _orderBtnTwo.hidden = NO;
            
        } else if (_orderStatus == 1) { // 待发货
            _orderBtnOne.hidden = NO;
            _orderBtnThr.hidden = _orderBtnTwo.hidden = YES;
            [_orderBtnOne setTitle:@"提醒发货" forState:UIControlStateNormal];
            
        } else if (_orderStatus == 2) { // 部分发货
            
            
        } else if (_orderStatus == 3) { // 待收货
            [_orderBtnOne setTitle:@"确认收货" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"查看物流" forState:UIControlStateNormal];
            _orderBtnThr.hidden = YES;
            _orderBtnOne.hidden = _orderBtnTwo.hidden = NO;
            
        } else if (_orderStatus == 4) { // 待评价
            [_orderBtnOne setTitle:@"评论晒单" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"再次购买" forState:UIControlStateNormal];
            _orderBtnThr.hidden = YES;
            _orderBtnOne.hidden = _orderBtnTwo.hidden = NO;
            
        } else if (_orderStatus == 5) { // 交易取消
            _orderBtnOne.hidden = _orderBtnTwo.hidden = _orderBtnThr.hidden = YES;
            UILabel *label = [UILabel labelWithText:@"缺少切图，流程图有问题，长点心好吗？" fontSize:Font14 color:RED_COLOR];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
            
        } else if (_orderStatus == 6) { // 交易成功
            [_orderBtnOne setTitle:@"评论晒单" forState:UIControlStateNormal];
            [_orderBtnTwo setTitle:@"查看物流" forState:UIControlStateNormal];
            [_orderBtnThr setTitle:@"再次购买" forState:UIControlStateNormal];
            _orderBtnOne.hidden = _orderBtnTwo.hidden = _orderBtnThr.hidden = NO;
            
        } else { // 交易作废
            
        }
        
    }
    
}

#pragma mark - 订单事件
- (void)orderAction:(UIButton *)sender {
    !self.orderActionBlock?:self.orderActionBlock(self.orderStatus, sender.tag - kTag);
}

#pragma mark - 懒加载
- (UIButton *)orderBtnOne {
    if (!_orderBtnOne) {
        _orderBtnOne = [[UIButton alloc] init];
        _orderBtnOne.layer.borderWidth = 1;
        _orderBtnOne.layer.cornerRadius = 14;
        _orderBtnOne.layer.borderColor = GRAY_COLOR(221).CGColor;
        [_orderBtnOne setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _orderBtnOne.titleLabel.font = Font14;
        _orderBtnOne.tag = kTag;
        [_orderBtnOne addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtnOne;
}

- (UIButton *)orderBtnTwo {
    if (!_orderBtnTwo) {
        _orderBtnTwo = [[UIButton alloc] init];
        _orderBtnTwo.layer.borderWidth = 1;
        _orderBtnTwo.layer.cornerRadius = 14;
        _orderBtnTwo.layer.borderColor = GRAY_COLOR(221).CGColor;
        [_orderBtnTwo setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _orderBtnTwo.titleLabel.font = Font14;
        _orderBtnTwo.tag = kTag + 1;
        [_orderBtnTwo addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtnTwo;
}

- (UIButton *)orderBtnThr {
    if (!_orderBtnThr) {
        _orderBtnThr = [[UIButton alloc] init];
        _orderBtnThr.layer.borderWidth = 1;
        _orderBtnThr.layer.cornerRadius = 14;
        _orderBtnThr.layer.borderColor = GRAY_COLOR(221).CGColor;
        [_orderBtnThr setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _orderBtnThr.titleLabel.font = Font14;
        _orderBtnThr.tag = kTag + 2;
        [_orderBtnThr addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtnThr;
}


@end
