//
//  THSelectAddressView.m
//  THYG
//
//  Created by Mac on 2018/5/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSelectAddressView.h"
#import "THAddressModel.h"

@interface THSelectAddressView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSArray *provinceList;
@property (nonatomic,strong) NSArray *cityList;
@property (nonatomic,strong) NSArray *districtList;
@property (nonatomic,assign) NSInteger currentProvinceIndex;
@property (nonatomic,assign) NSInteger currentCityIndex;
@property (nonatomic,assign) NSInteger currentDistrictIndex;
@property (nonatomic,strong) THAddressPCDModel *provinceSelModel;
@property (nonatomic,strong) THAddressPCDModel *citySelModel;
@property (nonatomic,strong) THAddressPCDModel *districtSelModel;
@property (nonatomic,strong) UIControl *bgView;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIView *optionView;
@property (nonatomic,copy) void(^getDataBlock)(void);

@end

@implementation THSelectAddressView

- (instancetype)init {
    self = [super init];
    if (self) {
        [([UIApplication sharedApplication].delegate).window addSubview:self.bgView];
        [([UIApplication sharedApplication].delegate).window addSubview:self.pickerView];
        [([UIApplication sharedApplication].delegate).window addSubview:self.optionView];
    }
    return self;
}

#pragma mark -- 加载省市区数据
- (void)initDataWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId {
    
    [THNetworkTool POST:API(@"/Address/getAddressList") parameters:@{@"token":TOKEN} completion:^(id responseObject, NSDictionary *allResponseObject) {
        
        self.provinceList = [THAddressPCDModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        NSMutableArray *mut = self.provinceList.mutableCopy;
        for (NSInteger i = 0; i<mut.count; i++) {
            THAddressPCDModel *m = mut[i];
            if (!m.cityList.count) {
                //空的市 区
                THAddressPCDModel *model = [[THAddressPCDModel alloc]init];
                model.name = @"";
                model.iD = 0;
                m.cityList = @[model];
                model.districtList = @[model];
                
            }else{
                for (THAddressPCDModel *subModel in m.cityList) {
                    if (!subModel.districtList.count) {
                        THAddressPCDModel *model = [[THAddressPCDModel alloc]init];
                        model.name = @"";
                        model.iD = 0;
                        subModel.districtList = @[model];
                    }
                }
            }
        }
        self.provinceList = mut;
        [self setValueWithProvinceId:provinceId cityId:cityId districtId:districtId];
        
    }];
}

- (void)setValueWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId
{
    for (NSInteger i = 0; i < self.provinceList.count; i++) {
        if ([self.provinceList[i] iD] == provinceId) {
            self.currentProvinceIndex = i;
            for (NSInteger j = 0; j<[[self.provinceList[i] cityList]count]; j++) {
                if ([[self.provinceList[i] cityList][j] iD] == cityId) {
                    self.currentCityIndex = j;
                    for (NSInteger k = 0; k<[[[self.provinceList[i] cityList][j] districtList] count]?[[[self.provinceList[i] cityList][j] districtList] count]:0; k++) {
                        if ([[[self.provinceList[i] cityList][j] districtList][k] iD] == districtId) {
                            self.currentDistrictIndex = k;
                            [self setDefaultValue];
                            return;
                        }
                    }
                }
            }
        }
    }
}

- (void)setDefaultValue
{
    self.cityList = [self.provinceList[self.currentProvinceIndex] cityList];
    self.districtList = [self.cityList[self.currentCityIndex] districtList];
    
    self.provinceSelModel = self.provinceList.count ? self.provinceList[self.currentProvinceIndex] : nil;
    self.citySelModel     = self.cityList.count ? self.cityList[self.currentCityIndex] : nil;
    self.districtSelModel = self.districtList.count ? self.districtList[self.currentDistrictIndex] : nil;
    
    [self.pickerView selectRow:self.currentProvinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:self.currentCityIndex inComponent:1 animated:YES];
    [self.pickerView selectRow:self.currentDistrictIndex inComponent:2 animated:YES];
    
    [self.pickerView reloadComponent:0];
    [self.pickerView reloadComponent:1];
    [self.pickerView reloadComponent:2];
}

/*
 展示视图
 */
- (void)show:(getSelectData)getSelectModel {
    WEAKSELF;
    self.getDataBlock = ^() {
        if (!weakSelf.provinceSelModel && !weakSelf.citySelModel && !weakSelf.districtSelModel) {
            [THHUD showMsg:@"正在加载数据~"];
        }else{
            getSelectModel(weakSelf.provinceSelModel, weakSelf.citySelModel, weakSelf.districtSelModel);
        }
        
    };
    self.bgView.y = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.y = SCREEN_HEIGHT - 180;
        self.optionView.y = SCREEN_HEIGHT - 180 - 40.5;
    }];
    
    [self setDefaultValue];
}

