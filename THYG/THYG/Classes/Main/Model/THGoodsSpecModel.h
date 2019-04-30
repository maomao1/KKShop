//
//  THGoodsSpecModel.h
//  THYG
//
//  Created by Mac on 2018/4/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class THSpecDefaultModel;
@class THFilterSpecModel;
@class THItemSpecModel;

@interface THGoodsSpecModel : NSObject
@property (nonatomic, strong) THSpecDefaultModel *defaultSpec;
@property (nonatomic, copy) NSArray <THFilterSpecModel *>*filter_spec;
@property (nonatomic, copy) NSArray <THSpecDefaultModel *>*spec_goods_price;
@end


/** 商品默认规格*/
@interface THSpecDefaultModel : NSObject
@property (nonatomic, copy) NSString *store_count;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) NSInteger item_id;
@property (nonatomic, copy) NSString *default_str;
@property (nonatomic, copy) NSString *price;

@end

/** 某一属性*/
@interface THFilterSpecModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray <THItemSpecModel *>*spec; // 规格
@end

/** item model*/
@interface THItemSpecModel : NSObject

@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *spec_item_id;

@end






