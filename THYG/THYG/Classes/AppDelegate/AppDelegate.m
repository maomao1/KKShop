//
//  AppDelegate.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 Victory. All rights reserved.
//

#import "AppDelegate.h"
#import "THTabBarController.h"
#import "THGuideViewTool.h"
#import "WZXArchiverManager.h"
#import "THPay.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import <Bugly/Bugly.h>
#import "THShareTool.h"

@interface AppDelegate ()

@end

static NSString *const kApiSecret = @"3176b5f31b3e4c693b25635b8b3b69fe";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *rootVc = [THGuideViewTool chooseRootViewController];
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    
    //读取本地用户数据
    UserInfo = [THUserInfoModel wzx_unArchiveToName:USER_INFO_KEY];
    
    [WXApi registerApp:@"wx1792977a45662b26"];
    
    [Bugly startWithAppId:@"3739643c93"];
	
	[THShareTool openLog:YES];
	[THShareTool initUmSocialShare];
	
	return YES;
    
}

#pragma mark -- 测试接口
#pragma mark - 登录(成功) Login/login
    /*
      +    [THNetworkTool POST:API(@"/Login/login") parameters:@{@"mobile":@"15622745823", @"password":@"123456"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

    /*
      +    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
      +    dict[@"mobile"] = @"15622745823";
      +    dict[@"password"] = @"123456";
      +    dict[@"confirm_password"] = @"123456";
      +    dict[@"mobile_code"] = @"123456";
      +     */

#pragma mark - 注册(成功) Login/register
    /*
    [THNetworkTool POST:API(@"/Login/register") parameters:dict completion:^(id responseObject, NSDictionary *allResponseObject) {
        NSLog(@"responseObject %@", responseObject);
    }];
    */
    
#pragma mark - 获取用户信息(成功) User/userinfo
    /*
      +    [THNetworkTool POST:API(@"/User/userinfo") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */


#warning - 更新用户信息 User/updateUserInfo
#warning - 参数不完整
    /*
      +    [THNetworkTool POST:API(@"/User/updateUserInfo") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

#warning - 申请成为供应商 参数有误
    /*
      +    [THNetworkTool POST:API(@"/User/applySupplier") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

#warning 申请成为推广专员
#pragma mark - 申请成为推广专员 （error 500）
    /*
      +    [THNetworkTool POST:API(@"/User/applyPromotionSpecialist") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8", @"wechat":@"特惠易购"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */
#warning 收藏夹列表
#pragma mark - 收藏夹列表 （返回Null，有问题）
    /*
      +    [THNetworkTool POST:API(@"/User/collectList") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +    */

#pragma mark - 用户足迹 （提示请求成功，没有其他数据）
    /*
      +    [THNetworkTool POST:API(@"/User/getVisit") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +    */

#pragma mark - 卡券列表 （测试成功，有数据）
   /*
      +    [THNetworkTool POST:API(@"/User/couponList") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

#pragma mark - 我的钱包 （请求成功，没有数据）
    /*
      +     [THNetworkTool POST:API(@"/User/wallet") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +     NSLog(@"responseObject %@", responseObject);
      +     }];
      +     */

    #pragma mark - 银行卡列表 （请求成功，未添加时候，没有数据）
    /*
      +    [THNetworkTool POST:API(@"/User/bankCardList") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

    #pragma mark - 添加银行卡 （添加成功）
    /*
      +    [THNetworkTool POST:API(@"/User/addBankCard") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8", @"bank_name":@"广大银行", @"bank_card":@"6217002050002939980",@"realname":@"杨光"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

    #pragma mark - 收藏商品 （添加成功）
    /*
      +    [THNetworkTool POST:API(@"/Goods/collectionGoods") parameters:@{@"token":@"6becd5d27a733040b0c95182a224a6c8", @"goods_id":@"01"} completion:^(id responseObject, NSDictionary *allResponseObject) {
      +        NSLog(@"responseObject %@", responseObject);
      +    }];
      +     */

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //微信支付回调
    if ([url.host isEqual:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[THPay sharePay]];
    }
    //支付宝支付
    else if ([url.host isEqualToString:@"safepay"]){
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
