//
//  TPDonateSection.m
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import "TPDonateSection.h"
#import "TPBaseTableSectionView.h"


@interface TPDonateSectionHeadView : TPBaseTableSectionView
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TPDonateSectionHeadView
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLabel];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark----------------- Getter -----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontSemibold];
        _titleLabel.textColor = TPHelperThemeColor;
    }
    return _titleLabel;
}
@end

@interface TPDonateSection ()
@end

@implementation TPDonateSection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPDonateSectionHeadView.class];
    }
    return self;
}
+ (instancetype)sectionWithModel:(TPDonateCategoryModel *)model {
    TPDonateSection *section = [TPDonateSection section];
    section.categoryModel = model;
    return section;
}
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 60;
}
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return 0.01;
}
- (void)tp_tableViewHeader:(TPDonateSectionHeadView *)header preparedWithProxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    header.titleLabel.text = self.categoryModel.categoryName;
}
@end
