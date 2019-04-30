//
//  THClassifyHeaderView.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THClassifyHeaderView.h"

@interface THClassifyHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation THClassifyHeaderView

- (void)setTitle:(NSString *)title {
	_title = title;
	self.titleLabel.text = title;
}

@end
