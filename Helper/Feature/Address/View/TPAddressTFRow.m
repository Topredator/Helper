//
//  TPAddressTFRow.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressTFRow.h"

@interface TPAddressTFCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TPLimitTextField *textField;
@end

@implementation TPAddressTFCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.textField];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
        make.height.mas_equalTo(30);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _titleLabel.textColor = [TPUI tp_t:105];
    }
    return _titleLabel;
}
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.font = [TPUI tp_font:18 weight:FontRegular];
        _textField.textColor = TPHelperDarkGrayTextColor;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
        _textField.textLimit = 15;
    }
    return _textField;
}
@end

@interface TPAddressTFRow ()
@property (nonatomic, copy) NSString *title;
@end

@implementation TPAddressTFRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAddressTFCell.class];
    }
    return self;
}
- (void)setText:(NSString *)text {
    _text = text;
    if (![self.cell.textField.text isEqualToString:text]) {
        self.cell.textField.text = text;
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (self.cell) {
        self.cell.textField.placeholder = placeholder;
    }
}
+ (instancetype)nameTitle:(NSString *)title {
    TPAddressTFRow *row = [TPAddressTFRow rowWithID:kTPAddressNameKey];
    row.placeholder = @"请输入名称";
    row.title = title;
    return row;
}
+ (instancetype)phoneTitle:(NSString *)title {
    TPAddressTFRow *row = [TPAddressTFRow rowWithID:kTPAddressPhoneKey];
    row.title = title;
    row.placeholder = @"请输入联系方式";
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAddressTFCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLabel.text = self.title;
    cell.textField.placeholder = self.placeholder;
    cell.textField.text = self.text;
    cell.textField.keyboardType = self.isNumericKeyboard ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    @weakify(self);
    [cell.textField setTextDidChangedBlock:^(TPLimitTextField *textField) {
        @strongify(self);
        self.text = textField.text;
    }];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
    [super tp_tableViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