/*
 隐藏视图
 */
- (void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.y = SCREEN_HEIGHT;
        self.optionView.y = SCREEN_HEIGHT;
    }];
    self.bgView.y = SCREEN_HEIGHT;
}

- (void)confirmSelectAction
{
    [self hidden];
    if (self.getDataBlock) {
        self.getDataBlock();
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return self.provinceList.count;
    }
    else if(component == 1)
    {
        return self.cityList.count;
    }
    else if(component == 2)
    {
        return self.districtList.count;
    }
    return 0;
}

//选择的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        self.currentProvinceIndex = row;
        self.currentCityIndex     = 0;
        self.currentDistrictIndex = 0;
        
        self.cityList = [self.provinceList[row] cityList];
        self.districtList = [self.cityList[self.currentCityIndex] districtList];
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:self.currentCityIndex inComponent:1 animated:YES];
        [pickerView selectRow:self.currentDistrictIndex inComponent:2 animated:YES];
        
        
        self.provinceSelModel = self.provinceList.count ? self.provinceList[self.currentProvinceIndex] : nil;
        self.citySelModel     = self.cityList.count ? self.cityList[self.currentCityIndex] : nil;
        self.districtSelModel = self.districtList.count ? self.districtList[self.currentDistrictIndex] : nil;
        
    }
    else if(component == 1)
    {
        self.currentCityIndex = row;
        
        self.currentDistrictIndex = 0;
        
        self.districtList = [self.cityList[row] districtList];
        
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:self.currentDistrictIndex inComponent:2 animated:YES];
        
        
        self.citySelModel     = self.cityList.count ? self.cityList[self.currentCityIndex] : nil;
        self.districtSelModel = self.districtList.count ? self.districtList[self.currentDistrictIndex] : nil;
        
    }
    else if(component == 2)
    {
        self.currentDistrictIndex = row;
        
        self.districtSelModel = self.districtList.count ? self.districtList[self.currentDistrictIndex] : nil;
    }
    
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 45.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = RGB(229, 229, 229);
    
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = RGB(229, 229, 229);
    
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, 44);
    title.font = Font(18);
    title.textColor = RGB(51, 51, 51);
    title.textAlignment = NSTextAlignmentCenter;
    
    if(component == 0)
    {
        title.text = [self.provinceList[row]name];
    }
    else if(component == 1)
    {
        title.text = [self.cityList[row]name];
    }
    else if(component == 2)
    {
        title.text = [self.districtList[row]name];
    }
    
    return title;
}

- (UIPickerView*)pickerView
{
    if (_pickerView==nil) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIControl*)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIControl alloc]init];
        _bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_bgView addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

- (UIView*)optionView
{
    if (_optionView==nil) {
        _optionView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40)];
        _optionView.backgroundColor = [UIColor whiteColor];
        UIButton* confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = Font(15);
        confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 40, 40);
        [confirmBtn addTarget:self action:@selector(confirmSelectAction) forControlEvents:UIControlEventTouchUpInside];
        [_optionView addSubview:confirmBtn];
    }
    return _optionView;
}

@end
