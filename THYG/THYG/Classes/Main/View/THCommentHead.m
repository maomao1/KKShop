
//
//  THCommentHead.m
//  THYG
//
//  Created by 廖辉 on 2018/6/11.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentHead.h"
#import "THCommentCateView.h"

@implementation THCommentHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        THCommentCateView *commentCate = [[THCommentCateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return self;
}

@end
