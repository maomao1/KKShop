//
//  THOrderModel.h
//  THYG
//
//  Created by Victory on 2018/6/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class THOrderGoodsListModel;
@class THOrderListModel;

@interface THOrderModel : NSObject
@property (nonatomic, strong) THOrderListModel *order_info;
@property (nonatomic, copy) NSArray *express;
@end


@interface THOrderListModel : NSObject

@property (nonatomic, copy) NSString *iD;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_str;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *shipping_status;
@property (nonatomic, copy) NSString *pay_status;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *twon;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *shipping_code;
@property (nonatomic, copy) NSString *shipping_name;
@property (nonatomic, copy) NSString *pay_code;
@property (nonatomic, copy) NSString *pay_name;
@property (nonatomic, copy) NSString *invoice_title;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *shipping_price;
@property (nonatomic, copy) NSString *user_money;
@property (nonatomic, copy) NSString *coupon_price;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *integral_money;
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) NSString *order_discount_price;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *shipping_time;
@property (nonatomic, copy) NSString *confirm_time;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *transaction_id;
@property (nonatomic, copy) NSString *order_prom_type;
@property (nonatomic, copy) NSString *order_prom_id;
@property (nonatomic, copy) NSString *order_prom_amount;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *user_note;
@property (nonatomic, copy) NSString *admin_note;
@property (nonatomic, copy) NSString *parent_sn;
@property (nonatomic, copy) NSString *is_distribut;
@property (nonatomic, copy) NSString *paid_money;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *suppliers_id;
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *distribut_time;
@property (nonatomic, copy) NSString *invoice_type;
@property (nonatomic, copy) NSString *user_delete;
@property (nonatomic, copy) NSString *order_status_code;
@property (nonatomic, copy) NSString *order_status_desc;
@property (nonatomic, copy) NSString *count_goods_num;
@property (nonatomic, copy) NSString * complete_address;
@property (nonatomic, copy) NSArray <THOrderGoodsListModel *> *goods_list;


/**
 返回订单类型
 @param code order_status_code
 @return 订单类型 --- 待支付:0, 待发货:1, 待收货:2, 待评价:3, 交易成功:4.
 */
+ (NSInteger)orderTypeWithCode:(NSString *)code;

@end

@interface THOrderGoodsListModel : NSObject

@property (nonatomic, copy) NSString *rec_id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_sn;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *cost_price;
@property (nonatomic, copy) NSString *member_goods_price;
@property (nonatomic, copy) NSString *give_integral;
@property (nonatomic, copy) NSString *spec_key;
@property (nonatomic, copy) NSString *spec_key_name;
@property (nonatomic, copy) NSString *bar_code;
@property (nonatomic, copy) NSString *is_comment;
@property (nonatomic, copy) NSString *prom_type;
@property (nonatomic, copy) NSString *prom_id;
@property (nonatomic, copy) NSString *is_send;
@property (nonatomic, copy) NSString *delivery_id;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *act_type;
@property (nonatomic, copy) NSString *act_id;
@property (nonatomic, copy) NSString *commission;

@end
