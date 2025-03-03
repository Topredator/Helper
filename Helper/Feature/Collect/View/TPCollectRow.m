//
//  TPCollectRow.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectRow.h"

@interface TPCollectCell ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation TPCollectCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.avatarImage];
    [self.container addSubview:self.nameLabel];
}
- (void)makeConstraints {
    CGFloat height = (TPUI.tp_screenWidth - 20 - 20) / 3;
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(4);
        make.right.mas_equalTo(-4);
        make.top.equalTo(self.avatarImage.mas_bottom);
        make.height.mas_equalTo(25);
    }];
}
- (void)configWithModel:(TPCollectModel *)collectModel {
    self.avatarImage.image = [UIImage imageNamed:collectModel.animal.thumbImage];
    self.nameLabel.text = collectModel.animal.name;
}
#pragma mark ==================  Getter   ==================
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.layer.cornerRadius = 5;
        _container.layer.masksToBounds = YES;
        _container.backgroundColor = TPHelperDefaultBgColor;
    }
    return _container;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _avatarImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.font = [TPUI tp_font:15 weight:FontMedium];
        _nameLabel.backgroundColor = TPHelperDefaultBgColor;
    }
    return _nameLabel;
}
@end


@interface TPCollectRow ()
@property (nonatomic, strong) TPCollectModel *collectModel;
@end

@implementation TPCollectRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCollectCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPCollectModel *)model {
    TPCollectRow *row = [TPCollectRow row];
    row.collectModel = model;
    return row;
}
- (void)tp_collectionViewPreparedCell:(TPCollectCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.collectModel];
}
- (CGSize)tp_collectionViewItemSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    CGFloat width = (TPUI.tp_screenWidth - 20 - 20) / 3;
    return CGSizeMake(width, width + 25);
}
@end
