//
//  THScreeningGoodsCtl.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

@interface THScreeningGoodsCtl : THBaseVC

@property (nonatomic, copy) NSString * searchText; // 搜索关键字
@property (nonatomic, copy) NSString * gcId; // 商品Id

/***** 商品分类id  （选传） *****/
@property (nonatomic, copy) NSString *cat_id;

//默认不显示
@property (nonatomic) BOOL isShowSearchBar;

@end
