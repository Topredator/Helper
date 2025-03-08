//
//  TPAddressSwitchRow.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressSwitchRow.h"

@interface TPAddressSwitchCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *switchBtn;
@end
@implementation TPAddressSwitchCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.switchBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _titleLabel.textColor = [TPUI tp_t:105];
    }
    return _titleLabel;
}
- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    return _switchBtn;
}
@end

@interface TPAddressSwitchRow ()
@property (nonatomic, copy) NSString *title;
@end

@implementation TPAddressSwitchRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAddressSwitchCell.class];
    }
    return self;
}
+ (instancetype)rowWithTitle:(NSString *)title {
    TPAddressSwitchRow *row = [TPAddressSwitchRow rowWithID:kTPAddressSwitchKey];
    row.title = title;
    return row;
}
- (void)switchBtnAction {
    self.on = self.cell.switchBtn.isOn;
}
- (void)setOn:(BOOL)on {
    _on = on;
    if (self.cell.switchBtn.on != on) {
        self.cell.switchBtn.on = on;
    }
}
- (void)tp_tableViewPreparedCell:(TPAddressSwitchCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.switchBtn.on = self.isOn;
    cell.titleLabel.text = self.title;
    [cell.switchBtn addTarget:self action:@selector(switchBtnAction) forControlEvents:UIControlEventValueChanged];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
@end
