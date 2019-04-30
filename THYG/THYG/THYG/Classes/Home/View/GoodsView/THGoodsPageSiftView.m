//
//  THGoodsPageSiftView.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsPageSiftView.h"

@interface THGoodsPageSiftView ()
@property (nonatomic,strong) NSMutableArray<UIButton*> *btnData;
@end

@implementation THGoodsPageSiftView

- (NSMutableArray<UIButton*>*)btnData
{
    if (!_btnData) {
        _btnData = [[NSMutableArray alloc]init];
    }
    return _btnData;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

//- (void)setIsAscOfSalesCount:(BOOL)isAscOfSalesCount
//{
//    _isAscOfSalesCount = isAscOfSalesCount;
//    if (_isAscOfSalesCount) {
//        [self.btnData[1] setImage:IMAGENAMED(@"up_thrAngle") forState:UIControlStateNormal];
//    }else{
//        [self.btnData[1] setImage:IMAGENAMED(@"down_thrAngle") forState:UIControlStateNormal];
//    }
//}

- (void)setIsAscOfPrice:(BOOL)isAscOfPrice
{
    _isAscOfPrice = isAscOfPrice;
    if (_isAscOfPrice) {
        [self.btnData[2] setImage:IMAGENAMED(@"up_thrAngle") forState:UIControlStateNormal];
    }else{
        [self.btnData[2] setImage:IMAGENAMED(@"down_thrAngle") forState:UIControlStateNormal];
    }
}

#pragma mark - 设置UI界面
- (void)setupUI {
    self.backgroundColor = BGColor;
    NSArray *titles = @[@"综合",@"销量",@"价格",@"筛选"];
    NSArray *images = @[@"",@"",@"shangxiajiantou",@"shaixuan"];
    
    CGFloat bX = 0;
    CGFloat bW = 0;
    CGFloat bY = 0;
    CGFloat bH = 44;
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithTitle:titles[i] image:images[i] fontSize:Font(13) textColor:GRAY_COLOR(80) target:self action:@selector(conditionSift:)];
        button.backgroundColor = WHITE_COLOR;
        [button setTitleColor:GRAY_COLOR(80) forState:UIControlStateNormal];
        [button setTitleColor:GLOBAL_RED_COLOR forState:UIControlStateSelected];
        button.tag = i;
        
        bW = (SCREEN_WIDTH - (titles.count-1))/titles.count;
        bX = i * (bW + 1);
        
        button.frame = CGRectMake(bX, bY, bW, bH);
        
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:3];
        [self addSubview:button];
        
        [self.btnData addObject:button];
    }
}



#pragma mark - 条件筛选
- (void)conditionSift:(UIButton *)sender {
    for (UIButton *btn in self.btnData) {
        btn.selected = NO;
    }
    sender.selected = YES;
    if (self.siftClickBlock) {
        self.siftClickBlock(sender.tag);
    }
}

@end
