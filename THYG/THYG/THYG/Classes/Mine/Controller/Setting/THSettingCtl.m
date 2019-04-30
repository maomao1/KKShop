//
//  THSettingCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSettingCtl.h"
#import "THUserInfoEditCtl.h"
#import "WZXArchiverManager.h"
#import "THHelpCenterCtl.h"
#import "THAddressVC.h"
#import "THModifyPwdVC.h"
#import "THAboutTHCtl.h"
#define filePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface THSettingCtl ()


@property (nonatomic,strong) UIView *footer;

@end

@implementation THSettingCtl

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self = [[UIStoryboard storyboardWithName:@"THSettingCtl" bundle:nil] instantiateInitialViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ROW<2 && ![TOKEN length]) {
        return 0;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (![TOKEN length]) {
        return 0;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (ROW) {
        case 0:
        {
            THUserInfoEditCtl *edit = [[THUserInfoEditCtl alloc] init];
            edit.title = @"个人信息编辑";
            [self.navigationController pushViewController:edit animated:YES];
        }
            break;
        case 1:
        {
            THModifyPwdVC *modifyVc = [[THModifyPwdVC alloc] init];
            [self.navigationController pushViewController:modifyVc animated:YES];
            
        }
            break;
        case 2:
        {
            THAddressVC *addressVc = [[THAddressVC alloc] init];
            [self.navigationController pushViewController:addressVc animated:YES];
        }
            break;
        case 3:
        {
            THAboutTHCtl *aboutVc = [[THAboutTHCtl alloc] init];
            aboutVc.title = @"关于特汇易购";
            [self.navigationController pushViewController:aboutVc animated:YES];
        }
            break;
        case 4:
        {
            [THHUD show:@"清理缓存中..."];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [self cleanCaches:filePath];
                
                // 回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    [THHUD showSuccess:@"清理缓存成功"];
                });
            });
            
        }
            break;
        case 5:
        {
            THHelpCenterCtl *help = [[THHelpCenterCtl alloc] init];
            help.title = @"帮助中心";
            [self.navigationController pushViewController:help animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 清除缓存
- (void)cleanCaches:(NSString *)path {
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
}

#pragma mark -- 退出账户
- (void)loginOutBtn
{
    UserInfo = nil;
    UserDefaultsSetObj(nil, @"token");
    [WZXArchiverManager clear:USER_INFO_KEY];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView*)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] init];
        UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOutBtn.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 40);
        loginOutBtn.backgroundColor = GLOBAL_RED_COLOR;
        loginOutBtn.titleLabel.font = Font(15);
        [loginOutBtn setTitle:@"退出账户" forState:UIControlStateNormal];
        [loginOutBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [loginOutBtn addTarget:self action:@selector(loginOutBtn) forControlEvents:UIControlEventTouchUpInside];
        [_footer addSubview:loginOutBtn];
    }
    return _footer;
}

@end
