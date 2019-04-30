//
//  THOrderConfirmPayButtomView.h
//  THYG
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THOrderConfirmPayButtomView : UIView

@property (nonatomic, copy) NSString *price;

+ (instancetype)payButtomView;

/** 立即支付*/
@property (nonatomic, copy) void (^payBlock)(void);

@end
