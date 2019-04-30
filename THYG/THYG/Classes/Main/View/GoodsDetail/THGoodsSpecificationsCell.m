//
//  THGoodsSpecificationsCell.m
//  THYG
//
//  Created by Mac on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsSpecificationsCell.h"

@interface THGoodsSpecificationsCell ()
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@end

@implementation THGoodsSpecificationsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDefaultSpec:(NSString *)defaultSpec {
    _defaultSpec = defaultSpec;
    self.specLabel.text = [NSString stringWithFormat:@"已选: %@", _defaultSpec];
}

- (IBAction)selectSpecBtnClick:(id)sender {
    
    if (self.selectSpecBtnBlock) {
        self.selectSpecBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
