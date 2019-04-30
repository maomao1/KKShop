//
//  THMySupplierCell.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMySupplierCell.h"

@implementation THMySupplierCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailBtn.layer.borderWidth = 1;
    self.detailBtn.layer.borderColor = RGB(244, 18, 34).CGColor;
    
}

- (IBAction)detailBtnClick:(id)sender {
    
    
}


@end
