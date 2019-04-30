//
//  THCartSectionHead.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCartSectionHead.h"
#import "THShoppingCartModel.h"

@implementation THCartSectionHead
{
    __weak IBOutlet UIButton *selectBtn;
    __weak IBOutlet UILabel *sectionTitleLabel;
    __weak IBOutlet UILabel *postageLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:STRING(THCartSectionHead) owner:self options:nil] firstObject];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    }
    return self;
}

- (void)setModelData:(THSuppliersModel *)modelData
{
    _modelData = modelData;
    sectionTitleLabel.text = _modelData.suppliers_name;
    postageLabel.text = [NSString stringWithFormat:@"运费：￥%.2lf",_modelData.shipping_price];
    selectBtn.selected = _modelData.isSelect;
}

- (IBAction)selectBtnClick:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    if (self.selectBtnClick) {
        self.selectBtnClick();
    }
    
}

@end
