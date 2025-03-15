//
//  TPPersonalRow.m
//  Helper
//
//  Created by Topredator on 2025/3/11.
//

#import "TPPersonalRow.h"

@interface TPPersonalCell ()
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UIImageView *avatarImage;
@end

@implementation TPPersonalCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.detailLabel];
    [self.container addSubview:self.rightArrow];
    [self.container addSubview:self.avatarImage];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrow.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(0);
        make.right.equalTo(self.rightArrow.mas_left).offset(-10);
    }];
}
- (void)configTitle:(NSString *)title text:(NSString *)text isAvatar:(BOOL)isAvatar {
    self.text = text;
    self.nameLabel.text = title;
    self.avatarImage.hidden = !isAvatar;
    self.detailLabel.hidden = isAvatar;
    if (isAvatar) {
        self.avatarImage.image = [UIImage imageNamed:text];
    } else {
        self.detailLabel.text = text;
    }
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
    }
    return _detailLabel;
}
- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _rightArrow;
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


@interface TPPersonalRow ()
@property (nonatomic, copy) NSString *title;
@end

@implementation TPPersonalRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPPersonalCell.class];
    }
    return self;
}
+ (instancetype)rowWithTitle:(NSString *)title text:(NSString *)text isAvatar:(BOOL)isAvatar identify:(NSString *)identify {
    TPPersonalRow *row = [TPPersonalRow rowWithID:identify];
    row.title = title;
    row.isAvatar = isAvatar;
    row.text = text;
    return row;
}
- (void)setText:(NSString *)text {
    _text = text;
    if (self.cell) {
        if (self.isAvatar && ![self.cell.text isEqualToString:text]) {
            [self.cell configTitle:self.title text:text isAvatar:self.isAvatar];
        } else if (!self.isAvatar && ![self.cell.text isEqualToString:text]) {
            [self.cell configTitle:self.title text:text isAvatar:self.isAvatar];
        }
    }
}
- (void)tp_tableViewPreparedCell:(TPPersonalCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configTitle:self.title text:self.text isAvatar:self.isAvatar];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
