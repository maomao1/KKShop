//
//  THOrderConfirmListCell.h
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"

@interface THOrderConfirmListCell : THBaseCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

+ (CGFloat)cellHeight;
@end
