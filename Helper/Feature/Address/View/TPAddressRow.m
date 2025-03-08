//
//  TPAddressRow.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressRow.h"
#import "TPAddressModule.h"
@interface TPAddressCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *defaultLogo;
@end

@implementation TPAddressCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.phoneLabel];
    [self.container addSubview:self.addressLabel];
    [self.container addSubview:self.defaultLogo];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(25);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(-40);
    }];
    [self.defaultLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.top.right.mas_equalTo(0);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = TPHelperDarkTextColor;
        _nameLabel.font = [TPUI tp_font:20 weight:FontMedium];
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.textColor = TPHelperDarkGrayTextColor;
        _phoneLabel.font = [TPUI tp_font:16 weight:FontRegular];
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = TPHelperDarkGrayTextColor;
        _addressLabel.font = [TPUI tp_font:18 weight:FontMedium];
    }
    return _addressLabel;
}
- (UIImageView *)defaultLogo {
    if (!_defaultLogo) {
        _defaultLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_account_address_default"]];
    }
    return _defaultLogo;
}
@end

@interface TPAddressRow ()
@property (nonatomic, strong) TPAddressModel *model;
@end

@implementation TPAddressRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAddressCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPAddressModel *)model {
    TPAddressRow *row = [TPAddressRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAddressCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.nameLabel.text = self.model.name;
    cell.phoneLabel.text = self.model.phone;
    cell.defaultLogo.hidden = !self.model.isDefault;
    cell.addressLabel.text = self.model.detailAddress;
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (BOOL)tp_tableViewCanEditRowWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSString *)tp_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tp_tableViewCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    [TPUIAlert alertShow:^(TPUIAlertMaker *make) {
        make.title(@"确认").message(@"您确定要删除此地址吗?");
        make.addOption(TPUIAlertBlockOption(@"确定", ^{
            @strongify(self);
            [TPDBRouter sendTaskMessage:TPAddressDeleteUserAddress argument:self.model.addressId];
        }));
        make.cancleOption(@"取消");
    }];
    
}
@end
