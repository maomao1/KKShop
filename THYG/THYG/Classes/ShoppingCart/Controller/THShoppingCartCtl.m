//
//  THShoppingCartCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartCtl.h"
#import "THShoppingCartListDelegate.h"
#import "THShoppingCartModel.h"
#import "THOrderConfirmCtl.h"
#import "THShareView.h"

@interface THShoppingCartCtl ()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn; // 全选
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;  // 分享
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn; // 删除
@property (weak, nonatomic) IBOutlet UIButton *removeBtn; // 移入关注
@property (weak, nonatomic) IBOutlet UIButton *buyBtn; // 结算
@property (weak, nonatomic) IBOutlet UILabel *selectStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) UIButton *navBtn; // 导航按钮
@property (nonatomic,strong) THShoppingCartListDelegate *tableDelegate;
@property (nonatomic, assign) BOOL isEditing; // 是否在编辑状态

@end

@implementation THShoppingCartCtl

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.selectBtn.selected = NO;
    [self.tableDelegate.dataArray removeAllObjects];
    [self loadData];
}

#pragma mark - 设置视图
- (void)setupUI {
    [self.view addSubview:self.mTable];
    [self.mTable reloadData];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBtn];
    self.shareBtn.layer.borderColor = self.removeBtn.layer.borderColor = GRAY_COLOR(220).CGColor;
    self.deleteBtn.layer.borderColor = RED_COLOR.CGColor;
}

#pragma mark - 编辑操作
- (void)editClick {
    if (!self.isEditing) {
        [self editingStatus];
    } else {
        [self finishingStatus];
    }
}

#pragma mark - 编辑状态
- (void)editingStatus {
    self.totalPriceLabel.hidden = YES;
    self.isEditing = YES;
    self.buyBtn.hidden = YES;
    self.shareBtn.hidden = self.removeBtn.hidden = self.deleteBtn.hidden = NO;
    [_navBtn setTitle:@"完成" forState:UIControlStateNormal];
}

#pragma mark - 完成状态
- (void)finishingStatus {
    self.totalPriceLabel.hidden = NO;
    self.isEditing = NO;
    self.buyBtn.hidden = NO;
    self.shareBtn.hidden = self.removeBtn.hidden = self.deleteBtn.hidden = YES;
    [_navBtn setTitle:@"编辑" forState:UIControlStateNormal];
}

- (void)loadData {
    self.buyBtn.hidden = NO;
    self.shareBtn.hidden = self.removeBtn.hidden = self.deleteBtn.hidden = YES;
    [THNetworkTool POST:API(@"/Cart/getCartList")
             parameters:@{@"token":TOKEN}
             completion:^(id responseObject, NSDictionary *allResponseObject) {
                 self.tableDelegate.data = [THShoppingCartModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
             [self.mTable reloadData];
    }];
}

#pragma mark -- 全选按钮
- (IBAction)selectBtnAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    sender.selected ? (self.totalPriceLabel.text = @"取消全选") : (self.totalPriceLabel.text = @"全选");
    self.tableDelegate.selectOptionAllBlock(sender.selected);
    NSString *cart_ids = @"[";
    for (THShoppingCartModel *model in self.tableDelegate.data) {
        for (THCartGoodsModel *subModel in model.cart) {
            cart_ids = [[cart_ids stringByAppendingString:subModel.cid] stringByAppendingString:@","];
        }
    }
    cart_ids = [[cart_ids substringToIndex:cart_ids.length-1] stringByAppendingString:@"]"];
    [THNetworkTool POST:API(@"/Cart/selectAll")
             parameters:@{@"token":TOKEN,
                          @"cart_ids":cart_ids,
                          @"selected":sender.selected ? @1 : @0
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
             }];
}

#pragma mark -- 结算
- (IBAction)settlementBtnClick:(id)sender {
    
    if (self.tableDelegate.dataArray.count) {
        
        NSString *cart_ids = @"[";
        for (THCartGoodsModel *model in self.tableDelegate.dataArray) {
            cart_ids = [[cart_ids stringByAppendingString:model.cid] stringByAppendingString:@","];
        }
        cart_ids = [[cart_ids substringToIndex:cart_ids.length-1] stringByAppendingString:@"]"];

        THOrderConfirmCtl *orderConfirm = [[THOrderConfirmCtl alloc] init];
        orderConfirm.cart_ids = cart_ids;
        orderConfirm.title = @"填写订单";
        [self pushVC:orderConfirm];
        
    } else {
        [THHUD showMsg:@"您还未选择任何商品"];
    }
    
}

