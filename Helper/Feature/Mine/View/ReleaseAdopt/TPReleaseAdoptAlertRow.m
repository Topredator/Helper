//
//  TPReleaseAdoptAlertRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPReleaseAdoptAlertRow.h"

@interface TPReleaseAdoptAlertCell ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@end

@implementation TPReleaseAdoptAlertCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.valueLabel];
    [self.contentView addSubview:self.arrowImage];
}
- (void)makeConstraints {
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImage.mas_left).offset(-5);
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.titleLable.mas_right).offset(15);
    }];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.font = [TPUI tp_font:16 weight:FontMedium];
        _titleLable.textColor = TPHelperDarkGrayTextColor;
    }
    return _titleLable;
}
- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.font = [TPUI tp_font:15 weight:FontRegular];
        _valueLabel.textColor = TPHelperDarkGrayTextColor;
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImage;
}
@end

@interface TPReleaseAdoptAlertRow ()

@end

@implementation TPReleaseAdoptAlertRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPReleaseAdoptAlertCell.class];
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    [self willChangeValueForKey:@"title"];
    _title = title;
    self.cell.titleLable.text = title;
    [self didChangeValueForKey:@"title"];
}
- (void)setText:(NSString *)text {
    [self willChangeValueForKey:@"text"];
    _text = text;
    if (![self.cell.valueLabel.text isEqual:text]) {
        self.cell.valueLabel.text = text;
    }
    [self didChangeValueForKey:@"text"];
}
+ (instancetype)categoryRowWithId:(NSString *)rowId {
    TPReleaseAdoptAlertRow *row = [TPReleaseAdoptAlertRow rowWithID:rowId];
    row.title = @"萌宠种类";
    return row;
}
+ (instancetype)genderRowWithId:(NSString *)rowId {
    TPReleaseAdoptAlertRow *row = [TPReleaseAdoptAlertRow rowWithID:rowId];
    row.title = @"萌宠性别";
    return row;
}
- (void)tp_tableViewPreparedCell:(TPReleaseAdoptAlertCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLable.text = self.title;
    cell.valueLabel.text = self.text;
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
