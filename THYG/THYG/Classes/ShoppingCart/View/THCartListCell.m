//
//  THCartListCell.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCartListCell.h"
#import "THChangeCountView.h"
#import "THShoppingCartModel.h"

@interface THCartListCell()<UITextFieldDelegate>

@property (nonatomic,strong) THChangeCountView *changeView;

@end

@implementation THCartListCell
{
    __weak IBOutlet UIButton *selectBtn;
    __weak IBOutlet UIImageView *goodsImgV;
    __weak IBOutlet UILabel *goodsNameLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.changeView];
}

- (void)setModelData:(THCartGoodsModel *)modelData {
    _modelData = modelData;
    selectBtn.selected = _modelData.selected;
    [goodsImgV sd_setImageWithURL:[NSURL URLWithString:_modelData.goods.original_img] placeholderImage:nil];
    goodsNameLabel.text = _modelData.goods.goods_name;
    goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_modelData.goods.shop_price floatValue]];
    self.changeView.numberFD.text = [NSString stringWithFormat:@"%ld",_modelData.goods_num];
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.selectBtnClick) {
        self.selectBtnClick();
    }
    
    [self changeNum:self.choosedCount isSelected:sender.selected carId:_modelData.cid];
    
}

- (THChangeCountView *)changeView
{
    if (!_changeView) {
        _changeView = [[THChangeCountView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, self.frame.size.height - 35, 100, 35) chooseCount:1 totalCount:NSIntegerMax];
        [_changeView.subButton addTarget:self action:@selector(subButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        _changeView.numberFD.delegate = self;
        
        [_changeView.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeView;
}

//加
- (void)addButtonPressed:(id)sender {
    ++self.choosedCount;
    
    if (self.maxCount <= self.choosedCount) {
        self.choosedCount = self.maxCount;
        _changeView.addButton.enabled = NO;
    }
    else
    {
        _changeView.subButton.enabled = YES;
    }
    
    _changeView.numberFD.text = [NSString stringWithFormat:@"%zi",self.choosedCount];
    
    self.modelData.goods_num = self.choosedCount;
    
    [self changeNum:self.choosedCount isSelected:_modelData.selected carId:_modelData.cid];
	
	!self.changeGoodsNumBlock?:self.changeGoodsNumBlock();
	
}

//减
- (void)subButtonPressed:(id)sender
{
    
    -- self.choosedCount ;
    
    if (self.choosedCount==1) {
        self.choosedCount = 1;
        _changeView.subButton.enabled = NO;
    }
    else
    {
        _changeView.addButton.enabled = YES;
        
    }
    _changeView.numberFD.text = [NSString stringWithFormat:@"%zi",self.choosedCount];
    
    self.modelData.goods_num = self.choosedCount;
    
    [self changeNum:self.choosedCount isSelected:_modelData.selected carId:_modelData.cid];
	
	!self.changeGoodsNumBlock?:self.changeGoodsNumBlock();
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _changeView.numberFD = textField;
    
    if ([_changeView.numberFD.text isEqualToString:@""] || [_changeView.numberFD.text isEqualToString:@"0"] || [_changeView.numberFD.text integerValue]<0) {
        _changeView.numberFD.text = @"1";
        _changeView.subButton.enabled = NO;
        
    }
    NSString *numText = _changeView.numberFD.text;
    
    if ([numText intValue] >= self.maxCount) {
        _changeView.numberFD.text = [NSString stringWithFormat:@"%ld",self.maxCount];
        _changeView.addButton.enabled = NO;
    }
    
    self.choosedCount = [_changeView.numberFD.text integerValue];
    
}

#pragma mark - 购物车改变数量， 单个选中 或者取消
- (void)changeNum:(NSInteger)goodsNum isSelected:(BOOL)selected carId:(NSString *)carId {
    NSDictionary *dict = @{@"token":TOKEN, @"cart_id":carId, @"goods_num": @(goodsNum), @"selected":@(selected)};
    [THNetworkTool POST:API(@"/Cart/changeNum") parameters:dict completion:^(id responseObject, NSDictionary *allResponseObject) {
        NSLog(@"responseObject %@", responseObject);
    }];
}

@end
