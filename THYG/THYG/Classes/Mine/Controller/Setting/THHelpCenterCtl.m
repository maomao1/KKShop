//
//  THHelpCenterCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHelpCenterCtl.h"
#import "THHelpCenterDetailCtl.h"

@interface THHelpCenterCtl ()

@end

@implementation THHelpCenterCtl

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self = [[UIStoryboard storyboardWithName:@"THHelpCenterCtl" bundle:nil] instantiateInitialViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    THHelpCenterDetailCtl *detail = [[THHelpCenterDetailCtl alloc] init];
    if (ROW==0) {
        detail.title = @"用户注册";
        detail.webUrl = @"";
    }else if (ROW==1){
        detail.title = @"购物流程";
        detail.webUrl = @"";
    }else if (ROW==2){
        detail.title = @"配送方式";
        detail.webUrl = @"";
    }else if (ROW==3){
        detail.title = @"支付方式";
        detail.webUrl = @"";
    }else if (ROW==4){
        detail.title = @"发票支付方式";
        detail.webUrl = @"";
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
