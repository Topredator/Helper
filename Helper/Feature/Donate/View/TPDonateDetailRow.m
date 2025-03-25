//
//  TPDonateDetailRow.m
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import "TPDonateDetailRow.h"

@interface TPDonateDetailCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end
@implementation TPDonateDetailCell
- (void)setupSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.numberLabel];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(150);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
}
- (void)configWithModel:(TPDonateItemModel *)itemModel {
    self.titleLabel.text = itemModel.itemName;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", itemModel.quantity];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _titleLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _titleLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _numberLabel;
}
@end


@implementation TPDonateDetailRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPDonateDetailCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPDonateItemModel *)itemModel {
    TPDonateDetailRow *row = [TPDonateDetailRow row];
    row.itemModel = itemModel;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPDonateDetailCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.itemModel];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 40;
}
@end
