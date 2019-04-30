//
//  THRecommendedCell.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRecommendedCell.h"

@implementation THRecommendedCell
{
    __weak IBOutlet UIImageView *imgV;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    [imgV sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:nil];
}

@end
