//
//  THPay.h
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
@class PayReq;
@class PayResp;
@interface THPay : NSObject<WXApiDelegate>

+ (THPay *)sharePay;

//微信支付
- (void)weChatPay:(NSDictionary *)payReqDic;

//支付宝支付
- (void)aliPay:(NSString *)orderString;

//微信支付成功的回调
@property (nonatomic,copy) void(^paySuccessByWeChatCallBack)(PayResp *response);

//支付宝支付成功的回调
@property (nonatomic,copy) void(^paySuccessByAliPayCallBack)(void);

@end
