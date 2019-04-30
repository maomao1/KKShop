//
//  THCountDownButton.h
//  THYG
//
//  Created by Victory on 2018/6/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THCountDownButton : UIButton


/**
 构造方法

 @param duration 倒计时时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时按钮
 */
- (instancetype)initWithDuration:(NSInteger)duration
                   buttonClicked:(void(^)(void  ))buttonClicked
                  countDownStart:(void(^)(void))countDownStart
               countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
             countDownCompletion:(void(^)(void))countDownCompletion;

/** 开始倒计时 */
- (void)startCountDown;

/** 结束倒计时*/
- (void)endCountDown;

@end
