//
//  THLoginVC.m
//  THYG
//
//  Created by Victory on 2018/3/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THLoginVC.h"
#import "THRegisterCtl.h"
#import "THForgetPswCtl.h"
#import "Utils.h"
#import "ReactiveCocoa.h"
#import "WZXArchiverManager.h"


@interface THLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation THLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isNavTitleWhite];
    self.title = @"会员登录";
    [self initSignal];
}

- (void)initSignal
{
    RACSignal *validPhoneSignal = [self.accountField.rac_textSignal map:^id(NSString *text) {
        return @([Utils CheckPhoneNum:text]);
    }];
    
    RACSignal *validPwdSignal = [self.pswField.rac_textSignal map:^id(NSString *text) {
        return @([Utils checkPassword:text]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validPhoneSignal, validPwdSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    RAC(self.loginBtn, backgroundColor) = [signUpActiveSignal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] ? GLOBAL_RED_COLOR : GRAY_COLOR(230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.loginBtn.enabled = [signupActive boolValue];
    }];
    
}

- (IBAction)loginAction:(id)sender {  
    
    [THNetworkTool POST:API(@"/Login/login")
             parameters:@{@"mobile":self.accountField.text,
                          @"password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]]}
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 
                 if ([responseObject[@"status"] integerValue] == 200) {
                     
                     [THHUD showSuccess:@"登录成功"];
                     if (responseObject[@"info"][@"token"]) {
                         UserDefaultsSetObj(responseObject[@"info"][@"token"], @"token");                         
                     }
                     // 登录成功
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         [self getUserInfo];
                     });
                     
                 } else {
                     [THHUD showMsg:allResponseObject[@"msg"]];
                 }
        
    }];
}

- (void)getUserInfo {
    [THNetworkTool POST:API(@"/User/userinfo")
             parameters:@{@"token":TOKEN}
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 
                 UserInfo = [THUserInfoModel mj_objectWithKeyValues:responseObject[@"info"]];
                 
                 if (!UserInfo) {
                     [WZXArchiverManager clearAll];
                 }else{
                     [UserInfo wzx_archiveToName:USER_INFO_KEY];
                 }
                 
                 [self.navigationController popToRootViewControllerAnimated:YES];
                 
             }];
}

- (IBAction)registerAction:(id)sender {
    
    THRegisterCtl *registerCtl = [[THRegisterCtl alloc] init];
	registerCtl.type = THRegisterCtlTypeRegister;
    [self pushVC:registerCtl];
    
}

- (IBAction)forgetPswAction:(id)sender {
	
	THRegisterCtl *registerCtl = [[THRegisterCtl alloc] init];
	registerCtl.type = THRegisterCtlTypeForgetPwd;
	[self pushVC:registerCtl];
	
}



@end
