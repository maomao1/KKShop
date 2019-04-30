//
//  THGoodsVC.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsVC.h"
#import "THGoodsHeaderView.h"
#import "THGoodsTopInfoCell.h"
#import "THGoodsCommentCell.h"
#import "THGoodsSpecificationsCell.h"
#import "THGoodsCommentHeaderView.h"
//选择规格
#import "ChoseGoodsTypeAlert.h"
#import "SizeAttributeModel.h"
#import "GoodsTypeModel.h"
#import "Header.h"


@interface THGoodsVC () <UITableViewDataSource, UITableViewDelegate> {
    NSUInteger _commentCount;  // 总评论数量
    NSUInteger _sectionCount; // 分组数量
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *banners;
@end

@implementation THGoodsVC{
    GoodsModel* model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    model = [[GoodsModel alloc] init];
}


- (void)setDetailModel:(THGoosDetailModel *)detailModel {
    _detailModel = detailModel;
    model.goodsNo = self.detailModel.goods_id;
    model.title = self.detailModel.goods_name;
}

- (void)setGoodsSpecModel:(THGoodsSpecModel *)goodsSpecModel {
    _goodsSpecModel = goodsSpecModel;
    if (!_goodsSpecModel.filter_spec.count) return;
    
    NSMutableArray * itemsListArr = [NSMutableArray arrayWithCapacity:0];
    for (THFilterSpecModel *filterModel in self.goodsSpecModel.filter_spec) {
        GoodsTypeModel *tpModel = [[GoodsTypeModel alloc] init];
        tpModel.typeName = filterModel.name;
        NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
        int index = 0;
        for (THItemSpecModel *itemM in filterModel.spec) {
            if ([self.goodsSpecModel.defaultSpec.key rangeOfString:itemM.spec_item_id].location != NSNotFound) {
                tpModel.selectIndex = index;
            }
            index++;
            [nameArr addObject:itemM.item];
        }
        tpModel.typeArray = nameArr;
        [itemsListArr addObject:tpModel];
    }
    model.itemsList = itemsListArr;
    
    model.sizeAttribute = [[NSMutableArray alloc] init];
    NSMutableArray *valueArr = @[].mutableCopy;
    for (THSpecDefaultModel *model in self.goodsSpecModel.spec_goods_price) {
        NSMutableString *mutStr = [[NSMutableString alloc] init];
        for (THFilterSpecModel *filterModel in self.goodsSpecModel.filter_spec) {
            
            for (THItemSpecModel *itemM in filterModel.spec) {
                
                if ([model.key rangeOfString:itemM.spec_item_id].location != NSNotFound) {
                    [mutStr appendFormat:@"%@、",itemM.item];
                }
            }
            
        }
        if (!mutStr.length) {
            continue;
        }
        [valueArr addObject:[mutStr substringToIndex:mutStr.length-1]];
    }
    
    for (int i = 0; i < valueArr.count; i++) {
        SizeAttributeModel *type = [[SizeAttributeModel alloc] init];
        type.price = self.goodsSpecModel.spec_goods_price[i].price;
        type.originalPrice = self.goodsSpecModel.spec_goods_price[i].price;
        type.stock = self.goodsSpecModel.spec_goods_price[i].store_count;
        type.goodsNo = model.goodsNo;
        type.value = valueArr[i];
        type.sizeid = [NSString stringWithFormat:@"%ld",self.goodsSpecModel.spec_goods_price[i].item_id];
        type.imageId = self.detailModel.original_img;
        [model.sizeAttribute addObject:type];
    }
//    [NSString stringWithFormat:@"%d.jpg",arc4random()%4]
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    
    // iOS11 适配
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
}

- (void)setBannerArr:(NSArray<THGoodsDetailBannerModel *> *)bannerArr {
    _bannerArr = bannerArr;
    for (THGoodsDetailBannerModel *model in _bannerArr) {
        if (![model.image_url containsString:@"http://"]) {
            model.image_url = [@"http://th1818.bingogd.com" stringByAppendingString:model.image_url];
        }
        [self.banners addObject:model.image_url];
    }
    [self.tableView reloadData];
}

- (void)setCommentArr:(NSMutableArray<THGoodsCommentModel *> *)commentArr {
    _commentArr = commentArr;
    _commentCount = _commentArr.count;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < _commentArr.count; i++) {
        if (i > 2) {
            [indexSet addIndex:i];
        }
    }
    [_commentArr removeObjectsAtIndexes:indexSet];
    [self.tableView reloadData];
}

