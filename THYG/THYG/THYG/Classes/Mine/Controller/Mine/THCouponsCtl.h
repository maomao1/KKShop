//
//  THCouponsCtl.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

@interface THCouponsCtl : THBaseVC

@end

typedef void(^selectTypeBlock)(NSInteger type, NSString *title);

@interface THCouponsTypeSelectView : UIControl

@property (nonatomic,copy) selectTypeBlock selectTypeAction;

- (void)show;

@end
