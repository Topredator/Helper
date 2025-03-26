//
//  TPUserListRow.m
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import "TPUserListRow.h"

@interface TPUserListCell ()
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@end
@implementation TPUserListCell
- (void)setupSubviews {
    [super setupSubviews];
    self.container.backgroundColor = UIColor.whiteColor;
    [self.container addSubview:self.avatarImage];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.arrowImage];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self.avatarImage.mas_right);
        make.bottom.equalTo(self.avatarImage.mas_bottom);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
        make.right.mas_equalTo(self.arrowImage.mas_left).offset(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
}
#pragma mark ==================  Getter   ==================
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 30;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImage.layer.cornerRadius = 10;
        _logoImage.layer.borderColor = [TPUI tp_t:204].CGColor;
        _logoImage.layer.borderWidth = 1;
        _logoImage.layer.masksToBounds = YES;
    }
    return _logoImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _nameLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _nameLabel;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImage;
}
@end

@interface TPUserListRow ()
@property (nonatomic, strong) TPUserModel *model;
@end

@implementation TPUserListRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPUserListCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPUserModel *)model {
    TPUserListRow *row = [TPUserListRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPUserListCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.avatarImage.image = [UIImage imageNamed:self.model.avatar];
    cell.nameLabel.text = self.model.name;
    NSString *imageName = @"role_customer";
    switch (self.model.userType) {
        case TPUserTypeSuperManager: imageName = @"role_super"; break;
        case TPUserTypeManager: imageName = @"role_manager"; break;
        default: imageName = @"role_customer"; break;
    }
    cell.logoImage.image = [UIImage imageNamed:imageName];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
