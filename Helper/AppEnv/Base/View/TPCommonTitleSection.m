//
//  TPCommonTitleSection.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPCommonTitleSection.h"
#import "TPBaseTableSectionView.h"

@interface TPCommonTitleSectionHeaderView : TPBaseTableSectionView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation TPCommonTitleSectionHeaderView
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-1);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:25 weight:FontSemibold];
        _titleLabel.textColor = TPHelperThemeColor;
    }
    return _titleLabel;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [TPUI tp_t:205];
    }
    return _line;
}
@end


@interface TPCommonTitleSection ()
@property (nonatomic, copy) NSString *title;
@end

@implementation TPCommonTitleSection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPCommonTitleSectionHeaderView.class];
    }
    return self;
}
+ (instancetype)sectionWithTitle:(NSString *)title {
    TPCommonTitleSection *section = [TPCommonTitleSection section];
    section.title = title;
    return section;
}
- (void)tp_tableViewHeader:(TPCommonTitleSectionHeaderView *)header preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    header.titleLabel.text = self.title;
}
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 60;
}
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 5;
}
@end
