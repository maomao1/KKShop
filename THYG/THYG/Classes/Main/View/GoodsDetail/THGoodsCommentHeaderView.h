//
//  THGoodsCommentHeaderView.h
//  THYG
//
//  Created by Mac on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THGoodsCommentHeaderView : UITableViewHeaderFooterView
@property (nonatomic, assign) NSInteger commentCount; // 总评论数
@property (nonatomic, assign) NSString *ratio; // 好评率
@end
