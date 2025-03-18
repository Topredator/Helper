//
//  TPNotifyAnnouncementRow.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPNotifyAnnouncementRow.h"

@interface TPNotifyAnnouncementCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIView *container;
/// logo
@property (nonatomic, strong) UIImageView *logoImage;

/// 公告标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 公告内容
@property (nonatomic, strong) UILabel *desLabel;
@end

@implementation TPNotifyAnnouncementCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.desLabel];
}
- (void)makeConstraints {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(7, 15, 5, 15));
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(15);
        make.top.equalTo(self.logoImage.mas_top).offset(10);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(-10);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-5);
    }];
}
- (void)configWithModel:(TPPublishModel *)model {
    NSString *imageName = @"";
    switch (model.type) {
        case TPPublishTypeLinkNotice: imageName = @"announcement_news"; break;
        default: imageName = @"announcement_platform"; break;
    }
    self.logoImage.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = model.title;
    self.desLabel.text = model.content;
    self.desLabel.textColor = model.type == TPPublishTypeLinkNotice ? TPHelperThemeColor : TPHelperDarkGrayTextColor;
}

#pragma mark----------------- Getter -----------------
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.backgroundColor = UIColor.whiteColor;
        _container.layer.borderWidth = 1;
        _container.layer.borderColor = [TPUI tp_t:204].CGColor;
    }
    return _container;
}
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImage;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:20 weight:FontMedium];
        _titleLabel.textColor = TPHelperDarkTextColor;
    }
    return _titleLabel;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.font = [TPUI tp_font:15 weight:FontRegular];
        _desLabel.textColor = TPHelperDarkGrayTextColor;
        _desLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _desLabel;
}
@end

@interface TPNotifyAnnouncementRow ()
@property (nonatomic, strong) TPPublishModel *model;
@end

@implementation TPNotifyAnnouncementRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPNotifyAnnouncementCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPPublishModel *)model {
    TPNotifyAnnouncementRow *row = [TPNotifyAnnouncementRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPNotifyAnnouncementCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.model];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 92;
}
@end
