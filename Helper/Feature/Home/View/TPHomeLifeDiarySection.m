//
//  TPHomeLifeDiarySection.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeLifeDiarySection.h"
#import "TPBaseCollectionSectionView.h"

@interface TPHomeLifeDiarySectionHeaderView : TPBaseCollectionSectionView
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TPHomeLifeDiarySectionHeaderView
- (void)setupSubviews {
    [self addSubview:self.titleLabel];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.titleLabel tp_addTitleGradient:[TPUIGradientLayer tp_commonLayer]];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:20 weight:FontMedium];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.text = @"生-活-日-记";
    }
    return _titleLabel;
}
@end

@implementation TPHomeLifeDiarySection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPHomeLifeDiarySectionHeaderView.class];
    }
    return self;
}
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return CGSizeMake(TPUI.tp_screenWidth, 44);
}
- (UIEdgeInsets)tp_collectionSectionInsetWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
- (CGFloat)tp_collectionMinimumLineSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 15;
}
- (CGFloat)tp_collectionMinimumInteritemSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 15;
}
@end
