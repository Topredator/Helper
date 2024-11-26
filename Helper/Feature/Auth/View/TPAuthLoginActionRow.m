//
//  TPAuthLoginActionRow.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPAuthLoginActionRow.h"

@implementation TPAuthLoginActionCell
- (void)setupSubviews {
    [self.contentView addSubview:self.registerBtn];
    [self.contentView addSubview:self.forgotPasswordBtn];
}
- (void)makeConstraints {
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
    [self.forgotPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(90);
    }];
}
#pragma mark----------------- Getter -----------------
- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.titleLabel.font = [TPUI tp_font:15 weight:FontMedium];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:TPHelperDarkGrayTextColor forState:UIControlStateNormal];
        [_registerBtn setTitleColor:TPHelperDarkTextColor forState:UIControlStateHighlighted];
    }
    return _registerBtn;
}

- (UIButton *)forgotPasswordBtn {
    if (!_forgotPasswordBtn) {
        _forgotPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgotPasswordBtn.titleLabel.font = [TPUI tp_font:15 weight:FontMedium];
        [_forgotPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotPasswordBtn setTitleColor:TPHelperDarkGrayTextColor forState:UIControlStateNormal];
        [_forgotPasswordBtn setTitleColor:TPHelperDarkTextColor forState:UIControlStateHighlighted];
    }
    return _forgotPasswordBtn;
}
@end

@interface TPAuthLoginActionRow ()
@property (nonatomic, weak) id target;
@property (nonatomic) SEL registerAction;
@property (nonatomic) SEL forgotPwdAction;
@end

@implementation TPAuthLoginActionRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAuthLoginActionCell.class];
    }
    return self;
}
+ (instancetype)rowWithTarget:(id)target registerAction:(SEL)registerAction forgotPwdAction:(SEL)forgotAction {
    TPAuthLoginActionRow *row = [TPAuthLoginActionRow row];
    row.target = target;
    row.registerAction = registerAction;
    row.forgotPwdAction = forgotAction;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAuthLoginActionCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell.registerBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [cell.forgotPasswordBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    if (self.target && self.registerAction) {
        [cell.registerBtn addTarget:self.target action:self.registerAction forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.target && self.forgotPwdAction) {
        [cell.forgotPasswordBtn addTarget:self.target action:self.forgotPwdAction forControlEvents:UIControlEventTouchUpInside];
    }
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end

