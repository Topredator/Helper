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


@interface TPSettingAccountAndSecurityVC ()

@end

@implementation TPSettingAccountAndSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"账号与安全";
    [self loadData];
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
    [self reloadData:@[section]];
}
- (TPSettingRow *)passwordRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"登录密码" image:@"setting_account_password"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPSettingRow *)authenticationRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"实名认证" image:@"setting_account_authentication" des:TPUserManager.manager.user.idCard.length ? @"已实名" : @"未实名" arrow:YES];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPSettingSwitchRow *)autoLoginRow {
    TPSettingSwitchRow *row = [TPSettingSwitchRow rowWithName:@"自动登录" image:@"setting_account_auto_login" status:YES];
    row.callback = ^(BOOL isOn) {
        
    };
    return row;
}
@end
