//
//  NXNetWorkManager.m
//  趣转
//
//  Created by ningxing on 16/5/26.
//  Copyright © 2016年 sharemaster. All rights reserved.
//

#import "NXNetWorkManager.h"
#import <sys/xattr.h>
#import "Helper.h"
#import <CommonCrypto/CommonDigest.h>

//#import "NewLoginOneViewController.h"
#import "YCLoginViewController.h"
#import "AppDelegate.h"

//#define APIHeader @"http://test.renjibo.com/index.php?s=";
#define APIHeader @"https://mp.renjibo.com/App/V2/";

//test
#define newApiHeader @"http://test.renjibo.com/App/V2/";
//http://192.168.0.142/manager/appSystem/index.php/Admin/Index/testIos
//http://test.renjibo.com/App/V2/
/**
 *  test 2
 */
//#define newApiHeader @"http://new.renjibo.com/App/V2/";

//#define newApiHeader @"http://mp.renjibo.com/App/V2/";

NSString *const kApiSecret=@"1CB6008A-0421-D888-FC20-C1D052405664";

@interface NXNetWorkManager ()<UIAlertViewDelegate>

@end

@implementation NXNetWorkManager
//appId = iOS apiKey = 1CB6008A-0421-D888-FC20-C1D052405664

#pragma mark--单例
+(instancetype)shareManager
{
    static NXNetWorkManager *networkManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        networkManager = [[NXNetWorkManager alloc]init];

    });
    
    return networkManager;
}
#pragma mark--get请求
+(void)GET:(NSString *)url params:(NSDictionary *)params
   success:(NXResponseSuccess)success fail:(NXResponseFail)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSLog(@"请求成功%@",responseObject);
         
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
         
         NSLog(@"%@--%@",@"错误信息:",error);  //这里打印错误信息
         
     }];
}
#pragma mark--post请求
//+(void)POST:(NSString *)url params:(NSDictionary *)params
//    success:(NXResponseSuccess)success fail:(NXResponseFail)fail
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
////    NSString *str = @"http://test.renjibo.com/index.php?s=";
//    NSString *str = APIHeader;
//    NSString *str1 = [str stringByAppendingString:url];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
//    [dic setObject:@"ios" forKey:@"fromAppName"];
//    [dic setObject:version forKey:@"version"];
//
//    [manager POST:str1 parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSInteger statusCode  = [[responseObject objectForKey:@"status"] integerValue];
//        
//        NSString *bodyDic = [responseObject objectForKey:@"msg"];
//        
//        NSArray *arr = [responseObject objectForKey:@"data"];
//        
//        
//        success(statusCode,bodyDic,arr,responseObject);
//        NSLog(@"请求成功%@--%ld--%@--data==%@",responseObject,statusCode,bodyDic,arr);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        fail(error.description);
//        
//        NXprogressHUD *hudView = [NXprogressHUD showHUDInView:[UIApplication sharedApplication].keyWindow];
//        hudView.mode = MBProgressHUDModeText;
//        hudView.labelText = @"请检查网络设置";
//        [hudView hide:YES afterDelay:1.0f];
//        NSLog(@"%@--%@",@"错误信息:",error);  //这里打印错误信息
//
//    }];
//}

+(void)POST:(NSString *)url params:(NSDictionary *)params progress:(NXProgress)progress
    success:(NXResponseSuccess)success fail:(NXResponseFail)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *str = APIHeader;

    NSString *str1 = [str stringByAppendingString:url];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    [dic setObject:@"ios" forKey:@"fromAppName"];
    [dic setObject:version forKey:@"version"];

    [manager POST:str1 parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"_____%@",uploadProgress);
        progress(uploadProgress);
//        progress(uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger statusCode  = [[responseObject objectForKey:@"status"] integerValue];
        
        NSString *bodyDic = [responseObject objectForKey:@"msg"];
        
        NSArray *arr = [responseObject objectForKey:@"data"];
        
        success(statusCode,bodyDic,arr,responseObject);
        NSLog(@"请求成功%@--%ld--%@--data==%@",responseObject,statusCode,bodyDic,arr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@--%@",@"错误信息:",error);  //这里打印错误信息
        
    }];
}

