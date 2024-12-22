//
//  TPNotifyAnnouncementSection.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPNotifyAnnouncementSection.h"
#import "TPBaseTableSectionView.h"
#import "TPLineView.h"

@interface TPNotifyAnnouncementSectionHeaderView : TPBaseTableSectionView
@property (nonatomic, strong) TPLineView *lineView;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TPNotifyAnnouncementSectionHeaderView
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
//    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.titleLabel];
}
- (void)makeConstraints {
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(20);
        make.top.bottom.mas_equalTo(0);
    }];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notify_logo"]];
    }
    return _logoImage;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:22 weight:FontMedium];
        _titleLabel.textColor = TPHelperDarkTextColor;
        _titleLabel.text = @"公告";
    }
    return _titleLabel;
}
- (TPLineView *)lineView {
    if (!_lineView) {
        _lineView = [TPLineView createWithLineWidth:4 lineGap:4 lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.05] rotate:45];
    }
    return _lineView;
}
@end

@implementation TPNotifyAnnouncementSection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPNotifyAnnouncementSectionHeaderView.class];
    }
    return self;
}
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 45;
}
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 0.01;
}
@end

