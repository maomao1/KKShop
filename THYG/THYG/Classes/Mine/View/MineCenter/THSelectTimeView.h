//
//  THSelectTimeView.h
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THSelectTimeViewDelegate <NSObject>

- (void)dismiss;

@end

@interface THSelectTimeView : UIView

@property (nonatomic, copy) void (^selectedTimeBlock)(NSString *year, NSString *month, NSString *day);

@property (nonatomic, weak) id <THSelectTimeViewDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)show;

@end
