//
//  THAlertViewModel.h
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THAlertViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cancelBtnTitle;
@property (nonatomic, copy) NSString *confirmBtnTitle;
@property (nonatomic, copy) NSString *placehold;
@property (nonatomic) UIKeyboardType keyboradType;
@property (nonatomic) NSInteger textFieldLength;
@property (nonatomic, strong) UIImage *textFieldRightImage;

@end
