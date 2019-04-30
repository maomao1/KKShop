//
//  THAcountDetailCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAcountDetailCtl.h"
#import "THAccountDetailCell.h"

@interface THAcountDetailCtl ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation THAcountDetailCtl

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.balanceCateType != recommandBalanceType) {
        self.headView.hidden = YES;
    }else{
        self.dataTableView.y = 60;
        self.dataTableView.height -= 60;
    }
    
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerNib:[UINib nibWithNibName:STRING(THAccountDetailCell) bundle:nil] forCellReuseIdentifier:STRING(THAccountDetailCell)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THAccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THAccountDetailCell)];
    
    return cell;
}

@end
