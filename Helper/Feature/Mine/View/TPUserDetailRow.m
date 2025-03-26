//
//  TPUserDetailRow.m
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import "TPUserDetailRow.h"

@interface TPUserDetailCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *avatarImage;
@end
@implementation TPUserDetailCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.detailLabel];
    [self.container addSubview:self.avatarImage];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.width.mas_lessThanOrEqualTo(250);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _nameLabel.textColor = TPHelperDarkTextColor;
    }
    return _nameLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _detailLabel.textColor = [TPUI tp_t:204];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 15;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.hidden = YES;
    }
    return _avatarImage;
}
@end

@interface TPUserDetailRow ()
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isAvatar;
@end

@implementation TPUserDetailRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPUserDetailCell.class];
    }
    return self;
}
+ (instancetype)avatarRow:(NSString *)title avatar:(NSString *)avatar {
    TPUserDetailRow *row = [TPUserDetailRow row];
    row.title = title;
    row.avatar = avatar;
    row.isAvatar = YES;
    return row;
}
+ (instancetype)rowWithTitle:(NSString *)title text:(NSString *)text {
    TPUserDetailRow *row = [TPUserDetailRow row];
    row.title = title;
    row.text = text;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPUserDetailCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.avatarImage.hidden = !self.isAvatar;
    cell.detailLabel.hidden = self.isAvatar;
    cell.nameLabel.text = self.title;
    if (self.isAvatar) {
        cell.avatarImage.image = [UIImage imageNamed:self.avatar];
    } else {
        cell.detailLabel.text = self.text;
    }
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
