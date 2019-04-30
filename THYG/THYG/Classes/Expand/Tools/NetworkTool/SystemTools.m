//
//  SystemTools.m
//  Comment
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 test. All rights reserved.
//

#import "SystemTools.h"
#import <sys/utsname.h>

@implementation SystemTools

+ (NSString *)getDeviceId {
	return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getAppVersion {
	NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
	NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
	return appVersion;
}

+ (NSString *)getDeviceType {
	return @"iOS";
}

+ (NSString *)getDeviceVersion {
	return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getDeviceModel {
	return [[UIDevice currentDevice] model];
}

+ (NSString *)getLanguage {
	NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
	NSString *pfLanguageCode = [NSLocale preferredLanguages][0];
	NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
	//NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]);
	return pfLanguageCode;
}

@end
