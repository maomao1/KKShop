//
//  THCommentVC.m
//  THYG
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentVC.h"
#import "THGoodsCommentModel.h"
#import "THGoodsCommentCell.h"
#import "THCommentHead.h"

@interface THCommentVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation THCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getComments];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

#pragma mark - comment
- (void)getComments {
    [THNetworkTool POST:API(@"/Goods/getCommentList") parameters:@{@"token":TOKEN, @"goods_id":self.goods_id} completion:^(id responseObject, NSDictionary *allResponseObject) {
        if (responseObject) {
            self.commentArray = [THGoodsCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
            [self.commentArray enumerateObjectsUsingBlock:^(THGoodsCommentModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                int columnCount = obj.img.count < 4 ? 1 : (obj.img.count%4 ? obj.img.count%4+1 : obj.img.count%4);
                CGFloat picHeight = obj.img.count == 0 ? 0 : ((SCREEN_WIDTH - 10 * (4+1)) / 4) * columnCount + (columnCount - 1)*10;
                obj.cellHeight = [obj.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font11} context:nil].size.height + picHeight + 120;
                
            }];
            [self.tableView reloadData];
        }
        
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    THCommentHead *head = [[THCommentHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THGoodsCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:STRING(THGoodsCommentCell)];
    cell.commentModel = self.commentArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    THGoodsCommentModel *model = self.commentArray[indexPath.row];
    return model.cellHeight;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNaviHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:CLASS(@"THGoodsCommentCell") forCellReuseIdentifier:STRING(THGoodsCommentCell)];
        
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentArray;
}

@end
