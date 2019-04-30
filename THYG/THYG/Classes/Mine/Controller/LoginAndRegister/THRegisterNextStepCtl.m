//
//  THRegisterNextStepCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterNextStepCtl.h"
#import "ReactiveCocoa.h"
#import "UIButton+CHExtension.h"
#import "WZXArchiverManager.h"
#import <RTRootNavigationController/RTRootNavigationController.h>


@interface THRegisterNextStepCtl ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumOfRevCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation THRegisterNextStepCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员注册";
    [self isNavTitleWhite];
    [self setTextFieldLeftPadding:self.verifyCodeField forWidth:10];
    [self setTextFieldLeftPadding:self.pswField forWidth:10];
    self.phoneNumOfRevCodeLabel.text = [NSString stringWithFormat:@"请输入%@收到的验证码",self.phoneString];
    [self getVerifyCodeAction:self.getVerifyCodeBtn];
    [self initSignal];

}

- (void)initSignal
{
    RACSignal *validVerifyCodeSignal = [self.verifyCodeField.rac_textSignal map:^id(NSString *text) {
        return @(self.verifyCodeField.text.length);
    }];
    
    RACSignal *validPwdSignal = [self.pswField.rac_textSignal map:^id(NSString *text) {
        return @([Utils checkPassword:text]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validVerifyCodeSignal, validPwdSignal] reduce:^id(NSNumber*verifyCodeValid, NSNumber *passwordValid){
        return @([verifyCodeValid boolValue] && [passwordValid boolValue]);
    }];
    
    RAC(self.finishBtn, backgroundColor) = [signUpActiveSignal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] ? GLOBAL_RED_COLOR : GRAY_COLOR(230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.finishBtn.enabled = [signupActive boolValue];
    }];
}

- (IBAction)getVerifyCodeAction:(id)sender {
    
    self.getVerifyCodeBtn.backgroundColor = GRAY_COLOR(230);
    [self.getVerifyCodeBtn startTime:60 title:@"获取验证码" waitTittle:@"s" endTimeFinish:^{
        self.getVerifyCodeBtn.backgroundColor = GLOBAL_RED_COLOR;
    }];
    
}

- (IBAction)finishAction:(id)sender {
	
	NSString *url = self.isForgetPwd ? @"/User/set_pwd" : @"/Login/register";
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

	if (self.isForgetPwd) {
		params[@"code"] = self.verifyCodeField.text;
	} else {
		params[@"mobile_code"] = self.verifyCodeField.text;
	}
	params[@"unique_id"] = self.uniqueId;
	params[@"mobile"] = self.phoneString;
	params[@"password"] = [Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]];
	params[@"confirm_password"] = [Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]];
	
	[THNetworkTool POST:API(url)
			 parameters:params
             completion:^(id responseObject, NSDictionary *allResponseObject) {

				 if ([responseObject[@"status"] integerValue] == 200) {
					 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
						 [THHUD showSuccess:self.isForgetPwd?@"密码设置成功,请重新登录":@"注册成功"];
					 });
					 
					 if (!self.isForgetPwd) {
						 UserDefaultsSetObj(responseObject[@"info"][@"token"], @"token");
						 [self getUserInfo];
						 
					 } else {
                         [self.navigationController popToViewController:self.rt_navigationController.childViewControllers[1] animated:YES];
//                         NSLog(@"rt_navigationController%@", self.rt_navigationController.childViewControllers);
                         
					 }
					 
				 } else {
					 [THHUD showSuccess:responseObject[@"msg"]];
				 }


             }];
	
}

- (void)getUserInfo
{
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

- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

@end
