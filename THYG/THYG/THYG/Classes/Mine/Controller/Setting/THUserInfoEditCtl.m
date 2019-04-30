//
//  THUserInfoEditCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserInfoEditCtl.h"
#import "THUploadImageTool.h"
#import "THSelectTimeView.h"
#import "THSelectedCategoryView.h"

@interface THUserInfoEditCtl () <THUploadImageToolDelegate, THSelectTimeViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UITextField *professionalField; // 职业
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (nonatomic, strong) THSelectTimeView *timeView;
@property (nonatomic, strong) THSelectedCategoryView *categoryView;
@property (assign, nonatomic) BOOL isSelectedSex;
@property (nonatomic, copy) NSMutableDictionary *params;

@end

@implementation THUserInfoEditCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nickNameLabel.delegate = self.professionalField.delegate = self;
    self.nickNameLabel.text = UserInfo.nickname;
    
    [self.sexBtn setTitle:(UserInfo.sex == 2)?@"女":(UserInfo.sex == 1)? @"男":@"男/女" forState:UIControlStateNormal];
    
    if (UserInfo.birthday.length > 7) {
        [self.yearBtn setTitle:[UserInfo.birthday substringToIndex:4] forState:UIControlStateNormal];
        [self.monthBtn setTitle:[UserInfo.birthday substringWithRange:NSMakeRange(4, 2)] forState:UIControlStateNormal];
        [self.dayBtn setTitle:[UserInfo.birthday substringFromIndex:UserInfo.birthday.length-2] forState:UIControlStateNormal];
    }
    
    self.professionalField.text = UserInfo.job;
    [self.categoryBtn setTitle:UserInfo.favorite_cat forState:UIControlStateNormal];
    
    WEAKSELF;
    self.timeView.selectedTimeBlock = ^(NSString *year, NSString *month, NSString *day) {
        [weakSelf.yearBtn setTitle:year forState:UIControlStateNormal];
        [weakSelf.monthBtn setTitle:month forState:UIControlStateNormal];
        [weakSelf.dayBtn setTitle:day forState:UIControlStateNormal];
        NSString *time = [[[year substringToIndex:year.length-1] stringByAppendingString:[month substringToIndex:month.length-1]] stringByAppendingString:[day substringToIndex:day.length-1]];
        weakSelf.params[@"birthday"] = @([time integerValue]);
    };
    
    self.categoryView.selectedItemBlock = ^(NSString *category) {
        if (weakSelf.isSelectedSex) {
            [weakSelf.sexBtn setTitle:category forState:UIControlStateNormal];
            weakSelf.params[@"sex"] = [category isEqualToString:@"男"] ? @"1" : @"2";
        } else {
            [weakSelf.categoryBtn setTitle:category forState:UIControlStateNormal];
            weakSelf.params[@"favorite_cat"] = category;
        }
    };
    
    [self getCategory];
    [self getUserInfo];
    
    [self.sexBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self.yearBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:15];
    [self.monthBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:15];
    [self.dayBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:15];
    [self.categoryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
}

#pragma mark -- 获取用户基本信息
- (void)getUserInfo
{
    [THNetworkTool GET:API(@"/PersonalCenter/personal") parameters:@{@"token":TOKEN} success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 获取分类
- (void)getCategory {
    [THNetworkTool POST:API(@"/Goods/getGoodsCategory") parameters:nil completion:^(id responseObject, NSDictionary *allResponseObject) {
        NSArray *categoryData = responseObject[@"info"];
        if (categoryData.count) {
            for (NSDictionary *dict in categoryData) {
                [self.dataSourceArray addObject:dict[@"mobile_name"]];
            }
        }
    }];
}

#pragma mark - 上传头像
- (IBAction)uploadImage:(id)sender {
    [UPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
}

#pragma mark - 选择性别
- (IBAction)sexBtnClick:(id)sender {
    _isSelectedSex = YES;
    self.categoryView.dataArray = @[@"男",@"女"];
    [self.categoryView show];
}

#pragma mark - 选择时间
- (IBAction)timeClick:(id)sender {
    [self.timeView show];
}

#pragma mark - 选择分类
- (IBAction)categoryBtnClick:(id)sender {
    _isSelectedSex = NO;
    self.categoryView.dataArray = self.dataSourceArray;
    [self.categoryView show];
}

#pragma mark - 确认修改
- (IBAction)okClick {
    [THNetworkTool POST:API(@"/User/updateUserInfo") parameters:self.params completion:^(id responseObject, NSDictionary *allResponseObject) {
        if (responseObject) {
            [THHUD showSuccess:@"修改成功"];
        }
        NSLog(@"responseObject %@", responseObject);
    }];
}

- (void)dismiss {
    [self.timeView removeFromSuperview];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.nickNameLabel == textField) {
        _params[@"nickname"] = textField.text;
    } else {
        _params[@"job"] = textField.text;
    }
    return YES;
}

#pragma mark - THUploadImageToolDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    // 上传头像
    self.avatarImgView.image = image;
    
    [THNetworkTool uploadImagesWithURL:API(@"/User/upload_headpic") parameters:@{@"token":TOKEN} name:@"head_pic" images:@[image] fileNames:nil imageScale:0.001 imageType:@"png" progress:nil success:^(id responseObject) {
        // NSLog(@"responseObject%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            [THHUD showSuccess:@"修改成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USERINFO_NOTIFICATION object:nil];
            [self popVC];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
}

#pragma mark - 懒加载
- (THSelectTimeView *)timeView {
    if (!_timeView) {
        _timeView = [THSelectTimeView sharedInstance];
        _timeView.delegate = self;
    }
    return _timeView;
}

- (THSelectedCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [THSelectedCategoryView sharedInstance];
    }
    return _categoryView;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:0];
        _params[@"token"] = TOKEN;
    }
    return _params;
}

@end
