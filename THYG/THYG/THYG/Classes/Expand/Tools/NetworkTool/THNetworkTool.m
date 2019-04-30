//
//  THNetworkTool.m
//  THYG
//
//  Created by Victory on 2018/3/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THNetworkTool.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "THLoginVC.h"

static NSString *const kApiSecret = @"3176b5f31b3e4c693b25635b8b3b69fe";

@implementation THNetworkTool

+ (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void(^)(id responseObject, NSDictionary *allResponseObject))completion {
	
    
    if (!UserDefaultsObjForKey(@"deviceSession")) {

        [PPNetworkHelper GET:API(kGetDeviceSession) parameters:nil success:^(id responseObject) {
            
            if ([responseObject[@"status"] integerValue] == 200) {

                NSString *token = responseObject[@"info"][@"deviceSession"];
                
                if (token.length) {
                
                    UserDefaultsSetObj(token, @"deviceSession");
                    
                    [self sendRequestWith:urlString parameters:parameters completion:completion];
                
                }
            }
            
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
            [THHUD showError:@"加载失败，刷新一下试试~"];
        }];
        
    } else {
        
        [self sendRequestWith:urlString parameters:parameters completion:completion];
        
    }

    
	
}

#pragma mark - 发送请求
+ (void)sendRequestWith:(NSString *)urlString parameters:(id)parameters completion:(void(^)(id responseObject, NSDictionary *allResponseObject))completion {
	
	if (@available(iOS 8, *)) {
		urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	} else {
		// iOS 8 以后要用这个方法：
		urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
	}
	
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"deviceSession"] = UserDefaultsObjForKey(@"deviceSession");
    dict[@"appVersion"] = [SystemTools getAppVersion];
    dict[@"deviceId"] = [SystemTools getDeviceId];
    dict[@"deviceModel"] = [SystemTools getDeviceModel];
    dict[@"deviceType"] = [SystemTools getDeviceType];
    dict[@"deviceVersion"] = [SystemTools getDeviceVersion];
    dict[@"language"] = [SystemTools getLanguage];
    [dict addEntriesFromDictionary:parameters];
    
    NSDictionary *params = [self apiMD5Encryption:dict withSecret:kApiSecret];
    //NSLog(@"token %@", dict[@"token"]);
    
    if ([params.allKeys containsObject:@"token"]) {
        if (!params[@"token"]) {
            if ([params[@"token"] length] < 1) {
                [THHUD showMsg:@"您还未登录，请登录"];
                [self reLogin];
            }
        }
    }
    
    [PPNetworkHelper POST:urlString parameters:params success:^(id responseObject) {
        
        NSLog(@"请求的数据: %@\n %@", urlString, params);
        NSLog(@"返回的数据：%@",responseObject);
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        if (status == 200 || status == 1) {
            completion(responseObject,nil);
            
        } else if (status == 9001) { // 请重新登录
            [THHUD showMsg:@"请重新登录"];
            [self reLogin];
            
        } else {
            //返回所有的数据，用于单独的判断处理
            completion(nil,responseObject);
            NSLog(@"%@",responseObject[@"msg"]);
        }
        
        
    } failure:^(NSError *error) {
        if ([PPNetworkHelper isNetwork]) {
            NSLog(@"服务器异常，请稍后重试 %@",error);
        }else{
            NSLog(@"请检查网络连接");
        }
    }];
}


#pragma mark - 重新登录
+ (void)reLogin {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIViewController *curController = ((RTContainerController*)[self getCurrentVC]).contentViewController;
        if (![curController isKindOfClass:[THLoginVC class]]) {
            THLoginVC *login = [[THLoginVC alloc]init];
            [curController.navigationController pushViewController:login animated:YES];
        }
        
    });
}

#pragma mak--- 排序 + 加密
/**
 *  对请求Api进行加密算法
 *  a、将参数数组M按照key值大小升序排列（sign参数不参与签名）。
 *  b、将排列好的M使用键值对的格式（即key1=value1&key2=value2…）拼接成字符串stringA。
 *  c、在stringA最后拼接上key（生成签名时与后台预定的签名key值）得到stringSignTemp字符串，并对stringSignTemp进行MD5运算，再将得到的字符串所有字符转换为小写，得到sign值signValue。
 *  @param paraDic 传入将要加密的参数
 *  @param aSecret 应用固定的secret
 *
 *  @return 加密后的参数
 */
+ (NSDictionary *)apiMD5Encryption:(NSMutableDictionary *)paraDic withSecret:(NSString *const)aSecret {
	// (1) 将参数'名'进行排序， 例如 limit=100，limit 是‘名’，100 是‘值’
	NSArray *keys = [paraDic allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1 compare:obj2 options:NSNumericSearch];
	}];
	// (2) 参数的‘值’按参数‘名’的排序，进行拼接
	__block NSString *signStr = nil;
	[sortedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		id value = [paraDic objectForKey:obj];
		
		if (![value isKindOfClass:[NSString class]] && ![value isKindOfClass:[NSArray class]]) {
			value = [value stringValue];
		}
		
		if ([value isKindOfClass:[NSArray class]]) {
			for (NSString * str in value) {
				[signStr stringByAppendingString:str];
			}
			return;
		}
		
		if (!signStr){
			signStr = [NSString stringWithFormat:@"%@=%@&",obj,value];
			return;
		}
		signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",obj,value]];
	}];
	
	// (3) 之后将排序完的字符串signStr拼接secret，然后再md5()
	signStr = [signStr substringToIndex:signStr.length-1];
	signStr = [signStr stringByAppendingString:aSecret];
	NSString *md5 = [Utils md5:signStr];
	// (4) 将生成MD5传入api_sign，生成新的Api参数返回
	[paraDic setObject:md5 forKey:@"sign"];
//    NSLog(@"%@",paraDic);
	return paraDic;
}

+ (UIViewController*)getCurrentVC
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (vc.presentedViewController) {
        if ([vc.presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navVc = (UINavigationController *)vc.presentedViewController;
            vc = navVc.visibleViewController;
        }
        else if ([vc.presentedViewController isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabVc = (UITabBarController *)vc.presentedViewController;
            if ([tabVc.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navVc = (UINavigationController *)tabVc.selectedViewController;
                return navVc.visibleViewController;
            }
            else{
                return tabVc.selectedViewController;
            }
        }
        else{
            vc = vc.presentedViewController;
        }
    }
    else{
        if ([vc isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVc = (UITabBarController *)vc;
            if ([tabVc.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navVc = (UINavigationController *)tabVc.selectedViewController;
                return navVc.visibleViewController;
            }
            else{
                return tabVc.selectedViewController;
            }
        }
        else if([vc isKindOfClass:[UINavigationController class]]){
            UINavigationController *navVc = (UINavigationController *)vc;
            vc = navVc.visibleViewController;
        }
    }
    return vc;
}

@end
