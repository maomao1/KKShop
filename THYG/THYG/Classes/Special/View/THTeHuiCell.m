//
//  THTeHuiCell.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "THTeHuiModel.h"

const CGFloat contentLblFontSize = 15;
CGFloat maxContentLblHeight = 0; // 根据具体font而定

@interface THTeHuiCell () {
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UILabel *_timeLabel;
    UIButton *_moreButton;
    UIView   *_buttomView;
    UIView *_groupImgView;
    UIView *_buttomToolView;
    UIImageView *_avatarImgView;
    UIImageView *_iconImgView;
    UILabel *_buttonSubLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
}
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArr;

@end

@implementation THTeHuiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"touxiang")];
    }
    
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"lalalala" fontSize:Font16 color:GRAY_51];
    }
    
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"hehehehehe" fontSize:Font12 color:GRAY_151];
    }
    
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"aldlasdladladladlaldalsaldaldaldladsladlbsdfhahfasdhfahfahfhasdfhafhahdfahfhashdfhahfahfhashdfahdfhashdfahsdfhasfdhashdfahf" fontSize:Font16 color:GRAY_51];
        _contentLabel.numberOfLines = 0;
        if (maxContentLblHeight == 0) {
            maxContentLblHeight = _contentLabel.font.lineHeight * 3;
        }
    }
    
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setTitle:@"查看全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = Font16;
    }
    
//    if (!_groupImgView) {
//        _groupImgView = [[UIView alloc] init];
//        _groupImgView.backgroundColor = RANDOMCOLOR;
//    }
    
    if (!_picContainerView) {
        _picContainerView = [SDWeiXinPhotoContainerView new];
    }
    
    if (!_buttomView) {
        _buttomView = [[UIView alloc] init];
        _buttomView.backgroundColor = BGColor;
        
        _iconImgView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"chanpintu")];
        [_buttomView addSubview:_iconImgView];
        
        _buttonSubLabel = [UILabel labelWithText:@"佳宝怀旧小吃小吃小吃小吃小吃小吃小吃小吃" fontSize:Font14 color:GRAY_151];
        _buttonSubLabel.numberOfLines = 2;
        [_buttomView addSubview:_buttonSubLabel];
        
    }
    
    if (!_buttomToolView) {
        _buttomToolView = [[UIView alloc] init];
        _buttomToolView.backgroundColor  = WHITE_COLOR;
        NSArray *titles = @[@"0",@"0",@"0"];
        NSArray *images = @[@"fenxiang",@"pinglun",@"dianzan"];
        for (int i = 0; i < titles.count; i++) {
            UIButton *btn = [UIButton new];
            [_buttonArr addObject:btn];
            btn.tag = i + SCREEN_HEIGHT;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:GRAY_51 forState:UIControlStateNormal];
            btn.titleLabel.font = Font16;
            [btn setImage:IMAGENAMED(images[i]) forState:UIControlStateNormal];
            if (i == 2) {
                [btn setImage:IMAGENAMED(@"dianlezan") forState:UIControlStateSelected];
            }
            [btn addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.frame = CGRectMake((56+38)*i, 0, 56, 42);
            [_buttomToolView addSubview:btn];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        }
    }
    
    NSArray *views = @[_avatarImgView, _nameLabel, _timeLabel, _contentLabel, _moreButton, _picContainerView, _buttomView, _buttomToolView];
    
    [self.contentView sd_addSubviews:views];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
     CGFloat margin = 12;
    
    _avatarImgView.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .topSpaceToView(self.contentView, margin)
    .widthIs(44)
    .heightIs(44);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_avatarImgView, margin-2)
    .topSpaceToView(self.contentView, margin+5)
    .heightIs(16);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .bottomEqualToView(_avatarImgView)
    .heightIs(16);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(_timeLabel)
    .topSpaceToView(_avatarImgView, margin)
    .rightSpaceToView(self.contentView, margin)
    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(80)
    .heightIs(18);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_moreButton, 5);
    
    _buttomView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, 4)
    .rightEqualToView(_contentLabel)
    .heightIs(44);
    
    _iconImgView.sd_layout
    .leftSpaceToView(_buttomView, 4)
    .topSpaceToView(_buttomView, 4)
    .bottomSpaceToView(_buttomView, 4)
    .widthIs(38);
    
    _buttonSubLabel.sd_layout
    .leftSpaceToView(_iconImgView, 10)
    .topSpaceToView(_buttomView, 5)
    .bottomSpaceToView(_buttomView, 5)
    .rightSpaceToView(_buttomView, 10);
    
    _buttomToolView.sd_layout
    .topSpaceToView(_buttomView, 0)
    .leftEqualToView(_buttomView)
    .rightEqualToView(_buttomView)
    .heightIs(42);
    
}

- (void)setTeModel:(THTeHuiModel *)teModel {
    _teModel = teModel;
    [_avatarImgView sd_setImageWithURL:URL(_teModel.head_pic) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            _avatarImgView.image = [image circleImage];
        } else {
            _avatarImgView.image = IMAGENAMED(@"touxiang");
        }
    }];
    
    _nameLabel.text = _teModel.username;
    _timeLabel.text = _teModel.add_time;
    _contentLabel.text = _teModel.content;
    _picContainerView.picPathStringsArray = _teModel.img;
    [_iconImgView sd_setImageWithURL:URL(_teModel.original_img) placeholderImage:IMAGENAMED(@"chanpintu")];
    _buttonSubLabel.text = _teModel.goods_name;

    [_buttonArr[0] setTitle:[NSString stringWithFormat:@"%ld", _teModel.forward_num] forState:UIControlStateNormal];
    [_buttonArr[1] setTitle:[NSString stringWithFormat:@"%ld", _teModel.comment_num] forState:UIControlStateNormal];
    [_buttonArr[2] setTitle:[NSString stringWithFormat:@"%ld", _teModel.zan_num] forState:UIControlStateNormal];
    
    [self setupAutoHeightWithBottomView:_buttomToolView bottomMargin:10];

}

#pragma mark - 底部按钮点击
- (void)buttonCLick:(UIButton *)sender {
    NSInteger tag = sender.tag - SCREEN_HEIGHT;
    if (tag == 2) {
        sender.selected = !sender.selected;
        NSInteger count = [sender.currentTitle integerValue];
        [sender setTitle:[NSString stringWithFormat:@"%ld",sender.selected ? count+1 : count-1] forState:UIControlStateNormal];
    }
}


- (void)moreButtonClicked {
}

- (NSMutableArray<UIButton *> *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _buttonArr;
}

@end