#pragma mark--上传文件
+(void)uploadFileWithAPI:(NSString *)url
               paramaters:(NSDictionary *)params
                 isAvatar:(BOOL)isAvatar
                fileDatas:(NSArray *)fileDatas
                filePaths:(NSDictionary *)directoryPathDic
            ProgressBlock:(NXProgress)progressBlock
                  success:(NXResponseSuccess)success
                  failure:(NXResponseFail)failure
{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = newApiHeader;
    NSString *str1 = [str stringByAppendingString:url];
    //获取版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //获取时间
    NSString *date=  [Helper getDate:[NSDate date]];
    
    //创建字典
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    [dic setObject:@(600) forKey:@"expire"];
    [dic setObject:date forKey:@"time"];
    [dic setObject:version forKey:@"version"];
    [dic setObject:@"iOS" forKey:@"appId"];
    
    NSDictionary *newparam = [self Api_MD5Encryption:dic withSecret:kApiSecret];
    

  [manager POST:str1 parameters:newparam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [fileDatas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
//            float kCompressionQuality = 0.8;
            
            NSData *photo = UIImagePNGRepresentation(obj);
            
            
            NSString *imageName = [NSString stringWithFormat:@"upLoadImage%lu.png",(unsigned long)idx];
            
            NSString * name = [NSString stringWithFormat:@"data_stream%lu",(unsigned long)idx];
            
//            if (isAvatar) {
//                
//                name = @"avatar";
//            }
            
            [formData appendPartWithFileData:photo
                                        name:@"wxqrcode"
                                    fileName:imageName
                                    mimeType:@"image/png"];
        }];

//        //上传文件参数
//        UIImage *iamge = [UIImage imageNamed:@"123.png"];
//        NSData *data = UIImagePNGRepresentation(iamge);
//        //这个就是参数
//        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
       
        progressBlock(uploadProgress);

        //打印下上传进度
        NXLog(@"打印下上传进度打印下上传进度%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode  = [[responseObject objectForKey:@"Code"] integerValue];
        
        NSString *msg = [responseObject objectForKey:@"Msg"];
        
        id arr = [responseObject objectForKey:@"Data"];
        
        success(statusCode,msg,arr,responseObject);
        
        NSLog(@"请求成功%@--%ld--%@--data==%@",responseObject,statusCode,msg,arr);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NXLog(@"请求失败：%@",error);
    }];
    
}

#pragma mark--加密请求
+(void)POST:(NSString *)url params:(NSDictionary *)params
    success:(NXResponseSuccess)success fail:(NXResponseFail)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSString *str = newApiHeader;
    
    NSString *str1 = [str stringByAppendingString:url];
    //获取版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //获取时间
    NSString *date=  [Helper getDate:[NSDate date]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10;

    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    //创建字典
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    [dic setObject:@(600) forKey:@"expire"];
    [dic setObject:date forKey:@"time"];
    [dic setObject:version forKey:@"version"];
    [dic setObject:@"iOS" forKey:@"appId"];

    NSDictionary *newparam = [self Api_MD5Encryption:dic withSecret:kApiSecret];
    
    NXLog(@"newparam-----%@",newparam);
    
    [manager POST:str1 parameters:newparam progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NXLog(@"%@",responseObject);
        
        NSInteger statusCode  = [[responseObject objectForKey:@"Code"] integerValue];
        
        NSString *msg = [responseObject objectForKey:@"Msg"];
        
        NSArray *arr = [responseObject objectForKey:@"Data"];
        
        
        
        if ([responseObject[@"Code"] integerValue] == 9) {

            fail(@"");
            
            //退出回到登录页面
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kUserPhoneNumber];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kHaveLogin];
            kSaveUserID(nil);
            kSaveInfoHeaderImageUrl(nil);
            kSaveInfoNickName(nil);
            kSavehaveSetAD(nil);
            kSaveHaveLogin(nil);
            ksaveToken(nil);

            YCLoginViewController *login = [[YCLoginViewController alloc] init];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate.window addSubview:login.view];
            delegate.window.rootViewController = login;
            
            UIAlertView *loginmiss = [[UIAlertView alloc] initWithTitle:@"您的登录状态已失效，请重新登录！" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            
            [loginmiss show];

        }
        else
        {
            success(statusCode,msg,arr,responseObject);
        }

        
        NSLog(@"请求成功%@----%@--data==%@",responseObject,msg,arr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error.description);

        NXprogressHUD *hudView = [NXprogressHUD showHUDInView:[UIApplication sharedApplication].keyWindow];
        hudView.mode = MBProgressHUDModeText;
        hudView.labelText = @"请检查网络设置";
        [hudView hide:YES afterDelay:1.0f];
        NSLog(@"%@--%@",@"错误信息:",error);  //这里打印错误信息
        
    }];
}


#pragma mark--md5
#pragma mak--- 这个就是排序在加密
/**
 *  对请求Api进行加密算法，详见说明文档
 *
 *  @param paraDic 传入将要加密的参数
 *  @param aSecret 应用固定的secret
 *
 *  @return 加密后的参数
 */
+(NSDictionary *)Api_MD5Encryption:(NSMutableDictionary *)paraDic
                           withSecret:(NSString *const)aSecret
{
    
    NXLog(@"%@",paraDic);
    // (1) 将参数'名'进行排序， 例如 limit=100，limit 是‘名’，100 是‘值’
    NSArray *keys = [paraDic allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // (2) 参数的‘值’按参数‘名’的排序，进行拼接
    __block NSString *signStr = nil;
    [sortedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         //debugLog(@" >> paraDic value == %@",[paraDic objectForKey:obj]);
         
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
             return ;
         }
       
         signStr = [signStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",obj,value]];
     }];
    
    // (3) 之后将排序完的字符串signStr拼接secret，然后再md5()
    signStr = [signStr stringByAppendingString:aSecret];
    
    // debugLog(@" >>> sign str append secret ====== \n \n %@ \n\n",signStr);
    
    NXLog(@"%@",signStr);
    
    NSString *MD5_String = [signStr MD5];
    
    // (4) 将生成MD5传入api_sign，生成新的Api参数返回
    
    [paraDic setObject:MD5_String forKey:@"sign"];
    
    NXLog(@"%@",paraDic);
    
    return paraDic;
}

#pragma mark--监听网络状态
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NXLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NXLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NXLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NXLog(@"WiFi网络");
                
                break;
            default:
                break;
        }
        
    }] ;
}

@end
