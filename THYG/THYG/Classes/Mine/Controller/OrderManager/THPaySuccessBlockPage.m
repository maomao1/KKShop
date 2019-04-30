//
//  THPaySuccessBlockPage.m
//  THYG
//
//  Created by 廖辉 on 2018/6/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPaySuccessBlockPage.h"

@interface THPaySuccessBlockPage ()

@end

@implementation THPaySuccessBlockPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付成功";
}

- (IBAction)gotoHomePage:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
