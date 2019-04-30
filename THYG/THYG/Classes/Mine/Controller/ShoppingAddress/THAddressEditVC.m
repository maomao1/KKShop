//
//  THAddressEditVC.m
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressEditVC.h"
#import "THAddressModel.h"
#import "THAddAddressCell.h"
#import "ReactiveCocoa.h"
#import "THSelectAddressView.h"

@interface THAddressEditVC () {
    UIButton*_saveBtn;
    NSArray *_titleData;
    NSArray *_typeData;
    NSArray *_placeholdData;
    NSArray *_valueData;
}

@property (nonatomic, strong) THSelectAddressView *selectAddressView;
@property (nonatomic, strong) THAddressModel *valueModel;
@property (nonatomic, strong) THAddressPCDModel *provinceSelModel;
@property (nonatomic, strong) THAddressPCDModel *citySelModel;
@property (nonatomic, strong) THAddressPCDModel *districtSelModel;
@property (nonatomic, strong) UIButton *footerBtn;

@end

@implementation THAddressEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
//    [self getAddressList];
}

- (void)setupUI {
    self.title = @"收货地址";
    self.isGrouped = YES;
    self.dataTableView.height = SCREEN_HEIGHT-kNaviHeight-44;
    [self.view addSubview:self.dataTableView];
    [self.view addSubview:self.footerBtn];
    if (kDevice_Is_iPhoneX) {
        self.dataTableView.height -= kiPhoneX_bottom_height;
    }
    [self.dataTableView registerClass:CLASS(@"THAddAddressCell") forCellReuseIdentifier:STRING(THAddAddressCell)];
    
    [self.selectAddressView initDataWithProvinceId:[self.modelData.province integerValue] cityId:[self.modelData.city integerValue] districtId:[self.modelData.district integerValue]];
    
}

- (void)initData {
    _titleData = @[@"收货人",@"手机号码",@"选择地区",@"详细地址"];
    _typeData = @[@"1",@"1",@"2",@"1"];
    _placeholdData =  @[@"请输入收货人姓名",@"请输入手机号码",@"请选择地区",@"请输入详细地址"];
    self.optiontype == newOption ? nil : (_valueData = @[self.modelData.consignee, self.modelData.mobile, [NSString stringWithFormat:@"%@ %@ %@", self.modelData.province_str, self.modelData.city_str, self.modelData.district_str], self.modelData.address]);
    self.optiontype == newOption ? nil : (self.valueModel = self.modelData);

    NSInteger index = 0;
    for (NSString*string in _titleData) {
        THAddressModel *model = [[THAddressModel alloc]init];
        model.title = string;
        model.type = [_typeData[index] integerValue];
        model.placehold = _placeholdData[index];
        model.text = _valueData[index];
        [self.dataSourceArray addObject:model];
        index++;
    }
    [self.dataTableView reloadData];
    
    [self checkParmaMethod];
}

#pragma mark - 获取
//- (void)getAddressList {
//    [THNetworkTool POST:API(@"/Address/getAddressList") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
////        self.dataSourceArray = [THAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
////        [self.dataTableView reloadData];
//    }];
//}


- (void)checkParmaMethod {
    //收件人
    RACSignal *nameSingnal = [[self getTextField:0].rac_textSignal map:^id(NSString *text) {
        return @([[self getTextField:0].text length]>0);
    }];
    
    //手机号码
    RACSignal *phoneSingnal = [[self getTextField:1].rac_textSignal map:^id(NSString *text) {
        return @(([self getTextField:1].text.length == 11) && [Utils CheckPhoneNum:[self getTextField:1].text]);
    }];
    
    //详细地址
    RACSignal *addressSingal = [[self getTextField:3].rac_textSignal map:^id(NSString *text) {
        return @([[self getTextField:3].text length]>0);
    }];
    
    RACSignal *checkSingal = [RACSignal combineLatest:@[nameSingnal, phoneSingnal, addressSingal] reduce:^id(NSNumber*nameSingnal, NSNumber *phoneSingnal, NSNumber *addressSingal){
        return @([nameSingnal boolValue] && [phoneSingnal boolValue] && [addressSingal boolValue]);
    }];
    
    RAC(_saveBtn, backgroundColor) = [checkSingal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] && [[self getTextField:2].text length] ? RED_COLOR:[RED_COLOR colorWithAlphaComponent:0.5];
    }];
    
    [checkSingal subscribeNext:^(NSNumber*signalActive){
        _saveBtn.enabled = [signalActive boolValue] && [[self getTextField:2].text length];
    }];
    
}

