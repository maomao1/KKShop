//
//  THTeHuiModel.h
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THTeHuiModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSArray *img;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *head_pic;
@property (nonatomic, copy) NSString *ip_address;
@property (nonatomic, copy) NSString *original_img;
@property (nonatomic, copy) NSString *zan_userid;
@property (nonatomic, assign) BOOL is_anonymous;
@property (nonatomic, assign) BOOL is_show;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger comment_id;
@property (nonatomic, assign) NSInteger comment_num;
@property (nonatomic, assign) NSInteger deliver_rank;
@property (nonatomic, assign) NSInteger forward_num;
@property (nonatomic, assign) NSInteger goods_id;
@property (nonatomic, assign) NSInteger goods_rank;
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger service_rank;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger zan_num;

@end
