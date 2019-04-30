//
//  THSelectAddressView.h
//  THYG
//
//  Created by Mac on 2018/5/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THAddressPCDModel;

typedef void(^getSelectData)(THAddressPCDModel *provinceModel, THAddressPCDModel *cityModel, THAddressPCDModel *districtModel);

@interface THSelectAddressView : UIView

/*****id参数为空：新建操作; id传相应的参数：修改操作*****/
- (void)initDataWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId;

/*****展示选择地区视图*****/
- (void)show:(getSelectData)getSelectModel;

@end