- (NSString*)getValue:(NSInteger)row {
    return ((THAddAddressCell*)[self.dataTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField.text.length ? ((THAddAddressCell*)[self.dataTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField.text : @"";
}

- (UITextField*)getTextField:(NSInteger)row {
    return ((THAddAddressCell*)[self.dataTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return MinFloat;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:STRING(THAddAddressCell)];
    cell.modelData = self.dataSourceArray[indexPath.row];
    cell.textField.tag = indexPath.row;
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    switch (indexPath.row) {
        case 0:
            cell.textField.text = self.valueModel.consignee;
            break;
        case 1:
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.text = self.valueModel.mobile;
            break;
        case 3:
            cell.textField.text = self.valueModel.address;
        default:
            break;
    }
    cell.getInsertValue = ^(NSString *value) {
        
        switch (indexPath.row) {
            case 0:
                self.valueModel.consignee = value;
                break;
            case 1:
                self.valueModel.mobile = value;
                break;
            case 3:
                self.valueModel.address = value;
            default:
                break;
        }
        
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectAddressView show:^(THAddressPCDModel *provinceModel, THAddressPCDModel *cityModel, THAddressPCDModel *districtModel) {
        
        weakSelf.provinceSelModel = provinceModel;
        weakSelf.citySelModel = cityModel;
        weakSelf.districtSelModel = districtModel;

        THAddressPCDModel *model = weakSelf.dataSourceArray[2];
        model.text = [NSString stringWithFormat:@"%@ %@ %@",provinceModel.name,cityModel.name,districtModel.name];
        [weakSelf.dataTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];
}


#pragma mark - 保存并使用
- (void)saveAndUseClick {
    NSString *address = [NSString stringWithFormat:@"%@%@%@", self.modelData.province_str, self.modelData.city_str, self.modelData.district_str];
    if ([self getTextField:3].text.length < address.length) {
        address = [self getTextField:3].text;
    } else {
        address = [[self getTextField:3].text substringFromIndex:address.length-1];
    }
    
    
    [THNetworkTool POST:API(@"/Address/post")
             parameters:@{@"token":TOKEN,
                          @"consignee":[self getTextField:0].text,//性别 0=保密 1=男 2=女
                          @"province":@(self.provinceSelModel.iD?:[self.modelData.province integerValue]),//省份id
                          @"city":@(self.citySelModel.iD?:[self.modelData.city integerValue]),//城市id
                          @"district":@(self.districtSelModel.iD?:[self.modelData.district integerValue]),//区县id
                          @"address":address,//具体地址
                          @"mobile":[self getTextField:1].text,//手机号
                          @"address_id":self.optiontype==editOption?self.modelData.address_id:@""//地址id，添加时传可不传，修改时传
                          }
             completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [THHUD showSuccess:@"添加成功"];
            if (self.optionSuccessBlock) {
                self.optionSuccessBlock();
            }
            [self popVC];
            
        });
    }];
}

#pragma mark - 懒加载
- (UIButton *)footerBtn {
    if (!_footerBtn) {
        _footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footerBtn setBackgroundColor:RED_COLOR];
        _footerBtn.frame = CGRectMake(0, SCREEN_HEIGHT-kNaviHeight-40, SCREEN_WIDTH, 40);
        if (kDevice_Is_iPhoneX) {
            _footerBtn.y -= kiPhoneX_bottom_height;
        }
        [_footerBtn setTitle:@"保存并使用" forState:UIControlStateNormal];
        _footerBtn.titleLabel.font = Font15;
        [_footerBtn addTarget:self action:@selector(saveAndUseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerBtn;
}

- (THSelectAddressView*)selectAddressView {
    if (_selectAddressView==nil) {
        _selectAddressView = [[THSelectAddressView alloc] init];
    }
    return _selectAddressView;
}


@end
