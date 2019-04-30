//
//  THSelectedCategoryView.h
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSelectedCategoryView : UIView

@property (nonatomic, copy) void (^selectedItemBlock)(NSString *category);

@property (nonatomic, strong) NSArray *dataArray;

+ (instancetype)sharedInstance;

- (void)show;

@end