- (void)setCommentRatio:(NSString *)commentRatio {
    _commentRatio = commentRatio;
    [self.tableView reloadData];
}

#pragma mark - 取消 / 收藏商品
- (void)collectGoods:(BOOL)collect {
    [THNetworkTool POST:API(@"/Goods/collectionGoods")
             parameters:@{@"token":TOKEN, @"goods_id":self.detailModel.goods_id, @"collect": @(collect)}
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 if (responseObject) {
                     [THHUD showMsg:responseObject[@"msg"]];
                 } else {
                     [THHUD showMsg:allResponseObject[@"msg"]];
                 }
                 
             }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_commentArr.count && _goodsSpecModel.filter_spec.count) {
        return 3;
        
    } else if (!_commentArr.count && !_goodsSpecModel.filter_spec.count) {
        return 1;
        
    } else {
        return 2;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _commentArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
    
    if (indexPath.section == 0) {
        THGoodsTopInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:STRING(THGoodsTopInfoCell)];
        infoCell.goodsDetailModel = self.detailModel;
        WEAKSELF;
        infoCell.focusBtnAction = ^(BOOL isSelected) {
            if (!weakSelf.detailModel) {
                return ;
            }
            [weakSelf collectGoods:isSelected];
        };
        
        cell = infoCell;
        
    } else if (indexPath.section == 1) {
        
        if (_goodsSpecModel.filter_spec.count) {
            
            THGoodsSpecificationsCell *specCell = [tableView dequeueReusableCellWithIdentifier:STRING(THGoodsSpecificationsCell)];
            specCell.defaultSpec = self.goodsSpecModel.defaultSpec.default_str;
            
            cell = specCell;
            
            specCell.selectSpecBtnBlock = ^{
                
                ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) andHeight:kSize (450)];
                _alert.alpha = 0;
                [[UIApplication sharedApplication].keyWindow addSubview:_alert];
                
                _alert.selectSize = ^(SizeAttributeModel *sizeModel) {
                    //sizeModel 选择的属性模型
                    [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.value]];
                    specCell.defaultSpec = sizeModel.value;
                    
                    !self.specBlock?:self.specBlock(sizeModel.sizeid, sizeModel.count);
                    
                };
                [_alert initData:model];
                [_alert showView];
                
            };
        
        } else {
            
            THGoodsCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:STRING(THGoodsCommentCell)];
            commentCell.commentModel = _commentArr[indexPath.row];
            cell = commentCell;
            
        }
        
        
    } else {
        
        THGoodsCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:STRING(THGoodsCommentCell)];
        commentCell.commentModel = _commentArr[indexPath.row];
        cell = commentCell;
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = nil;
    if (section == 0) {
        THGoodsHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STRING(THGoodsHeaderView)];
        headerView.bannerImageArray = self.banners;
        view = headerView;
        
    } else if (section == 2 || (!_goodsSpecModel.filter_spec.count && _commentArr.count && section == 1)) {
        THGoodsCommentHeaderView *commentHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STRING(THGoodsCommentHeaderView)];
        commentHeaderView.commentCount = _commentCount;
        commentHeaderView.ratio = _commentRatio;
        view = commentHeaderView;
        
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return SCREEN_WIDTH;
    } else if (section == 2) {
        return 44;
    }
    return DEFAULT_TABLEVIEW_HEADER_HEAGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return DEFAULT_TABLEVIEW_HEADER_HEAGHT;
    }
    return MinFloat;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return 112;
    } else if (indexPath.section == 2) {
        THGoodsCommentModel *model = _commentArr[indexPath.row];
        return model.cellHeight;
    }
    return 44;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:CLASS(@"THGoodsHeaderView") forHeaderFooterViewReuseIdentifier:STRING(THGoodsHeaderView)];
        
        [_tableView registerClass:CLASS(@"THGoodsCommentHeaderView") forHeaderFooterViewReuseIdentifier:STRING(THGoodsCommentHeaderView)];
        
        [_tableView registerNib:NIB(@"THGoodsTopInfoCell") forCellReuseIdentifier:STRING(THGoodsTopInfoCell)];
        
        [_tableView registerNib:NIB(@"THGoodsSpecificationsCell") forCellReuseIdentifier:STRING(THGoodsSpecificationsCell)];
        
        [_tableView registerClass:CLASS(@"THGoodsCommentCell") forCellReuseIdentifier:STRING(THGoodsCommentCell)];
        
    }
    return _tableView;
}

- (NSMutableArray *)banners {
    if (!_banners) {
        _banners = [NSMutableArray arrayWithCapacity:0];
    }
    return _banners;
}

@end
