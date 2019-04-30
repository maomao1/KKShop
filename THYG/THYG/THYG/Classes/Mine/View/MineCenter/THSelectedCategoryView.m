//
//  THSelectedCategoryView.m
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSelectedCategoryView.h"

@interface THSelectedCategoryView () <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIView *topV;
    NSInteger selectedIndex;
}
@property (nonatomic, strong) UIPickerView *picker;
@end

@implementation THSelectedCategoryView

+ (instancetype)sharedInstance {
    static THSelectedCategoryView *selectedItenView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectedItenView = [[THSelectedCategoryView alloc] init];
    });
    return selectedItenView;
}

- (instancetype)init {
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT(40))];
        topV.backgroundColor = GRAY_COLOR(242);
        [self addSubview:topV];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, WIDTH(100), HEIGHT(40));
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:Font16];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [topV addSubview:cancelBtn];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(SCREEN_WIDTH - WIDTH(100), 0, WIDTH(100), HEIGHT(40));
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:Font16];
        [yesBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
        [topV addSubview:yesBtn];
        
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, topV.bottom, SCREEN_WIDTH, HEIGHT(150))];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.backgroundColor = [UIColor whiteColor];
        [self addSubview:_picker];
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        topV.frame = CGRectMake(0, SCREEN_HEIGHT - HEIGHT(190), SCREEN_WIDTH, HEIGHT(40));
        _picker.frame = CGRectMake(0, topV.bottom, SCREEN_WIDTH, HEIGHT(150));
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_picker reloadAllComponents];
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataArray objectAtIndex:row];
}

#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedIndex = row;
}

- (void)okClick {
    !self.selectedItemBlock?:self.selectedItemBlock(self.dataArray[selectedIndex]);
    [self remove];
}

- (void)cancelClick {
    [self remove];
}

- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        topV.frame = CGRectMake(0, SCREEN_HEIGHT,  SCREEN_WIDTH, HEIGHT(40));
        _picker.frame = CGRectMake(0, topV.bottom, SCREEN_WIDTH, HEIGHT(150));
    } completion:^(BOOL finished) {
    }];
    
    [self removeFromSuperview];
    
}

@end
