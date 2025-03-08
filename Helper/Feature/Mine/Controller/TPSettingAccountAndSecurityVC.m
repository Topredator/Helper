//
//  TPSettingAccountAndSecurityVC.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPSettingAccountAndSecurityVC.h"
#import "TPCommonSection.h"
#import "TPSettingRow.h"
#import "TPSettingSwitchRow.h"
#import "TPAddressModule.h"
#import "TPAddressListVC.h"
@interface TPSettingAccountAndSecurityVC ()
@property (nonatomic, assign) BOOL isAddress;
@end

@implementation TPSettingAccountAndSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"账号与安全";
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [TPDBRouter sendTaskMessage:TPAddressFetchUserInfo argument:TPUserManager.manager.user.userId];
}
- (void)loadData {
    TPCommonSection *section = [TPCommonSection section];
    // 手机号
    [section addObject:[TPSettingRow rowWithName:@"手机号" image:@"setting_account_phone" des:TPUserManager.manager.user.account arrow:NO]];
    // 登录密码
    [section addObject:[self passwordRow]];
    // 实名认证
    [section addObject:[self authenticationRow]];
    // 自动登录
    [section addObject:[self autoLoginRow]];
    // 地址
    [section addObject:[self addressRow]];
    [self reloadData:@[section]];
}
- (TPSettingRow *)passwordRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"登录密码" image:@"setting_account_password" des:TPUserManager.manager.user.password arrow:NO];
    return row;
}
- (TPSettingRow *)authenticationRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"实名认证" image:@"setting_account_authentication" des:TPUserManager.manager.user.idCard.length ? @"已实名" : @"未实名" arrow:YES];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPSettingSwitchRow *)autoLoginRow {
    TPSettingSwitchRow *row = [TPSettingSwitchRow rowWithName:@"自动登录" image:@"setting_account_auto_login" status:[TPCommonUD UDBoolKey:kTPHelperAutoLoginKey]];
    row.callback = ^(BOOL isOn) {
        [TPCommonUD UDBool:isOn key:kTPHelperAutoLoginKey];
    };
    return row;
}
- (TPSettingRow *)addressRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"地址" image:@"setting_account_address" des:self.isAddress ? @"已设置" : @"未设置" arrow:YES];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPAddressListVC *addressVC = [TPAddressListVC new];
        [TPUINavigator pushViewController:addressVC animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPAddressFetchUserInfo) {
        NSArray *addresses = (NSArray *)argument;
        self.isAddress = addresses.count > 0;
        [self loadData];
        return YES;
    }
    return NO;
}
@end
