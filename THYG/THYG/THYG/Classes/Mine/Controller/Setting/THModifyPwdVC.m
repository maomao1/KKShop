//
//  THModifyPwdVC.m
//  THYG
//
//  Created by Mac on 2018/5/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THModifyPwdVC.h"

@interface THModifyPwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *originPwd;
@property (weak, nonatomic) IBOutlet UITextField *lastestPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@end

@implementation THModifyPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

#pragma mark - 修改密码
- (IBAction)okClick:(id)sender {
    if (![self checkPwd]) return;
    
    NSDictionary *dict = @{@"token":TOKEN,@"old_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.originPwd.text]], @"new_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.lastestPwd.text]], @"confirm_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.confirmPwd.text]]};
    [THNetworkTool POST:API(@"/User/password") parameters:dict completion:^(id responseObject, NSDictionary *allResponseObject) {
        [THHUD showMsg:responseObject[@"msg"]];
        if ([responseObject[@"status"] integerValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }];
    
}

#pragma mark - 校验密码
- (BOOL)checkPwd {
    BOOL result = YES;
    
    if (!self.originPwd.text.length) {
        [THHUD showMsg:@"原密码不能为空"];
        result = NO;
    }
    
    if (!self.lastestPwd.text.length) {
        [THHUD showMsg:@"新密码不能为空"];
        result = NO;
    } else if (![Utils checkPassword:self.lastestPwd.text]) {
        [THHUD showMsg:@"新密码格式不正确"];
        result = NO;
    }
    
    if (!self.confirmPwd.text.length) {
        [THHUD showMsg:@"确认密码不能为空"];
        result = NO;
    } else if (![self.confirmPwd.text isEqualToString:self.lastestPwd.text]) {
        [THHUD showMsg:@"两次密码输入不一致"];
        result = NO;
    }
    
    return result;
    
}

@end
