//
//  THMineHeaderView.h
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THMineHeaderView : UIView

@property (nonatomic,strong) UIImageView *headImgView;

// 是否签到了
@property (assign, nonatomic) BOOL isSigned;

/**
 修改用户信息回调
 */
@property (nonatomic,copy) void(^gotoMotifyInfoPage)(void);

/**
 签到回调信息
 */
@property (nonatomic,copy) void(^checkOnBlock)(void);

- (void)refreshUI;

@end
