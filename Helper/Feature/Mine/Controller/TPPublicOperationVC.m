//
//  TPPublicOperationVC.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPPublicOperationVC.h"
#import "TPReleaseDiaryVC.h"
#import "TPReleaseAdoptVC.h"

@interface TPPublicOperationVC ()
/// 日记
@property (nonatomic, strong) UIButton *dailyBtn;
/// 平台信息 （公告）
@property (nonatomic, strong) UIButton *platformBtn;
/// 领养
@property (nonatomic, strong) UIButton *adoptBtn;
@end

@implementation TPPublicOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"发布选择";
}

- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.dailyBtn];
    [self.view addSubview:self.adoptBtn];
    [self.view addSubview:self.platformBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.adoptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(70);
        make.centerY.mas_equalTo(TPUI.tp_topBarHeight / 2);
    }];
    [self.dailyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(70);
        make.bottom.equalTo(self.adoptBtn.mas_top).offset(-60);
    }];
    [self.platformBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(70);
        make.top.equalTo(self.adoptBtn.mas_bottom).offset(60);
    }];
}
- (void)dailyBtnAction {
    TPReleaseDiaryVC *dailyVC = [TPReleaseDiaryVC new];
    [self.navigationController pushViewController:dailyVC animated:YES];
}
- (void)adoptBtnAction {
    TPReleaseAdoptVC *adoptVC = [TPReleaseAdoptVC new];
    [self.navigationController pushViewController:adoptVC animated:YES];
}
- (void)platformBtnAction {}
#pragma mark----------------- Getter -----------------
- (UIButton *)dailyBtn {
    if (!_dailyBtn) {
        _dailyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dailyBtn setTitle:@"生活日记" forState:UIControlStateNormal];
        [_dailyBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_dailyBtn addTarget:self action:@selector(dailyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _dailyBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _dailyBtn.layer.borderWidth = 0.8;
        _dailyBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        _dailyBtn.layer.cornerRadius = 5;
        _dailyBtn.layer.masksToBounds = YES;
    }
    return _dailyBtn;
}
- (UIButton *)adoptBtn {
    if (!_adoptBtn) {
        _adoptBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_adoptBtn setTitle:@"领养信息" forState:UIControlStateNormal];
        [_adoptBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_adoptBtn addTarget:self action:@selector(adoptBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _adoptBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _adoptBtn.layer.borderWidth = 0.8;
        _adoptBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        _adoptBtn.layer.cornerRadius = 5;
        _adoptBtn.layer.masksToBounds = YES;
    }
    return _adoptBtn;
}
- (UIButton *)platformBtn {
    if (!_platformBtn) {
        _platformBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_platformBtn setTitle:@"公告信息" forState:UIControlStateNormal];
        [_platformBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_platformBtn addTarget:self action:@selector(platformBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _platformBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _platformBtn.layer.borderWidth = 0.8;
        _platformBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        _platformBtn.layer.cornerRadius = 5;
        _platformBtn.layer.masksToBounds = YES;
    }
    return _platformBtn;
}
@end
