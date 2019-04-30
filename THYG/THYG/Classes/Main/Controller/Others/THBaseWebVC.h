//
//  THBaseWebVC.h
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

@interface THBaseWebVC : THBaseVC

//通过网页内容加载网页
@property (nonatomic, copy) NSString *webContent;

//通过url加载网页
@property (nonatomic, copy) NSString *url;

@property (assign, nonatomic) CGFloat webHeight;

//是否禁用网页手势
@property (nonatomic) BOOL isDisableGestures;

@end
