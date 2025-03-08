//
//  TPAddressVC.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressVC.h"
#import "TPAddressModule.h"
#import "TPCommonSection.h"
#import "TPAddressTFRow.h"
#import "TPAddressTVRow.h"
#import "TPAddressSwitchRow.h"
@interface TPAddressVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) TPAddressModel *model;
@end

@implementation TPAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"地址信息";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.navigationView addSubview:self.saveBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
    }];
}
- (void)loadData {
    [self.section addObject:[self nameRow]];
    [self.section addObject:[self phoneRow]];
    [self.section addObject:[self switchRow]];
    [self.section addObject:[self addressRow]];
    [self reloadData:@[self.section]];
}

- (TPAddressTFRow *)nameRow {
    TPAddressTFRow *nameRow = [TPAddressTFRow nameTitle:@"收货人:"];
    nameRow.text = self.addressModel.name;
    return nameRow;
}
- (TPAddressTFRow *)phoneRow {
    TPAddressTFRow *phoneRow = [TPAddressTFRow phoneTitle:@"联系方式:"];
    phoneRow.isNumericKeyboard = YES;
    phoneRow.text = self.addressModel.phone;
    return phoneRow;
}
- (TPAddressTVRow *)addressRow {
    TPAddressTVRow *row = [TPAddressTVRow rowWithTitle:@"具体地址:"];
    row.text = self.addressModel.detailAddress;
    return row;
}
- (TPAddressSwitchRow *)switchRow {
    TPAddressSwitchRow *row = [TPAddressSwitchRow rowWithTitle:@"默认地址: "];
    row.on = self.addressModel.isDefault;
    return row;
}
- (void)saveBtnAction {
    NSString *name = [(TPAddressTFRow *)self.section[kTPAddressNameKey] text];
    NSString *phone = [(TPAddressTFRow *)self.section[kTPAddressPhoneKey] text];
    BOOL isDefault = [(TPAddressSwitchRow *)self.section[kTPAddressSwitchKey] isOn];
    NSString *address = [(TPAddressTVRow *)self.section[kTPAddressTVKey] text];
    
    if (!self.addressModel) {
        if (!name || !phone || !address) {
            [self.view tp_toast:@"请填写完整信息" duration:1.5];
            return;
        }
        TPAddressModel *model = [TPAddressModel generateModel];
        model.name = name;
        model.phone = phone;
        model.detailAddress = address;
        model.isDefault = isDefault;
        [self.view tp_showLoading];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [TPDBRouter sendTaskMessage:TPAddressAddNewUserAddress argument:[model tp_modelToJSONObject]];
        });
    } else {
        self.addressModel.name = name;
        self.addressModel.phone = phone;
        self.addressModel.detailAddress = address;
        self.addressModel.isDefault = isDefault;
        [self.view tp_showLoading];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [TPDBRouter sendTaskMessage:TPAddressEditUserAddress argument:[self.addressModel tp_modelToJSONObject]];
        });
    }
    
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPAddressAddNewUserAddress) { // 新增地址
        [self.view tp_hideLoading];
        [TPAppDelegate().window tp_toast:@"创建地址成功" duration:1.5];
        [TPUINavigator popViewControllerWithTimes:1 animated:YES];
    } else if (messageType == TPAddressEditUserAddress) { // 编辑地址
        [self.view tp_hideLoading];
        [TPAppDelegate().window tp_toast:@"地址编辑成功" duration:1.5];
        [TPUINavigator popViewControllerWithTimes:1 animated:YES];
    }
    return NO;
}
#pragma mark ==================  Getter   ==================
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [TPUI tp_font:17 weight:FontMedium];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
@end
