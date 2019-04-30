//
//  THMyTaskCell.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyTaskCell.h"

@implementation THMyTaskCell
{
    __weak IBOutlet UILabel *taskNameLabel;
    __weak IBOutlet UIButton *optionBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    optionBtn.layer.borderColor = GLOBAL_RED_COLOR.CGColor;
}

- (void)refreshWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        optionBtn.layer.borderWidth = 1;
        optionBtn.enabled = YES;
    }else{
        optionBtn.layer.borderWidth = 0;
        optionBtn.enabled = NO;
    }
}

- (IBAction)optionBtnClick:(id)sender {
    
}


@end
