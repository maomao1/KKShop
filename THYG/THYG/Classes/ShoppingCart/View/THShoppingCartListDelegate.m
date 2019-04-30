//
//  THShoppingCartListDelegate.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartListDelegate.h"
#import "THCartListCell.h"
#import "THCartSectionHead.h"
#import "THShoppingCartModel.h"

@interface THShoppingCartListDelegate()
@property (nonatomic, copy) void(^refreshHeadView)(THShoppingCartModel *model);
@end

@implementation THShoppingCartListDelegate
{
    UITableView *_mTable;
}

- (void)registerTable:(UITableView *)table
{
    
    _mTable = table;
    [table registerNib:[UINib nibWithNibName:STRING(THCartListCell) bundle:nil] forCellReuseIdentifier:STRING(THCartListCell)];
    [table registerClass:[THCartSectionHead class] forHeaderFooterViewReuseIdentifier:STRING(THCartSectionHead)];
    
    WEAKSELF;
    self.selectOptionAllBlock = ^(BOOL isSelect) {
      
        [weakSelf selectOptionAll:isSelect];
        
    };
}

- (void)setData:(NSArray *)data
{
    _data = data;
    [self  caculateteTotalPrice];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    THCartSectionHead *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STRING(THCartSectionHead)];
    head.contentView.backgroundColor = GRAY_COLOR(222);
    THShoppingCartModel *model = self.data[section];
    NSLog(@">>>%@%@,,,,,%ld",model.suppliers.suppliers_name,model.suppliers.suppliers_id,section);
    head.modelData = model.suppliers;
    head.selectBtnClick = ^{
        model.suppliers.isSelect = !model.suppliers.isSelect;
        [self selectOptionGroup:model];
    };
    self.refreshHeadView = ^(THShoppingCartModel *model) {
        head.modelData = model.suppliers;
    };
    return head;
}

#pragma mark -- 全选/取消全选一个分组
- (void)selectOptionGroup:(THShoppingCartModel *)model
{
    self.totalPrice = 0;
    if (!model.suppliers.isSelect) {
        self.selectBtn.selected = NO;
    }
    [[model cart] enumerateObjectsUsingBlock:^(THCartGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        obj.selected = model.suppliers.isSelect;
        
    }];
    
    [self caculateteTotalPrice];
    
    [_mTable reloadData];
    
}
#pragma mark -- 全选/取消全选整个购物车
- (void)selectOptionAll:(BOOL)isSelect
{
    if (!isSelect) {
        self.selectBtn.selected = NO;
    }
    [self.data enumerateObjectsUsingBlock:^(THShoppingCartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.suppliers.isSelect = isSelect;
        
        [obj.cart enumerateObjectsUsingBlock:^(THCartGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            obj.selected = isSelect;
            
        }];
        
    }];
    
    [self caculateteTotalPrice];
    
    
    [_mTable reloadData];
}

#pragma mark -- 计算总价格
- (void)caculateteTotalPrice
{
    BOOL isSelectAll = YES;
    for (THShoppingCartModel *model in self.data) {
        
        BOOL isSelectGroupAll = YES;
        for (THCartGoodsModel *subModel in model.cart) {
            if (!subModel.selected) {
                isSelectGroupAll = NO;
            }
        }
        if (!isSelectGroupAll) {
            isSelectAll = NO;
        }
        model.suppliers.isSelect = isSelectGroupAll;
    }
    self.selectBtn.selected = isSelectAll;
    
    self.totalPrice = 0;
    [self.data enumerateObjectsUsingBlock:^(THShoppingCartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.cart enumerateObjectsUsingBlock:^(THCartGoodsModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj1.selected) {
                self.totalPrice += obj1.goods_price * obj1.goods_num;
            }
            
        }];
        
    }];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计:￥%.2lf",self.totalPrice];
    
    [_mTable reloadData];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data[section] cart] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THCartListCell)];
    THCartGoodsModel *model = [self.data[SECTION] cart][ROW];
    cell.choosedCount = model.goods_num;
    cell.maxCount = model.goods.store_count; // 库存
    cell.modelData = model;
    cell.selectBtnClick = ^{
        model.selected = !model.selected;
        if (!model.selected) {
            self.selectBtn.selected = NO;
        }
        THShoppingCartModel *gModel = self.data[SECTION];
        if (!model.selected && gModel.suppliers.isSelect) {
            gModel.suppliers.isSelect = NO;
        }
        if (self.refreshHeadView) {
            self.refreshHeadView(gModel);
        }
        
        [self caculateteTotalPrice];
        
    };
	
	cell.changeGoodsNumBlock = ^{
		[self caculateteTotalPrice];
	};
	
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)dataArray {
    
    _dataArray = @[].mutableCopy;
    for (THShoppingCartModel *model in self.data) {
        for (THCartGoodsModel *subModel in model.cart) {
            if (subModel.selected) {
                [_dataArray addObject:subModel];
            }
        }
    }
    return _dataArray;
}

@end
