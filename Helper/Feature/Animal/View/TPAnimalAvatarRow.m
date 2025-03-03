//
//  TPAnimalAvatarRow.m
//  Helper
//
//  Created by Topredator on 2025/2/25.
//

#import "TPAnimalAvatarRow.h"

@interface TPAnimalAvatarCell ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, copy) NSString *avatar;
@end

@implementation TPAnimalAvatarCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.arrowImage];
}
- (void)makeConstraints {
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImage.mas_left).offset(-5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}
- (void)configWithAvatar:(NSString *)imageName {
    self.avatar = imageName;
    self.titleLable.text = @"萌宠头像";
    self.avatarImage.hidden = !imageName.length;
    self.avatarImage.image = [UIImage imageNamed:imageName];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.font = [TPUI tp_font:16 weight:FontMedium];
        _titleLable.textColor = TPHelperDarkGrayTextColor;
    }
    return _titleLable;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.borderWidth = 1;
        _avatarImage.layer.borderColor = [TPUI tp_t:2.4].CGColor;
        _avatarImage.layer.cornerRadius = 20;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImage;
}
@end

@implementation TPAnimalAvatarRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAnimalAvatarCell.class];
    }
    return self;
}
- (void)setAvatar:(NSString *)avatar {
    _avatar = avatar;
    if (![self.cell.avatar isEqualToString:avatar]) {
        [self.cell configWithAvatar:avatar];
    }
}
- (void)tp_tableViewPreparedCell:(TPAnimalAvatarCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithAvatar:self.avatar];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
