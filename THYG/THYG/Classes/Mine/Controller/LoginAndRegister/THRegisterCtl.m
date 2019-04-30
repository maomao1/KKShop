//
//  THRegisterCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterCtl.h"
#import "THRegisterNextStepCtl.h"
#import "Utils.h"
#import "THAlertView.h"
#import "ReactiveCocoa.h"

@interface THRegisterCtl ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (weak, nonatomic) IBOutlet UILabel *contactServicerLabel;
@end

@implementation THRegisterCtl

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.type ? @"忘记密码" : @"会员注册";
	self.contactServicerLabel.hidden = self.type;
    [self isNavTitleWhite];
    [self initSignal];
}

- (void)initSignal
{
    RACSignal *validPhoneSignal = [self.phoneNumField.rac_textSignal map:^id(NSString *text) {
        return @([Utils CheckPhoneNum:text]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validPhoneSignal] reduce:^id(NSNumber*usernameValid){
        return @([usernameValid boolValue]);
    }];
    
    RAC(self.nextStepBtn, backgroundColor) = [signUpActiveSignal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] ? GLOBAL_RED_COLOR : GRAY_COLOR(230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.nextStepBtn.enabled = [signupActive boolValue];
    }];
}


- (IBAction)nextBtnAction:(id)sender {
	
	[self.view endEditing:YES];
	
	[THAlertView alertViewWithTitle:nil content:[NSString stringWithFormat:@"我们将发送短信验证码至:\n\n%@",self.phoneNumField.text] confirmBtnTitle:@"确定" cancelBtnTitle:@"取消" confirmCallback:^{
        
//        //先写死
//        THRegisterNextStepCtl *nextStepCtl = [[THRegisterNextStepCtl alloc] init];
//        nextStepCtl.phoneString = self.phoneNumField.text;
//        [self pushVC:nextStepCtl];
//        return;
		
		[THNetworkTool POST:API(@"/User/send_validate_code") parameters:@{@"scene":self.type?@"2":@"1", @"mobile":self.phoneNumField.text} completion:^(id responseObject, NSDictionary *allResponseObject) {
            
            if ([responseObject[@"status"] integerValue] == 200) {
                [THHUD showSuccess:@"短信验证码发送成功"];
                THRegisterNextStepCtl *nextStepCtl = [[THRegisterNextStepCtl alloc] init];
                nextStepCtl.phoneString = self.phoneNumField.text;
				nextStepCtl.isForgetPwd = self.type;
				nextStepCtl.uniqueId = responseObject[@"info"][@"unique_id"];
                [self pushVC:nextStepCtl];
                
            } else {
                NSLog(@"失败信息%@", responseObject[@"msg"]);
            }
            
            
        }];
        
    } cancelCallback:^{
        
    }];
    
}

@end
