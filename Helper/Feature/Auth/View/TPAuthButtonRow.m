//
//  TPAuthButtonRow.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPAuthButtonRow.h"



@implementation TPAuthButtonCell
@synthesize button = _button;
- (void)setupSubviews {
    [self.contentView addSubview:self.button];
}
- (void)makeConstraints {
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(44);
    }];
}
#pragma mark----------------- Getter -----------------
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectZero];
        [_button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage tp_imageWithColor:TPHelperThemeColor] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage tp_imageWithColor:TPHelperDisabledColor]  forState:UIControlStateDisabled];
        _button.titleLabel.font = [UIFont systemFontOfSize:18];
        _button.layer.cornerRadius = 22.0;
        _button.layer.masksToBounds = YES;
    }
    return _button;
}
@end

@interface TPAuthButtonRow ()
@property (nonatomic, strong) RACSignal *enabledSignal;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;
@end

@implementation TPAuthButtonRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAuthButtonCell.class];
    }
    return self;
}
+ (instancetype)rowWithID:(id<NSCopying>)rowid title:(NSString *)title {
    TPAuthButtonRow *row = [self rowWithID:rowid ?: kTPAuthButtonKey];
    row.title = title;
    return row;
}
+ (instancetype)loginRowWithAccount:(RACSignal *)accountSignal password:(RACSignal *)pwdSignal {
    TPAuthButtonRow *row = [self rowWithID:kTPAuthLoginRowKey title:@"登录"];
    @weakify(row);
    row.enabledSignal = [RACSignal combineLatest:@[accountSignal, pwdSignal] reduce:^id (NSString *account, NSString* pwd){
        @strongify(row);
        return @([row validatePhoneNumber:account] && [row validatePassword:pwd]);
    }];
    return row;
}
+ (instancetype)registerRowWithAccount:(RACSignal *)accountSignal pwd:(RACSignal *)pwdSignal {
    TPAuthButtonRow *row = [self rowWithID:kTPAuthRegisterRowKey title:@"注册"];
    @weakify(row);
    row.enabledSignal = [RACSignal combineLatest:@[accountSignal, pwdSignal] reduce:^id (NSString *account, NSString* pwd){
        @strongify(row);
        return @([row validatePhoneNumber:account] && [row validatePassword:pwd]);
    }];
    return row;
}
+ (instancetype)changePwdRowWithAccount:(RACSignal *)acountSignal newPwd:(RACSignal *)newSignal surePwd:(RACSignal *)sureSignal {
    TPAuthButtonRow *row = [self rowWithID:kTPAuthRegisterRowKey title:@"设置新密码"];
    @weakify(row);
    row.enabledSignal = [RACSignal combineLatest:@[acountSignal, newSignal, sureSignal] reduce:^id (NSString *acount, NSString *newPwd, NSString *surePwd){
        @strongify(row);
        return @([row validatePhoneNumber:acount] && [row validatePassword:newPwd] && [row validatePassword:surePwd]);
    }];
    return row;
}
- (BOOL)validatePhoneNumber:(NSString *)number {
    return number.length >= 11;
}

- (BOOL)validatePassword:(NSString *)password {
    return password.length >= 6 && password.length <= 10;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    [self.cell.button setTitle:title forState:UIControlStateNormal];
}
- (void)setTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
    if (self.cell) {
        [self.cell.button removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        if (target && action) {
            [self.cell.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (!self.cellHeight) {
        return 80;
    }
    return [super tp_tableViewCellHeightWithProxy:proxy indexPath:indexPath];
}
- (void)tp_tableViewPreparedCell:(TPAuthButtonCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [self.cell.button setTitle:self.title forState:UIControlStateNormal];
    [self setTarget:self.target action:self.action];
    if (self.enabledSignal) {
        RAC(cell.button, enabled) = [self.enabledSignal takeUntil:[cell rac_prepareForReuseSignal]];
    }
}
@end
