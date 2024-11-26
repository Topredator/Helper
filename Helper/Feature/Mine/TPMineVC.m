//
//  TPMineVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPMineVC.h"

@interface TPMineVC ()
@property (nonatomic, strong) UIButton *logoutBtn;
@end

@implementation TPMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"Mine";
}
- (void)setupSubviews {
    [self.view addSubview:self.logoutBtn];
}
- (void)makeConstraints {
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-20);
    }];
}
- (void)logoutAction {
    [TPUserManager.manager setLogout];
}
#pragma mark----------------- Getter -----------------
- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[UIImage tp_imageWithColor:TPHelperThemeColor] forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _logoutBtn;
}
@end
