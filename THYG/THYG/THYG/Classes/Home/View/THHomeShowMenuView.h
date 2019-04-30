//
//  THHomeShowMenuView.h
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THHomeShowMenuView : UIControl

/** 数据源 */
@property (nonatomic,strong) NSArray *data;
/** 选择事件*/
@property (nonatomic, copy) void (^selectedAction)(NSInteger index);

- (void)show;

@end
