//
//  THAddressModel.h
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class THAddressPCDModel;

@interface THAddressModel : NSObject
/** 收货人*/
@property (nonatomic, strong) NSString *consignee;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *full_address;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *address_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *twon;
@property (nonatomic, strong) NSString *province_str;
@property (nonatomic, strong) NSString *city_str;
@property (nonatomic, strong) NSString *district_str;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) BOOL is_default;
@property (nonatomic, assign) BOOL is_pickup;

@property (nonatomic,copy) NSString*title;

@property (nonatomic,copy) NSString*placehold;

/***
 1.textField
 2.文本
 ***/
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString *text;

@end

#pragma mark - 省市区模型
@interface THAddressPCDModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic,assign) NSInteger parent_id;
@property (nonatomic,assign) NSInteger iD;
@property (nonatomic,strong) NSArray <THAddressPCDModel*> *cityList;
@property (nonatomic,strong) NSArray <THAddressPCDModel*> *districtList;
@end
