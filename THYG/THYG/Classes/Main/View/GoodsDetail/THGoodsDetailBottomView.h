//
//  THGoodsDetailBottomView.h
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THGoodsDetailBottomView : UIView
@property (nonatomic, copy) void (^buttomButtonBlock)(NSInteger tag);
@end
