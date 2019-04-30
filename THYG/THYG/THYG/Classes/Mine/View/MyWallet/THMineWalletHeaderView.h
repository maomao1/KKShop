//
//  THMineWalletHeaderView.h
//  THYG
//
//  Created by Mac on 2018/4/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THWalletHeaderModel;

@interface THMineWalletHeaderView : UIView

+ (instancetype)walletView;

@property (nonatomic, copy) void(^withdrawBtnAction)(NSInteger tag, NSString *title);

@property (nonatomic, copy) void(^detailBtnAction)(NSInteger tag, NSString *title);

@property (nonatomic, strong) THWalletHeaderModel *walletModel;

@end
