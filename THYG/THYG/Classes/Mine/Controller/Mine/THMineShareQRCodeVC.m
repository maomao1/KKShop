//
//  THMineShareQRCodeVC.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineShareQRCodeVC.h"
#import "THShareView.h"

@interface THMineShareQRCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation THMineShareQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI
- (void)setupUI {
    self.title = @"推广二维码";
    self.shareButton.layer.borderColor = GLOBAL_RED_COLOR.CGColor;
    self.shareButton.layer.borderWidth = 1;
    [self.shareButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

#pragma mark - share
- (IBAction)shareClick {
    NSLog(@"分享操作");
    
    THShareView *shareView = [[THShareView alloc] initShareViewWithTitle:@[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"微博",@"复制链接"] andImageArry:@[@"weixin",@"pengyouquan",@"QQ",@"QQkongjian",@"xinlangweibo",@"fuzhilianjie"]];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    
    shareView.selectItemBlock = ^(NSInteger index) {
        NSLog(@"fenxiang %ld", index);
    };
    
}


@end
