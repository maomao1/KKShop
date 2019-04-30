//
//  THAlertView.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAlertView.h"
#import "THAlertLayer.h"

@implementation THAlertView

+ (void)alertViewWithTitle:(NSString *)title
                   content:(NSString *)content
           confirmBtnTitle:(NSString*)confirmBtnTitle
            cancelBtnTitle:(NSString*)cancelBtnTitle
           confirmCallback:(confirmClickBlock)confirmCallback
            cancelCallback:(cancelClickBlock)cancelCallback
{
    THAlertViewModel *alertModel = [THAlertViewModel new];
    alertModel.title = title;
    alertModel.content = content;
    alertModel.cancelBtnTitle = cancelBtnTitle;
    alertModel.confirmBtnTitle = confirmBtnTitle;
    THAlertLayer *alertView = [THAlertLayer new];
    [alertView show];
    alertView.alertModel = alertModel;
    if (confirmBtnTitle.length) {
        [alertView.sure setTitle:confirmBtnTitle forState:UIControlStateNormal];
    }
    if (cancelBtnTitle.length) {
        [alertView.cancel setTitle:cancelBtnTitle forState:UIControlStateNormal];
    }
    alertView.sureBlock = ^(NSString *content) {
        confirmCallback();
    };
    alertView.cancelBlock = ^{
        cancelCallback();
    };
}

@end
