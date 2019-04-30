//
//  THGoodsCommentModel.h
//  THYG
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THGoodsCommentModel : NSObject

@property (nonatomic, copy) NSString *comment_id; // 评论id
@property (nonatomic, copy) NSString *username; // 用户名
@property (nonatomic, copy) NSString *content; // 评论
@property (nonatomic, copy) NSString *is_anonymous;// 是否匿名
@property (nonatomic, copy) NSString *head_pic; // 头像
@property (nonatomic, copy) NSString *goods_rank;// 星星数
@property (nonatomic, copy) NSArray  *img; // 图片
@property (nonatomic, copy) NSString *unit; // 单位
@property (nonatomic, copy) NSString *goods_num; // 购买个数
@property (nonatomic, assign) CGFloat cellHeight;

@end
