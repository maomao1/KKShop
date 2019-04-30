//
//  THSystemMessageCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSystemMessageCtl.h"
#import "THSystemMessageCell.h"

@interface THSystemMessageCtl ()

@end

@implementation THSystemMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerNib:[UINib nibWithNibName:STRING(THSystemMessageCell) bundle:nil] forCellReuseIdentifier:STRING(THSystemMessageCell)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THSystemMessageCell)];
    
    return cell;
}

@end
