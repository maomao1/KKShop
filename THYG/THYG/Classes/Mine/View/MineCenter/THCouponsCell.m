//
//  THCouponsCell.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCouponsCell.h"
#import "THCouponsModel.h"
#import "NSString+CHExtension.h"

@implementation THCouponsCell
{
    __weak IBOutlet UILabel *iconLabel;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *typeLabel;
    __weak IBOutlet UILabel *remainingLabel;
    __weak IBOutlet UIButton *actionBtn;
}

- (void)refreshWithModel:(THCouponsModel *)model type:(NSInteger)type
{
    if (type) {

        [actionBtn setTitle:@"立即领取" forState:UIControlStateNormal];
        titleLabel.text = model.name;
        timeLabel.text = [NSString stringWithFormat:@"使用期限%@ - %@",[NSString convertTimestamp:model.use_start_time],[NSString convertTimestamp:model.use_end_time]];
        typeLabel.text = @"全品类通用";
        remainingLabel.text = [NSString stringWithFormat:@"剩%.f天",([model.use_end_time floatValue]-[model.use_start_time floatValue])/(3600*24)];
        
    }else{
        
        [actionBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        titleLabel.text = model.name;
        timeLabel.text = [NSString stringWithFormat:@"使用期限%@ - %@",[NSString convertTimestamp:model.use_start_time],[NSString convertTimestamp:model.use_end_time]];
        typeLabel.text = @"全品类通用";
//        remainingLabel.text = [NSString stringWithFormat:@"剩%.2lf",1-[model.createnum floatValue]?[model.use_num floatValue]/[model.createnum floatValue] : 1];
        
    }
    iconLabel.text = [NSString stringWithFormat:@"￥%@",model.money];
}

- (IBAction)actionBtn:(id)sender {
    
    if (self.btnClickAcion) {
        self.btnClickAcion();
    }
    
}


@end
