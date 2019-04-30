//
//  THPay.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPay.h"
#import <AlipaySDK/AlipaySDK.h>

@interface THPay()

@end

@implementation THPay

+ (THPay *)sharePay
{
    static THPay *pay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pay = [[THPay alloc]init];
    });
    return pay;
}

- (void)weChatPay:(NSDictionary *)payReqDic
{
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = payReqDic[@"appid"];
    req.partnerId           = payReqDic[@"partnerid"];
    req.prepayId            = payReqDic[@"prepayid"];
    req.nonceStr            = payReqDic[@"noncestr"];
    req.timeStamp           = (UInt32)[NSDate new].timeIntervalSince1970;
    req.package             = @"Sign=WXPay";
    req.sign                = payReqDic[@"sign"];
    [WXApi sendReq:req];
}

- (void)aliPay:(NSString *)orderString
{
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"THAliPay" callback:^(NSDictionary *resultDic) {
        switch ([resultDic[@"resultStatus"] integerValue]) {
            case 9000:
                if (self.paySuccessByAliPayCallBack) {
                    self.paySuccessByAliPayCallBack();
                }
                break;
            case 8000:
                [THHUD showError:@"正在处理中，支付结果未知"];
                break;
            case 4000:
                [THHUD showError:@"支付失败"];
                break;
            case 5000:
                [THHUD showError:@"重复请求"];
                break;
            case 6001:
                [THHUD showMsg:@"取消支付"];
                break;
            case 6002:
                [THHUD showError:@"网络连接出错"];
                break;
            case 6004:
                [THHUD showError:@"支付结果未知"];
                break;
            default:
                break;
        }
        NSLog(@"reslut = %@",resultDic);
    }];
}

-(void)onResp:(BaseResp*)resp{
    PayResp*response=(PayResp*)resp;
    switch (resp.errCode){
        case WXSuccess:
            self.paySuccessByWeChatCallBack(response);
            break;
        case WXErrCodeUserCancel:
            [THHUD showMsg:@"取消支付"];
            break;
        default:
            [THHUD showError:@"支付失败"];
            break;
    }
}
@end

