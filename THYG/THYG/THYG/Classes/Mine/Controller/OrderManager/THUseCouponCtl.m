//
//  THUseCouponCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUseCouponCtl.h"
#import "THCouponsCell.h"
#import "THCartDetailModel.h"

@interface THUseCouponCtl ()

@end

@implementation THUseCouponCtl

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择优惠券";
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerNib:NIB(STRING(THCouponsCell)) forCellReuseIdentifier:STRING(THCouponsCell)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THCouponsCell)];
    cell.modelData = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCouponBlock) {
        self.selectCouponBlock(self.dataSourceArray[indexPath.row]);
    }
    [self popVC];
}

@end
