//
//  THMineWalletHeaderView.m
//  THYG
//
//  Created by Mac on 2018/4/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineWalletHeaderView.h"
#import "THWalletHeaderModel.h"

@implementation THMineWalletHeaderView {
    __weak IBOutlet UILabel *balanceLabel; // 余额
    __weak IBOutlet UILabel *redBagLabel; // 红包
    __weak IBOutlet UILabel *commissionLabel;// 佣金
    __weak IBOutlet UILabel *coinLabel; // 特币
}


+ (instancetype)walletView {
    return [[NSBundle mainBundle] loadNibNamed:STRING(self) owner:self options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.layer.borderColor = BGColor.CGColor;
            view.layer.borderWidth = 1;
            view.layer.cornerRadius = view.height * 0.5;
            [(UIButton *)view layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
        }
    }
}

- (void)setWalletModel:(THWalletHeaderModel *)walletModel {
    _walletModel = walletModel;
    balanceLabel.text = _walletModel.user_money;
    coinLabel.text = [NSString stringWithFormat:@"%ld", _walletModel.pay_points];
    commissionLabel.text = [NSString stringWithFormat:@"%.2f", [_walletModel.invite_user_money floatValue] + [_walletModel.supplier_money floatValue]];
        redBagLabel.text = @"0.00";
}

- (IBAction)withdrawBtnClick:(UIButton *)sender {
    
    if (self.withdrawBtnAction) {
        self.withdrawBtnAction(sender.tag - 100,@[@"账户余额",@"红包金额",@"推荐佣金"][sender.tag-100]);
    }
}

- (IBAction)detailBtnClick:(UIButton *)sender {
    
    if (self.detailBtnAction) {
        self.detailBtnAction(sender.tag - 200,@[@"账户余额",@"红包金额",@"推荐佣金",@"特币（个）"][sender.tag-200]);
    }
}


@end
