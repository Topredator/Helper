//
//  TPSettingSwitchRow.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPSettingSwitchRow.h"


@interface TPSettingSwitchCell ()
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UISwitch *switchBtn;
@property (nonatomic, strong) UIView *line;
@end

@implementation TPSettingSwitchCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.switchBtn];
    [self.container addSubview:self.line];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerY.mas_equalTo(0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.8);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)prepareCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    self.line.hidden = (rowCount == 1 || (rowCount > 1 && indexPath.row == rowCount - 1));
    [super prepareCellForTableView:tableView atIndexPath:indexPath];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [TPUI tp_t:105];
    }
    return _nameLabel;
}
- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    return _switchBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [TPUI tp_hexStringColor:@"#E6E6E6"];
    }
    return _line;
}
@end

@interface TPSettingSwitchRow ()
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@end

@implementation TPSettingSwitchRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPSettingSwitchCell.class];
    }
    return self;
}
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image status:(BOOL)status {
    TPSettingSwitchRow *row = [TPSettingSwitchRow row];
    row.status = status;
    row.name = name;
    row.image = image;
    return row;
}
- (void)switchBtnAction {
    if (self.cell) {
        if (self.callback) {
            self.callback(self.cell.switchBtn.isOn);
        }
    }
}
- (void)tp_tableViewPreparedCell:(TPSettingSwitchCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.logoImage.image = [UIImage imageNamed:self.image];
    cell.nameLabel.text = self.name;
    cell.switchBtn.on = self.status;
    [cell.switchBtn addTarget:self action:@selector(switchBtnAction) forControlEvents:UIControlEventValueChanged];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
