//
//  THMineSubmitApplicationVC.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineSubmitApplicationVC.h"

@interface THMineSubmitApplicationVC ()
@property (nonatomic, strong) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *iDNumberField;
@property (nonatomic, strong) IBOutlet UITextField *phoneField;
@property (nonatomic, strong) IBOutlet UITextField *weiChatField;
@end

@implementation THMineSubmitApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写申请资料";
    self.submitButton.layer.borderColor = GLOBAL_RED_COLOR.CGColor;
}

- (IBAction)submitClick {
    NSLog(@"确认提交");
    
    // 发送请求
    /*
    [PPNetworkHelper POST:API(@"") parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
     */
}

@end
