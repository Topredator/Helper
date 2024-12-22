//
//  TPMineToolRow.m
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import "TPMineToolRow.h"
#import "TPBackgroundCell.h"

@interface TPMineToolCell : TPBackgroundCell
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation TPMineToolCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.logoImageView];
    [self.container addSubview:self.nameLabel];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageView.mas_right).offset(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
}
- (void)configWithIcon:(NSString *)icon name:(NSString *)name {
    self.logoImageView.image = [UIImage imageNamed:icon];
    self.nameLabel.text = name;
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [TPUI tp_t:105];
    }
    return _nameLabel;
}
@end

@interface TPMineToolRow ()
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@end

@implementation TPMineToolRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPMineToolCell.class];
    }
    return self;
}
+ (instancetype)rowWithIcon:(NSString *)icon name:(NSString *)name {
    TPMineToolRow *row = [TPMineToolRow row];
    row.icon = icon;
    row.name = name;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPMineToolCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithIcon:self.icon name:self.name];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
