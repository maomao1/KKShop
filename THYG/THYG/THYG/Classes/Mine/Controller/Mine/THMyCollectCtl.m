
//
//  THMyCollectCtl.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyCollectCtl.h"
#import "THMyCollectCell.h"
#import "THMyCollectModel.h"

@interface THMyCollectCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation THMyCollectCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mTable];
    self.title = self.type? @"浏览记录" :@"我的关注";
    [self loadData];
}

- (void)loadData {
    
    NSString *url = @"";
    
    if (self.type) {
        url = @"/User/getVisit";
    } else {
        url = @"/User/collectList";
    }
    NSLog(@"url%@", url);
    [THNetworkTool POST:API(url) parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
        self.data = [THMyCollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        [self.mTable reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THMyCollectCell)];
    THMyCollectModel *model = self.data[indexPath.row];
    cell.modelData = model;
    
    cell.addCartAction = ^{
        [THNetworkTool POST:API(@"/Cart/addCart")
                 parameters:@{@"goods_id":model.goods_id,
                              @"goods_num":@"1",
                              @"item_id":@"",
                              @"token":TOKEN
                              }
                 completion:^(id responseObject, NSDictionary *allResponseObject) {
                     
                     [THHUD showSuccess:@"成功加入购物车"];
                     
                 }];    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerNib:[UINib nibWithNibName:STRING(THMyCollectCell) bundle:nil] forCellReuseIdentifier:STRING(THMyCollectCell)];
    }
    return _mTable;
}

- (NSMutableArray*)data {
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

@end
