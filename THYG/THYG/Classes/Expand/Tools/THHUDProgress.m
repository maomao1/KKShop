//
//  THHUDProgress.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHUDProgress.h"

@implementation THHUDProgress

+ (THHUDProgress*)sharedProgressHUD
{
    static THHUDProgress *progressHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressHUD = [[THHUDProgress alloc]init];
        [progressHUD config];
    });
    return progressHUD;
}

- (void)config
{
    //设置属性
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setBackgroundColor:GRAY(0, 0.7)];
    [SVProgressHUD setForegroundColor:WHITE_COLOR];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setMaximumDismissTimeInterval:4];
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"infoIcon"]];
//    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"successIcon"]];
//    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"errorIcon"]];
}

- (void)showSuccess:(NSString *)msg
{
    [SVProgressHUD showSuccessWithStatus:msg];
}

- (void)showError:(NSString *)msg
{
    [SVProgressHUD showErrorWithStatus:msg];
}

- (void)showMsg:(NSString *)msg
{
    [SVProgressHUD showInfoWithStatus:msg];
}

- (void)showProgress:(CGFloat)progress msg:(NSString *)msg
{
    [SVProgressHUD showProgress:progress status:msg];
}

- (void)showImage:(UIImage *)image msg:(NSString *)msg
{
    [SVProgressHUD showImage:image status:msg];
}

- (void)show
{
    [SVProgressHUD show];
}

- (void)show:(NSString *)msg
{
    [SVProgressHUD showWithStatus:msg];
}

- (void)dismiss
{
    [SVProgressHUD dismiss];
}


@end
