//
//  THShareView.m
//  THYG
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareView.h"
#import "THShareViewCell.h"

@interface THShareView () <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
//    所有标题
@property (nonatomic, copy) NSArray  *shareBtnTitleArray;
//    所有图片
@property (nonatomic, copy) NSArray  *shareBtnImageArray;
@end

@implementation THShareView

- (instancetype)initShareViewWithTitle:(NSArray *)titleArray andImageArry:(NSArray *)imageArray  {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = GRAY(0, 0.3);
        _shareBtnImageArray = imageArray;
        _shareBtnTitleArray = titleArray;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.collectionView];
        [self.bgView addSubview:self.cancelBtn];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
        tapGes.delegate = self;
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44*2+SCREEN_WIDTH*0.5);
    self.titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    self.collectionView.frame = CGRectMake(0, 44, SCREEN_WIDTH, self.bgView.height-44*2);
    self.cancelBtn.frame = CGRectMake(0, self.bgView.height-44, SCREEN_WIDTH, 44);
    //    弹出
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - self.bgView.height, SCREEN_WIDTH, self.bgView.height);
    }];
    
}

- (void)cancelClick {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.y = SCREEN_HEIGHT;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shareBtnTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    THShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STRING(THShareViewCell) forIndexPath:indexPath];
    cell.imageName = self.shareBtnImageArray[indexPath.item];
    cell.iconName = self.shareBtnTitleArray[indexPath.item];
    
    return cell;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.bgView]) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    !self.selectItemBlock?:self.selectItemBlock(indexPath.item);
    [self cancelClick];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH * 0.25, SCREEN_WIDTH * 0.25);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[THShareViewCell class] forCellWithReuseIdentifier:STRING(THShareViewCell)];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"分享到" fontSize:Font16 color:GRAY_151];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = Font15;
        _cancelBtn.backgroundColor = GRAY_COLOR(242);
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
