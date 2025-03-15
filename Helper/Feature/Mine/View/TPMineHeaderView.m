//
//  TPMineHeaderView.m
//  Helper
//
//  Created by Topredator on 2024/12/19.
//

#import "TPMineHeaderView.h"
#import "TPUserManager.h"
#import "TPSettingVC.h"

@interface TPMineHeaderView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIImageView *levelImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *settingBtn;
@end

@implementation TPMineHeaderView
- (void)setupSubviews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.avatarImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.levelImage];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.settingBtn];
    [self updateInfo];
}
- (void)makeConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(TPUI.tp_statusBarHeight + 10);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-20);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.avatarImage.mas_bottom).offset(15);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.centerX.mas_equalTo(15);
    }];
    [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self.phoneLabel.mas_centerY);
        make.right.equalTo(self.phoneLabel.mas_left).offset(-15);
    }];
}
- (void)updateInfo {
    self.levelImage.image = [self roleIcon];
    self.avatarImage.image = [UIImage imageNamed:TPUserManager.manager.user.avatar];
    self.nameLabel.text = TPUserManager.manager.user.name;
    self.phoneLabel.text = TPUserManager.manager.user.account;
}
- (UIImage *)roleIcon {
    NSString *imageName = @"role_customer";
    switch (TPUserManager.manager.user.userType) {
        case TPUserTypeSuperManager: imageName = @"role_super"; break;
        case TPUserTypeManager: imageName = @"role_manager"; break;
        default: imageName = @"role_customer"; break;
    }
    return [UIImage imageNamed:imageName];
}
- (void)settingBtnAction {
    TPSettingVC *settingVC = [TPSettingVC new];
    [[TPUINavigator currentNavigationController] pushViewController:settingVC animated:YES];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg_image"]];
    }
    return _bgImageView;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_avatar"]];
        _avatarImage.layer.cornerRadius = 50;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UIImageView *)levelImage {
    if (!_levelImage) {
        _levelImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _levelImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.font = [TPUI tp_font:15 weight:FontMedium];
        _phoneLabel.textColor = [TPUI tp_r:39 g:119 b:248];
    }
    return _phoneLabel;
}
- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    }
    return _settingBtn;
}
@end
