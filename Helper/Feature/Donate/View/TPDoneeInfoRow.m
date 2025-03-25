//
//  TPDoneeInfoRow.m
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import "TPDoneeInfoRow.h"

@interface TPDoneeInfoCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end
@implementation TPDoneeInfoCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.phoneLabel];
    [self.container addSubview:self.addressLabel];
    [self.container addSubview:self.numberLabel];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(10);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:20 weight:FontMedium];
        _titleLabel.textColor = TPHelperThemeColor;
        _titleLabel.text = @"受捐方信息";
    }
    return _titleLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:17 weight:FontSemibold];
        _nameLabel.textColor = TPHelperDarkGrayTextColor;
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.font = [TPUI tp_font:17 weight:FontSemibold];
        _phoneLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = [TPUI tp_font:17 weight:FontSemibold];
        _addressLabel.textColor = TPHelperDarkGrayTextColor;
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.font = [TPUI tp_font:17 weight:FontSemibold];
        _numberLabel.textColor = TPHelperDarkGrayTextColor;
        _numberLabel.numberOfLines = 2;
    }
    return _numberLabel;
}
@end


@implementation TPDoneeInfoRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPDoneeInfoCell.class];
    }
    return self;
}
- (void)tp_tableViewPreparedCell:(TPDoneeInfoCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.nameLabel.text = [NSString stringWithFormat:@"受捐人: %@", self.user.name];
    cell.phoneLabel.text = [NSString stringWithFormat:@"手机号: %@", self.user.account];
    cell.addressLabel.text = [NSString stringWithFormat:@"详细地址: %@", self.address];
    cell.numberLabel.text = [NSString stringWithFormat:@"快递编号: %@", self.expressNumber];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
@end
