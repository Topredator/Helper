//
//  TPSettingVC.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPSettingVC.h"
#import "TPCommonSection.h"
#import "TPSettingRow.h"
#import "TPSettingAccountAndSecurityVC.h"

@interface TPSettingVC ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) TPUISimButton *logoutBtn;
@end

@implementation TPSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"设置";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    self.tableview.tableFooterView = self.bottomView;
    [self.bottomView addSubview:self.logoutBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
}
- (void)loadData {
    TPCommonSection *section = [TPCommonSection section];
    section.h_height = 30;
    
    [section addObject:[self accountRow]];
    [section addObject:[self commonRow]];
    
    [self reloadData:@[section]];
}
- (TPSettingRow *)accountRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"账号与安全" image:@"setting_account"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPSettingAccountAndSecurityVC *vc = [TPSettingAccountAndSecurityVC new];
        [[TPUINavigator currentNavigationController] pushViewController:vc animated:YES];
    };
    return row;
}
- (TPSettingRow *)commonRow {
    TPSettingRow *row = [TPSettingRow rowWithName:@"通用设置" image:@"setting_common"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}


- (void)logoutAction {
    [TPUserManager.manager setLogout];
}
#pragma mark----------------- Getter -----------------
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 60)];
    }
    return _bottomView;
}
- (TPUISimButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _logoutBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _logoutBtn.iconTextMargin = 10;
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setImage:[UIImage imageNamed:@"setting_logout"] forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:TPHelperDarkGrayTextColor forState:UIControlStateNormal];
        _logoutBtn.layer.cornerRadius = 10;
        _logoutBtn.layer.masksToBounds = YES;
        [_logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}
@end
