//
//  THCouponsModel.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THCouponsModel : NSObject

//@property (nonatomic, copy) NSString *add_time;
//@property (nonatomic, copy) NSString *coupon_type;
//@property (nonatomic, copy) NSString *createnum;
//@property (nonatomic, copy) NSString *merchant_id;
//@property (nonatomic, copy) NSString *remark;
//@property (nonatomic, copy) NSString *send_end_time;
//@property (nonatomic, copy) NSString *send_num;
//@property (nonatomic, copy) NSString *send_start_time;
//@property (nonatomic, copy) NSString *use_num;


@property (nonatomic, copy) NSString *use_start_time;
@property (nonatomic, copy) NSString *is_del;
@property (nonatomic, copy) NSString *use_type;
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *use_end_time;
@property (nonatomic, copy) NSString *send_time;
@property (nonatomic, copy) NSString *use_time;
@property (nonatomic, copy) NSString *use_scope;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger get_order_id;
@property (nonatomic, assign) NSInteger code;

/*

 id = 183;
 use_end_time = 1528888888;
 money = 50.00;
 uid = 1;
 condition = 500.00;
 send_time = 1486699121;
 use_type = 0;
 order_id = 0;
 cid = 7;
 type = 0;
 get_order_id = 0;
 use_time = 0;
 code = ;
 is_del = 0;
 use_start_time = 1464710400;
 use_scope = 全店通用;
 status = 0;
 name = 50代金券;
 */

@end
