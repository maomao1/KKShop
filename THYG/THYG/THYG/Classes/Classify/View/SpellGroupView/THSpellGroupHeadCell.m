//
//  THSpellGroupHeadCell.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHeadCell.h"

@implementation THSpellGroupHeadCell
{
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *statusLabel;
    
}

- (void)refreshWithDic:(NSDictionary *)dic
{
    timeLabel.text = dic[@"time"];
    statusLabel.text = dic[@"status"];
    
    if (![dic[@"is_ing"] integerValue]) {
        self.backgroundColor = GRAY_COLOR(200);
        timeLabel.textColor = GRAY_COLOR(81);
        statusLabel.textColor = GRAY_COLOR(81);
        timeLabel.font = Font(14);
        statusLabel.font = Font(13);
    }else{
        self.backgroundColor = GLOBAL_RED_COLOR;
        timeLabel.textColor = GRAY_COLOR(255);
        statusLabel.textColor = GRAY_COLOR(255);
        timeLabel.font = Font(16);
        statusLabel.font = Font(15);
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