#pragma mark - 分享 & 移入收藏 & 删除
- (IBAction)bottomButtonAction:(UIButton *)btn {
    NSInteger tag = btn.tag - 1000;
    
    NSString *cart_ids = @"[";
    if (self.tableDelegate.dataArray.count) {
        for (THCartGoodsModel *model in self.tableDelegate.dataArray) {
            cart_ids = [[cart_ids stringByAppendingString:model.cid] stringByAppendingString:@","];
        }
        cart_ids = [[cart_ids substringToIndex:cart_ids.length-1] stringByAppendingString:@"]"];
    }
    
    if (tag == 0) { // 分享
        if (!self.tableDelegate.dataArray.count) {
            [THHUD showMsg:@"请选择商品"];
        } else {
            
            THShareView *shareView = [[THShareView alloc] initShareViewWithTitle:@[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"微博",@"复制链接"] andImageArry:@[@"weixin",@"pengyouquan",@"QQ",@"QQkongjian",@"xinlangweibo",@"fuzhilianjie"]];
            [[UIApplication sharedApplication].keyWindow addSubview:shareView];
            
            shareView.selectItemBlock = ^(NSInteger index) {
                NSLog(@"fenxiang %ld", index);
            };
            
        }
        
    } else if (tag == 1) { // 移入收藏
        if (!self.tableDelegate.dataArray.count) {
            [THHUD showMsg:@"请选择商品"];
        } else {
            [self carActionWithCarIds:cart_ids isDelete:NO];
        }
        
    } else { // 删除
        if (!self.tableDelegate.dataArray.count) {
            [THHUD showMsg:@"请选择商品"];
        } else {
            [self carActionWithCarIds:cart_ids isDelete:YES];
            
        }
        
    }
    
}

#pragma mark - 购物车操作
/**
 购物车操作
 @param carId 选中商品购物车id数组
 @param delete YES 为delete 商品， NO为移入收藏
 */
- (void)carActionWithCarIds:(NSString *)carId isDelete:(BOOL)delete {
    NSString *message = delete ? @"确定要删除所选产品吗?" : @"确定要关注所选商品吗？关注成功后，将从购物车删除，请您确认";
    NSString *title = delete ? @"删除所选产品" : @"关注所选商品";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (delete) {
            [self deleteGoodsFromCar:carId];
        } else {
            [self removeGoodsFromCar:carId];
        }
        
    }];
    
    [sure setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    [alertController addAction:sure];
    [alertController addAction:cancle];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - 删除商品
- (void)deleteGoodsFromCar:(NSString *)cart_ids {
    [THNetworkTool POST:API(@"/Cart/delete") parameters:@{@"token":TOKEN, @"cart_ids":cart_ids} completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            [THHUD showSuccess:@"删除成功"];
            [self finishingStatus];
            [self.tableDelegate.dataArray removeAllObjects];
            [self loadData];
        }
        
    }];
}

#pragma mark - 商品移入我的关注
- (void)removeGoodsFromCar:(NSString *)cart_ids {
    
    NSString *goods_ids = @"[";
    for (THCartGoodsModel *model in self.tableDelegate.dataArray) {
        goods_ids = [[goods_ids stringByAppendingString:model.goods_id] stringByAppendingString:@","];
    }
    goods_ids = [[goods_ids substringToIndex:goods_ids.length-1] stringByAppendingString:@"]"];
    
    
    [THNetworkTool POST:API(@"/Cart/moveToCollect") parameters:@{@"token":TOKEN, @"cart_ids":cart_ids, @"goods_ids":goods_ids} completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            [THHUD showSuccess:@"移入关注成功"];
            [self finishingStatus];
            [self.tableDelegate.dataArray removeAllObjects];
            
            [self loadData];
            [_navBtn setTitle:@"管理" forState:UIControlStateNormal];
        }
        
    }];
}

#pragma mark - 空数据
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return IMAGENAMED(@"noOrder");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"暂无商品，快去逛逛吧~" attributes:@{NSForegroundColorAttributeName:GRAY_151, NSFontAttributeName:Font14}];
    return string;
}


#pragma mark - 懒加载
- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight-kTabBarHeight-45) style:UITableViewStylePlain];
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        [self.tableDelegate registerTable:_mTable];
        self.tableDelegate.totalPriceLabel = self.totalPriceLabel;
        self.tableDelegate.selectBtn = self.selectBtn;
        _mTable.delegate = self.tableDelegate;
        _mTable.dataSource = self.tableDelegate;
        _mTable.emptyDataSetSource = self;
        _mTable.emptyDataSetDelegate = self;
    }
    return _mTable;
}

- (THShoppingCartListDelegate *)tableDelegate {
    if (!_tableDelegate) {
        _tableDelegate = [[THShoppingCartListDelegate alloc] init];
    }
    return _tableDelegate;
}

- (UIButton *)navBtn {
    if (!_navBtn) {
        _navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBtn.frame = CGRectMake(0, 0, 30, 30);
        [_navBtn setTitle:@"管理" forState:UIControlStateNormal];
        _navBtn.titleLabel.font = Font15;
        [_navBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBtn;
}

@end
