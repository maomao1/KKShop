//
//  THHUDProgress.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface THHUDProgress : NSObject

+ (THHUDProgress*)sharedProgressHUD;

/*****成功*****/
- (void)showSuccess:(NSString*)msg;
/*****失败*****/
- (void)showError:(NSString*)msg;

/*****提示文字*****/
- (void)showMsg:(NSString*)msg;

/****展示图片*****/
- (void)showImage:(UIImage*)image msg:(NSString*)msg;

/*****下载/上传 进度条*****/
- (void)showProgress:(CGFloat)progress msg:(NSString*)msg;

/*****请求网络加载指示器*****/
/*****显示*****/
- (void)show;
- (void)show:(NSString*)msg;
/*****隐藏*****/
- (void)dismiss;

@end
