//
//  THMineApplymentVC.m
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineApplymentVC.h"
#import "THMineApplymentInputVC.h"
@interface THMineApplymentVC ()
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation THMineApplymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请成为供应商";
    self.okButton.layer.borderWidth = 0.8;
    self.okButton.layer.borderColor = RED_COLOR.CGColor;
}

- (IBAction)okClick:(id)sender {
    THMineApplymentInputVC *inputVc = [[THMineApplymentInputVC alloc] init];
    [self pushVC:inputVc];
}


@end
