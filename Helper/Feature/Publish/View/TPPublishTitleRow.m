//
//  TPPublishTitleRow.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPPublishTitleRow.h"

@implementation TPPublishTitleCell
@synthesize textField = _textField;
- (void)setupSubviews {
    [self.contentView addSubview:self.textField];
    
}
- (void)makeConstraints {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 30, 10, 30));
    }];
}
#pragma mark----------------- Getter -----------------
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:17];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
        _textField.layer.cornerRadius = 10;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [TPUI tp_t:206].CGColor;
        _textField.layer.masksToBounds = YES;
    }
    return _textField;
}

@end

@implementation TPPublishTitleRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPPublishTitleCell.class];
    }
    return self;
}
+ (instancetype)row {
    TPPublishTitleRow *row = [TPPublishTitleRow rowWithID:kTPPublishTitleRowKey];
    row.placeholder = @"请输入标题";
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPPublishTitleCell * cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textField.textLimit = 15;
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

- (void)tp_tableViewPreparedCell:(TPPublishTitleCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
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
    return 60;
}

@end
