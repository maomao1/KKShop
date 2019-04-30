//
//  THMineOrderDetailToolView.m
//  THYG
//
//  Created by Mac on 2018/6/9.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THMineOrderDetailToolView.h"
#define kTag 100

@implementation THMineOrderDetailToolView
{
    __weak IBOutlet UIButton *btnOne;
    __weak IBOutlet UIButton *btnTwo;
    __weak IBOutlet UIButton *btnThree;
}

+ (instancetype)toolView {
    return [[NSBundle mainBundle] loadNibNamed:STRING(THMineOrderDetailToolView) owner:self options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    btnOne.layer.borderColor = btnTwo.layer.borderColor = btnThree.layer.borderColor = GRAY_COLOR(221).CGColor;
}

- (IBAction)orderAction:(UIButton *)sender {
    NSInteger tag = sender.tag - kTag;
    NSLog(@"点击操作 %ld", tag);
}

@end
