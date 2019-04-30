//
//  THAlertLayer.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THAlertViewModel.h"

@interface THAlertLayer : UIView

@property (nonatomic, strong) THAlertViewModel *alertModel;
@property (nonatomic, copy) void(^sureBlock)(NSString *content);
@property (nonatomic, copy) void(^cancelBlock)();
@property (nonatomic, copy) void(^textFieldRightIconTappedHander)(void);

@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *sure;

//show在传alertModel之前调用
- (void)show;
- (void)dismiss;

@end
