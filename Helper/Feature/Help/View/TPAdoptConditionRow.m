//
//  TPAdoptConditionRow.m
//  Helper
//
//  Created by Topredator on 2025/3/20.
//

#import "TPAdoptConditionRow.h"


@interface TPAdoptConditionCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIImageView *selectedImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation TPAdoptConditionCell
- (void)setupSubviews {
    [self.contentView addSubview:self.selectedImage];
    [self.contentView addSubview:self.indexLabel];
    [self.contentView addSubview:self.contentLabel];
}
- (void)makeConstraints {
    [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(25);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}
#pragma mark ==================  Getter   ==================
- (UIImageView *)selectedImage {
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _selectedImage;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textColor = TPHelperDarkTextColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _indexLabel.font = [TPUI tp_font:16 weight:FontSemibold];
        _indexLabel.textColor = TPHelperLightDarkTextColor;
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLabel;
}
@end


@interface TPAdoptConditionRow ()
@property (nonatomic, assign) BOOL isCondition;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation TPAdoptConditionRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAdoptConditionCell.class];
    }
    return self;
}
+ (instancetype)conditionRowWithTitle:(NSString *)title isSelected:(BOOL)isSelected {
    TPAdoptConditionRow *row = [TPAdoptConditionRow row];
    row.title = title;
    row.isSelected = isSelected;
    row.isCondition = YES;
    return row;
}
+ (instancetype)flowWithTitle:(NSString *)title {
    TPAdoptConditionRow *row = [TPAdoptConditionRow row];
    row.title = title;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAdoptConditionCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.indexLabel.hidden = self.isCondition;
    cell.selectedImage.hidden = !self.isCondition;
    cell.selectedImage.image = [UIImage imageNamed:self.isSelected ? @"agreement_selected" : @"common_wrong_choice"];
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld.", indexPath.row + 1];
    cell.contentLabel.text = self.title;
}
@end
