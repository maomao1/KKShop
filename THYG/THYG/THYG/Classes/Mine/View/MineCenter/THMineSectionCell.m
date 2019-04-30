
//
//  THMineSectionCell.m
//  THYG
//
//  Created by Victory on 2018/3/16.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineSectionCell.h"

@interface THMineSectionCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation THMineSectionCell

- (void)setDataDict:(NSDictionary *)dataDict {
	_dataDict = dataDict;
	if ([dataDict[@"image"] length]) {
		self.iconImageView.hidden = NO;
		self.iconImageView.image = IMAGENAMED(dataDict[@"image"]);
		self.leftConstraint.constant = 41;
	} else {
		self.iconImageView.hidden = YES;
		self.leftConstraint.constant = 15;
	}
	
	self.nameLabel.text = dataDict[@"title"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
