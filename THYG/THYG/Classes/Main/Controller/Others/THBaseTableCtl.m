//
//  THBaseTableCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/4/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseTableCtl.h"

@interface THBaseTableCtl ()

@end

@implementation THBaseTableCtl

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
