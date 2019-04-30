//
//  THGoodsModel.h
//  THYG
//
//  Created by Colin on 2018/4/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THGoodsModel : NSObject

/***** 分类id *****/
@property (nonatomic, copy) NSString *cat_id;

/***** 商品id *****/
@property (nonatomic, copy) NSString *goods_id;

/***** 商品名称 *****/
@property (nonatomic, copy) NSString *goods_name;

/***** 商品上传原始图 *****/
@property (nonatomic, copy) NSString *original_img;

/***** 商品评论数 *****/
@property (nonatomic, copy) NSString *comment_count;

/***** 本店价 *****/
@property (nonatomic, copy) NSString *shop_price;

/***** 好评率 *****/
@property (nonatomic, copy) NSString *goods_ratio;

@end
