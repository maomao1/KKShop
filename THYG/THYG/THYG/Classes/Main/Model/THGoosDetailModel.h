//
//  THGoosDetailModel.h
//  THYG
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class THGoodsDetailBannerModel;

@interface THGoosDetailModel : NSObject
@property (nonatomic, copy) NSString *goods_id;     // 商品id
@property (nonatomic, copy) NSString *goods_name;   // 商品名称
@property (nonatomic, copy) NSString *market_price; // 市场价
@property (nonatomic, assign) CGFloat shop_price;   // shop_price
@property (nonatomic, copy) NSString *keywords;     // 商品关键字
@property (nonatomic, copy) NSString *goods_remark; // 商品简单描述
@property (nonatomic, copy) NSString *goods_content;// 商品详细描述
@property (nonatomic, copy) NSString *original_img; // 商品上传原始图
@property (nonatomic, copy) NSString *sales_sum;    // 销量
@property (nonatomic, copy) NSString *click_count;  // 点击数
@property (nonatomic, copy) NSString *is_on_sale;   // 是否上架
@property (nonatomic, copy) NSString *is_virtual;   //
@property (nonatomic, copy) NSString *virtual_indate;//
@property (nonatomic, copy) NSString *prom_id;      // 0 普通订单,1 限时抢购, 2 团购 , 3 促销优惠
@property (nonatomic, copy) NSString *prom_type;    // 优惠活动id
@property (nonatomic, assign) BOOL isCollected; // 是否收藏

@end

@interface THGoodsDetailBannerModel : NSObject
@property (nonatomic, copy) NSString *img_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *image_url;
@end
