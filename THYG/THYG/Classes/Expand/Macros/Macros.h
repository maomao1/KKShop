//
//  Macros.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define UserDefaultsSetObj(obj , key) \
[[NSUserDefaults standardUserDefaults] setObject:(obj) forKey:(key)];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define UserDefaultsObjForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define ObjectForKey(obj, key) [(obj) objectForKey:(key)]

#define Notification [NSNotificationCenter defaultCenter]

#define API(url) [NSString stringWithFormat:@"%@%@",THYGPrefix, url]

#define URL(str) [NSURL URLWithString:str]

#define STRING(x) NSStringFromClass([x class])

#define CLASS(x)  NSClassFromString([NSString stringWithFormat:@"%@",x])


#define kToken [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

#define TOKEN (kToken && [kToken length]) ? kToken : @""

#define UserInfo [THUserBaseInfo sharedUserBaseInfo].userInfoModel

/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define UILABEL_LINE_SPACE 6.0  // UILabel 行间距

#define MinFloat  0.00000000001
#define DEFAULT_TABLEVIEW_HEADER_HEAGHT 10
#define MARGIN 15
#define PageSize @"10"

#define TABLE_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNaviHeight - kTabBarHeight)
#define TABLE_NORMAL_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNaviHeight)

//iPhone X 顶部44pt  底部34pt
#define kTabBarHeight  ((kDevice_Is_iPhoneX) ? (49 + 34) : 49)                   // 定义Tabbar高度
#define kNaviHeight  ((kDevice_Is_iPhoneX) ? 44*2 : 64)                   // 导航栏高度

//iPhone X 底部home区域 34pt
#define kiPhoneX_bottom_height  34

/** 适配问题 以iPhone6s的图适配所有尺寸的比率 */
#define KBWidthRatio  (SCREEN_WIDTH/375)
#define KBHeightRatio (SCREEN_HEIGHT/667)

//适配上
#define WIDTH(W) [UIScreen mainScreen].bounds.size.width / 375 * W
#define HEIGHT(H) [UIScreen mainScreen].bounds.size.height / 667 * H

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

// 灰色
#define GRAY_COLOR(r) RGB(r,r,r)
#define GRAY(r,a) RGBA(r,r,r,a)
#define RED_COLOR   [UIColor redColor]
#define BLACK_COLOR   [UIColor blackColor]
#define WHITE_COLOR [UIColor whiteColor]
#define CLEARCOLOR  [UIColor clearColor]
#define GLOBAL_RED_COLOR RGB(213,0,27)

//线条颜色统一
#define LINECOLOR RGB(229, 229, 229)
//全局背景色
#define BGColor RGB(245,245,245)
#define GRAY_102 GRAY_COLOR(102)
#define GRAY_51 GRAY_COLOR(51)
#define GRAY_151 GRAY_COLOR(151)


#define RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define Font(size) [UIFont systemFontOfSize:size]
#define Font20 [UIFont systemFontOfSize:20]
#define Font18 [UIFont systemFontOfSize:18]
#define Font16 [UIFont systemFontOfSize:16]
#define Font15 [UIFont systemFontOfSize:15]
#define Font14 [UIFont systemFontOfSize:14]
#define Font13 [UIFont systemFontOfSize:13]
#define Font12 [UIFont systemFontOfSize:12]
#define Font11 [UIFont systemFontOfSize:11]
#define Font10 [UIFont systemFontOfSize:10]
#define Font9  [UIFont systemFontOfSize:9]
#define Font8  [UIFont systemFontOfSize:8]

#define IMAGENAMED(image) [UIImage imageNamed:image]


#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

//网络加载指示器
#define THHUD   [THHUDProgress sharedProgressHUD]

/***************** collectionView  ******************/
#define SECTION indexPath.section
#define ITEM    indexPath.item
#define ROW     indexPath.row

#define NIB(name) [UINib nibWithNibName:(name) bundle:nil]

//----------------------系统----------------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define CurrentBuildVersion [NSString stringWithFormat:@"%@",[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断当前是否是iphone
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


#endif /* Macros_h */
