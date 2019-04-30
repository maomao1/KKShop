//
//  THShoppingCartModel.h
//  THYG
//
//  Created by Colin on 2018/4/10.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THSuppliersModel : NSObject

@property (nonatomic, copy) NSString *suppliers_id;

@property (nonatomic, copy) NSString *suppliers_name;

@property (nonatomic, assign) CGFloat shipping_price;

@property (nonatomic) BOOL isSelect;

@end

@interface THGoodsInfoModel : NSObject

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *shop_price;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *original_img;

@property (nonatomic, assign) NSInteger store_count;

@end

@interface THCartGoodsModel : NSObject

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *session_id;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_sn;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, assign) CGFloat goods_price;

@property (nonatomic, copy) NSString *member_goods_price;

@property (nonatomic, assign) NSInteger goods_num;

@property (nonatomic, copy) NSString *spec_key;

@property (nonatomic, copy) NSString *spec_key_name;

@property (nonatomic, copy) NSString *bar_code;

@property (nonatomic) BOOL selected;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *prom_type;

@property (nonatomic, copy) NSString *prom_id;

@property (nonatomic, strong) THGoodsInfoModel *goods;

@end

@interface THShoppingCartModel : NSObject

@property (nonatomic, strong) THSuppliersModel *suppliers;

@property (nonatomic, strong) NSArray<THCartGoodsModel* > *cart;

@end


