//
//  THMineBankCardVC.m
//  THYG
//
//  Created by Victory on 2018/6/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineBankCardVC.h"
#import "THMineBankCardListCell.h"

@interface THMineBankCardVC ()

@end

@implementation THMineBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupUI];
}

#pragma mark - 设置UI界面
- (void)setupUI {
	self.title = @"银行卡";
	self.isGrouped = YES;
	[self.view addSubview:self.dataTableView];
	[self.dataTableView registerNib:NIB(@"THMineBankCardListCell") forCellReuseIdentifier:STRING(THMineBankCardListCell)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	THMineBankCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THMineBankCardListCell)];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (section == 1) {
	}
	return nil;
}

@end
