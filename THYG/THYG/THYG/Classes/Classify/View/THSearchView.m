//
//  THSearchView.m
//  THYG
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSearchView.h"

@interface THSearchView () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation THSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WHITE_COLOR;
        self.layer.cornerRadius = frame.size.height * 0.5;
        self.layer.masksToBounds = YES;
        
        self.textField = ({
            UITextField *field = [[UITextField alloc] init];
            field.placeholder = @"商品关键字";
            field.font = Font13;
            field.textColor = GRAY_151;
            field.delegate = self;
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            field;
        });
        
        self.textField.frame = CGRectMake(WIDTH(16), 0, self.width-WIDTH(16)*2, self.height);
        [self addSubview:self.textField];
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}


@end
