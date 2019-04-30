//
//  THAlertView.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^confirmClickBlock)();
typedef void (^cancelClickBlock)();
@interface THAlertView : NSObject

+ (void)alertViewWithTitle:(NSString *)title
                   content:(NSString *)content
           confirmBtnTitle:(NSString*)confirmBtnTitle
            cancelBtnTitle:(NSString*)cancelBtnTitle
           confirmCallback:(confirmClickBlock)confirmCallback
            cancelCallback:(cancelClickBlock)cancelCallback;

@end
