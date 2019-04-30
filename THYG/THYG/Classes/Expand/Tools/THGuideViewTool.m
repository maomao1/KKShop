//
//  THGuideViewTool.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGuideViewTool.h"
#import "THNewFeatureVC.h"
#import "THTabBarController.h"

@implementation THGuideViewTool

+ (UIViewController *)chooseRootViewController {
	// 获取用户最新的版本号，info.plist
	NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *lastVersion = [defaults objectForKey:versionKey];
	NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
	//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	
	
	if ([currentVersion isEqualToString:lastVersion]) { // 广告页面
		THTabBarController *tabbarVc = [[THTabBarController alloc] init];
		//        window.rootViewController = tabbarVc;
		return tabbarVc;
		
	} else { // 新特性页面
		//        window.rootViewController = [[KBNewFeatureVC alloc] init];
		return [[THNewFeatureVC alloc] init];
	}
}

@end
