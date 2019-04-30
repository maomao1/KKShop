//
//  THOrderConfirmPayButtomView.m
//  THYG
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THOrderConfirmPayButtomView.h"

@implementation THOrderConfirmPayButtomView {
    __weak IBOutlet UILabel *totalPriceLabel;
}

+ (instancetype)payButtomView {
    return [[NSBundle mainBundle] loadNibNamed:STRING(self) owner:self options:nil].lastObject;
}

- (void)setPrice:(NSString *)price {
    _price = price;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款：%@", _price]];
    [string addAttributes:@{NSFontAttributeName: Font12} range:NSMakeRange(0, 4)];
    totalPriceLabel.attributedText = string;
}

#pragma mark - 立即支付
- (IBAction)gotoPayClick {
    !self.payBlock?:self.payBlock();
}


@end
