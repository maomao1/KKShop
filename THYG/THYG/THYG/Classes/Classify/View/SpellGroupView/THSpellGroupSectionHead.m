//
//  THSpellGroupSectionHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupSectionHead.h"

@interface THSpellGroupSectionHead()
@property (nonatomic, strong) UILabel * sectionTitleLabel;
@end

@implementation THSpellGroupSectionHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = GRAY_COLOR(180);
        [self addSubview:self.sectionTitleLabel];
        
        [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.offset(0);
            make.centerY.offset(0);
            
        }];
        
    }
    return self;
}


- (void)setSectionTitle:(NSString *)sectionTitle
{
    _sectionTitle = sectionTitle;
    self.sectionTitleLabel.text = _sectionTitle;
}

- (UILabel *)sectionTitleLabel
{
    if (!_sectionTitleLabel) {
        _sectionTitleLabel = [[UILabel alloc] init];
        _sectionTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sectionTitleLabel.font = Font(16);
    }
    return _sectionTitleLabel;
}

@end
