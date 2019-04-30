//
//  THCommentCateViewCell.m
//  THYG
//
//  Created by 廖辉 on 2018/6/12.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentCateViewCell.h"

@implementation THCommentCateViewCell
{
    __weak IBOutlet UIButton *selectBtn;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    selectBtn.layer.borderColor = [UIColor redColor].CGColor;
    selectBtn.layer.borderWidth = 1;
}

- (void)setIsSelct:(BOOL)isSelct
{
    _isSelct = isSelct;
    if (_isSelct) {
        selectBtn.layer.borderColor = [UIColor redColor].CGColor;
        selectBtn.layer.borderWidth = 1;
    }else{
        selectBtn.layer.borderColor =GRAY_COLOR(240).CGColor;
        selectBtn.layer.borderWidth = 1;
    }
}

- (IBAction)selectBtnclick:(id)sender {
    
    
}

@end
