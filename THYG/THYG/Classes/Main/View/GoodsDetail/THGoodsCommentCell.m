//
//  THGoodsCommentCell.m
//  THYG
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsCommentCell.h"
#import "YYStarView.h"
#import "THGoodsCommentModel.h"
#import "THPhotoContainerView.h"

@interface THGoodsCommentCell ()

@property (nonatomic, strong) UIImageView *iconImgView; // 头像
@property (nonatomic, strong) UILabel *nameLabel;  // 昵称
@property (nonatomic, strong) UILabel *commentLabel; // 评论
@property (nonatomic, strong) UILabel *unitLabel; // 单位
@property (nonatomic, strong) UILabel *lineLabel; // 底部线
@property (nonatomic, strong) YYStarView *starView; // 星星
@property (nonatomic, strong) THPhotoContainerView *picContainerView;//评论的图片

@end

@implementation THGoodsCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.commentLabel];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.picContainerView];
    }
    return self;
}

- (void)setCommentModel:(THGoodsCommentModel *)commentModel {
    _commentModel = commentModel;
    
    [self.iconImgView sd_setImageWithURL:URL(_commentModel.head_pic) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            self.iconImgView.image = [image circleImage];
        }
    }];
    
    self.nameLabel.text = _commentModel.username;
    self.commentLabel.text = [NSString stringWithFormat:@"%@",_commentModel.content];
    self.unitLabel.text = [NSString stringWithFormat:@"%@%@", _commentModel.goods_num, _commentModel.unit];
    self.starView.scorePercent = (CGFloat)([_commentModel.goods_rank floatValue]/5);
    self.picContainerView.picPathStringsArray = _commentModel.img;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.width.height.offset(45);
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
        make.width.offset(70);
        make.height.offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
        make.right.equalTo(self.starView.mas_left).offset(-10);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_left);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.offset(15);
    }];
    
    [self.picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_left);
        make.right.equalTo(self.starView.mas_right);
        make.bottom.equalTo(self.unitLabel.mas_top).offset(-10);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_left);
        make.right.offset(-10);
        make.top.equalTo(self.iconImgView.mas_bottom).offset(15);
        make.bottom.equalTo(self.picContainerView.mas_top).offset(-10);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(0.6);
    }];
    
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"touxiang")];
//        _iconImgView.backgroundColor = RANDOMCOLOR;
    }
    return _iconImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"" fontSize:Font15 color:GRAY_51];
//        _nameLabel.backgroundColor = RANDOMCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [UILabel labelWithText:@"" fontSize:Font11 color:GRAY_51];
        _commentLabel.numberOfLines = 0;
//        _commentLabel.backgroundColor = RANDOMCOLOR;
    }
    return _commentLabel;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [UILabel labelWithText:@"xxx" fontSize:Font11 color:GRAY_151];
//        _unitLabel.backgroundColor = RANDOMCOLOR;
    }
    return _unitLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = LINECOLOR;
    }
    return _lineLabel;
}

- (YYStarView *)starView {
    if (!_starView) {
        _starView = [[YYStarView alloc] initWithFrame:CGRectMake(0, 0, 70, 15) numberOfStars:5];
        _starView.allowIncompleteStar = YES;
        _starView.userInteractionEnabled = NO;
//        _starView.backgroundColor = RANDOMCOLOR;
    }
    return _starView;
}

- (THPhotoContainerView *)picContainerView
{
    if (!_picContainerView) {
        _picContainerView = [[THPhotoContainerView alloc] init];
    }
    return _picContainerView;
}

@end
