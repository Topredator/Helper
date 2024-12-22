//
//  TPHomeLifeDiaryRow.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeLifeDiaryRow.h"
#import "TPCommonCollectionCell.h"

@interface TPHomeLifeDiaryCell : TPCommonCollectionCell
@property (nonatomic, strong) UIView *container;
/// 图片
@property (nonatomic, strong) UIImageView *imageView;
/// 用户头像
@property (nonatomic, strong) UIImageView *avatarImage;
/// 用户名称
@property (nonatomic, strong) UILabel *nameLabel;
/// 话题题目
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TPHomeLifeDiaryCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.imageView];
    [self.container addSubview:self.avatarImage];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.titleLabel];
}
- (void)makeConstraints {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo((TPUI.tp_screenWidth - 45) / 2);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(15);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.avatarImage.mas_centerY);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.avatarImage.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-5);
    }];
}
#pragma mark----------------- Getter -----------------
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.backgroundColor = TPHelperDefaultBgColor;
        _container.layer.cornerRadius = 10;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.image = [UIImage imageNamed:@"mine_avatar"];
        _avatarImage.layer.cornerRadius = 15;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:15 weight:FontMedium];
        _nameLabel.textColor = TPHelperThemeColor;
    }
    return _nameLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:15 weight:FontSemibold];
        _titleLabel.textColor = TPHelperDarkTextColor;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
@end

@implementation TPHomeLifeDiaryRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPHomeLifeDiaryCell.class];
    }
    return self;
}
- (void)tp_collectionViewPreparedCell:(TPHomeLifeDiaryCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row + 1;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_diary_%ld", (long)(index % 25)]];
    cell.avatarImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_avatar_%ld", index % 35]];
    cell.nameLabel.text = [NSString stringWithFormat:@"用户%ld", indexPath.row + 1];
    cell.titleLabel.text = @"今天天气真好啊";
}
- (CGSize)tp_collectionViewItemSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    CGFloat width = (TPUI.tp_screenWidth - 45) / 2;
    CGFloat height = width + 10 + 30 + 10 + 5 + 20;
    return CGSizeMake((TPUI.tp_screenWidth - 45) / 2, height);
}
@end
