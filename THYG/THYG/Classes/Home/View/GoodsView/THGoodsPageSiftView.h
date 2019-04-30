//
//  THGoodsPageSiftView.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THGoodsPageSiftView : UIView

@property (nonatomic, copy) void(^siftClickBlock)(NSInteger idx);

///*****销量是否是升序*****/
//@property (nonatomic) BOOL isAscOfSalesCount;

/*****价格是否是升序*****/
@property (nonatomic) BOOL isAscOfPrice;


@end
