//
//  THMyFootprintCtl.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyFootprintCtl.h"

@interface THMyFootprintCtl ()

@end

@implementation THMyFootprintCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadData
{
    [THNetworkTool POST:API(@"/User/getVisitList") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
        NSLog(@"responseObject %@", responseObject);
    }];
}

@end
