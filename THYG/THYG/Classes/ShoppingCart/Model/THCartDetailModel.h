//
//  THCartDetailModel.h
//  THYG
//
//  Created by Victory on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THAddressModel;
@class THShippingListModel;
@class THCartGoodListModel;
@class THCartGoodModel;
@class THCouponsModel;

@interface THCartDetailModel : NSObject
@property (nonatomic, strong) THAddressModel * address;
@property (nonatomic, copy) NSArray <THShippingListModel *> * shippingList;
@property (nonatomic, copy) NSArray <THCartGoodListModel *> * cartGoodsList;
@property (nonatomic, copy) NSArray <THCouponsModel *> * userCartCouponList;
// cart_price_info 字典下面的
@property (nonatomic, copy) NSString * totalFee;
@property (nonatomic, copy) NSString * goodsNum;
// member 字典下面的
@property (nonatomic, copy) NSString * payPoints;

@end


@interface THShippingListModel : NSObject

@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * bank_code;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * config;
@property (nonatomic, copy) NSObject * config_value;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSObject * scene;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * version;

@end


@interface THCartGoodListModel : NSObject

@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * bar_code;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_num;
@property (nonatomic, copy) NSString * goods_price;
@property (nonatomic, copy) NSString * goods_sn;
@property (nonatomic, copy) NSString * idField;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * member_goods_price;
@property (nonatomic, copy) NSString * prom_goods;
@property (nonatomic, copy) NSString * prom_id;
@property (nonatomic, copy) NSString * prom_type;
@property (nonatomic, copy) NSString * selected;
@property (nonatomic, copy) NSString * session_id;
@property (nonatomic, copy) NSString * sku;
@property (nonatomic, copy) NSString * spec_key;
@property (nonatomic, copy) NSString * spec_key_name;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, strong) THCartGoodModel * goods;

@end

@interface THCartGoodModel : NSObject

@property (nonatomic, strong) NSString * bond_price;
@property (nonatomic, strong) NSString * bond_status;
@property (nonatomic, strong) NSString * brand_id;
@property (nonatomic, strong) NSString * cat_id;
@property (nonatomic, strong) NSString * click_count;
@property (nonatomic, strong) NSString * comment_count;
@property (nonatomic, strong) NSString * commission;
@property (nonatomic, strong) NSString * cost_price;
@property (nonatomic, strong) NSString * exchange_integral;
@property (nonatomic, strong) NSString * extend_cat_id;
@property (nonatomic, strong) NSString * give_integral;
@property (nonatomic, strong) NSString * goods_id;
@property (nonatomic, strong) NSString * goods_name;
@property (nonatomic, strong) NSString * goods_ratio;
@property (nonatomic, strong) NSString * goodsSn;
@property (nonatomic, strong) NSString * goods_type;
@property (nonatomic, strong) NSString * is_examine;
@property (nonatomic, strong) NSString * is_free_shipping;
@property (nonatomic, strong) NSString * is_hot;
@property (nonatomic, strong) NSString * is_new;
@property (nonatomic, strong) NSString * is_on_sale;
@property (nonatomic, strong) NSString * is_platform_examine;
@property (nonatomic, strong) NSString * is_recommend;
@property (nonatomic, strong) NSString * is_virtual;
@property (nonatomic, strong) NSString * last_update;
@property (nonatomic, strong) NSString * market_price;
@property (nonatomic, strong) NSString * month_sum;
@property (nonatomic, strong) NSString * on_time;
@property (nonatomic, strong) NSString * original_img;
@property (nonatomic, strong) NSString * pay_point_limit;
@property (nonatomic, strong) NSString * price_ladder;
@property (nonatomic, strong) NSString * prom_id;
@property (nonatomic, strong) NSString * prom_type;
@property (nonatomic, strong) NSString * sales_sum;
@property (nonatomic, strong) NSString * shipping_area_ids;
@property (nonatomic, strong) NSString * shop_price;
@property (nonatomic, strong) NSString * sku;
@property (nonatomic, strong) NSString * sort;
@property (nonatomic, strong) NSString * spec_type;
@property (nonatomic, strong) NSString * spu;
@property (nonatomic, strong) NSString * store_count;
@property (nonatomic, strong) NSString * suppliers_id;
@property (nonatomic, strong) NSString * unit;
@property (nonatomic, strong) NSString * virtual_indate;
@property (nonatomic, strong) NSString * virtual_limit;
@property (nonatomic, strong) NSString * virtual_refund;
@property (nonatomic, strong) NSString * weight;

@end
