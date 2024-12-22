//
//  TPMineToolSection.m
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import "TPMineToolSection.h"
#import "TPBaseTableSectionView.h"


@interface TPMineToolSectionHeaderView : TPBaseTableSectionView
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TPMineToolSectionHeaderView
- (void)setupSubviews {
    [self.contentView addSubview:self.titleLabel];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontSemibold];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.text = @"工具箱";
    }
    return _titleLabel;
}
@end

@implementation TPMineToolSection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPMineToolSectionHeaderView.class];
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
