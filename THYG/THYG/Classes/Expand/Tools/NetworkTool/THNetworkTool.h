//
//  THNetworkTool.h
//  THYG
//
//  Created by Victory on 2018/3/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "PPNetworkHelper.h"

@interface THNetworkTool : PPNetworkHelper

+ (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void(^)(id responseObject, NSDictionary *allResponseObject))completion;

@end
