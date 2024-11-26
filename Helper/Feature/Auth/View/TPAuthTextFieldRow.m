//
//  TPAuthTextFieldRow.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPAuthTextFieldRow.h"

@implementation TPAuthTextFieldCell
@synthesize textField = _textField, bottomLine = _bottomLine;
- (void)setupSubviews {
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.bottomLine];
    
}
- (void)makeConstraints {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(36, 40, 0, 40));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(0);
    }];
}
#pragma mark----------------- Getter -----------------
- (TPNoPasteTextField *)textField {
    if (!_textField) {
        _textField = [[TPNoPasteTextField alloc] initWithFrame:CGRectZero];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
    }
    return _textField;
}

- (TPLine *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[TPLine alloc] initWithFrame:CGRectZero];
        _bottomLine.lineColor = [UIColor.grayColor colorWithAlphaComponent:0.3];
        _bottomLine.linePointWidth = 1;
    }
    return _bottomLine;
}
@end


@implementation TPAuthTextFieldRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAuthTextFieldCell.class];
    }
    return self;
}
+ (instancetype)accountRow {
    TPAuthTextFieldRow *row = [TPAuthTextFieldRow rowWithID:kTPAuthAccountRowKey];
    row.placeholder = @"手机号";
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPAuthTextFieldCell * cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textField.textLimit = 11;
        cell.textField.regexpPattern = @"^\\d*";
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    };
    return row;
}
+ (instancetype)passwordRow {
    TPAuthTextFieldRow *row = [TPAuthTextFieldRow rowWithID:kTPAuthPasswordRowKey];
    row.placeholder = @"密码";
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPAuthTextFieldCell * cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textField.textLimit = 10;
        cell.textField.regexpPattern = @"^\\S*";
        cell.textField.secureTextEntry = YES;
        cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
    };
    return row;
}
+ (instancetype)rowWithId:(NSString *)identifier placeholder:(NSString *)placeholder {
    TPAuthTextFieldRow *row = [TPAuthTextFieldRow rowWithID:identifier];
    row.placeholder = placeholder;
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPAuthTextFieldCell * cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textField.textLimit = 10;
        cell.textField.regexpPattern = @"^\\S*";
        cell.textField.secureTextEntry = YES;
        cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
    };
    return row;
}

- (void)setText:(NSString *)text {
    [self willChangeValueForKey:@"text"];
    _text = text;
    if (![self.cell.textField.text isEqualToString:text]) {
        self.cell.textField.text = text;
    }
    [self didChangeValueForKey:@"text"];
}
- (void)setPlaceholder:(NSString *)placeholder {
    [self willChangeValueForKey:@"placeholder"];
    _placeholder = placeholder;
    self.cell.textField.attributedPlaceholder = [self attributedPlaceholder:placeholder];
    [self didChangeValueForKey:@"placeholder"];
}
- (NSAttributedString *)attributedPlaceholder:(NSString *)placeholder {
    if (!placeholder) return nil;
    
    return [[NSAttributedString alloc] initWithString:placeholder attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:15]
    }];
}
- (void)tp_tableViewPreparedCell:(TPAuthTextFieldCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.textField.text = self.text;
    cell.textField.attributedPlaceholder = [self attributedPlaceholder:self.placeholder];
    @weakify(self);
    [cell.textField setTextDidChangedBlock:^(TPLimitTextField *textField) {
        @strongify(self);
        self.text = textField.text;
    }];
    [super tp_tableViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
