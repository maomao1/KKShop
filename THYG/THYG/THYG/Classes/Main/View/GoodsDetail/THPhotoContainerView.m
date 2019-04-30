//
//  THPhotoContainerView.m
//  THYG
//
//  Created by Colin on 2018/4/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPhotoContainerView.h"

@interface THPhotoContainerView ()

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation THPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    [self.imageViewsArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.hidden = YES;
        
    }];
    
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        return;
    }
    
    long perRowItemCount = 4;
    CGFloat margin = 10;
    
    CGFloat itemW = (SCREEN_WIDTH - margin * (perRowItemCount+1)) / perRowItemCount;
    CGFloat itemH = itemW;
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = SCREEN_WIDTH - margin * 2;
    int columnCount = _picPathStringsArray.count < 4 ? 1 : (_picPathStringsArray.count%4 ? _picPathStringsArray.count%4+1 : _picPathStringsArray.count%4);
    CGFloat h = itemH * columnCount + (columnCount-1)*margin;
    self.width = w;
    self.height = h;
    
}

#pragma mark - 浏览图片
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
}

@end
