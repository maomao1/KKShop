//
//  THMyTaskCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyTaskCtl.h"
#import "THMyTaskCell.h"

@interface THMyTaskCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation THMyTaskCtl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.mTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.data.count;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THMyTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THMyTaskCell)];
    [cell refreshWithIndexPath:indexPath];
    return cell;
}

- (UITableView *)mTable
{
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        _mTable.allowsSelection = NO;
        [_mTable registerNib:[UINib nibWithNibName:STRING(THMyTaskCell) bundle:nil] forCellReuseIdentifier:STRING(THMyTaskCell)];
    }
    return _mTable;
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

@end
