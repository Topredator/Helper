//
//  TPReleaseAdoptInputRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAnimalInputRow.h"

@interface TPAnimalInputCell ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) TPLimitTextField *textfield;
@end

@implementation TPAnimalInputCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.textfield];
}
- (void)makeConstraints {
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.titleLable.mas_right).offset(20);
        make.centerY.mas_equalTo(0);
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
- (TPLimitTextField *)textfield {
    if (!_textfield) {
        _textfield = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textfield.font = [TPUI tp_font:15 weight:FontRegular];
        _textfield.textColor = TPHelperDarkGrayTextColor;
        _textfield.textAlignment = NSTextAlignmentRight;
        _textfield.returnKeyType = UIReturnKeyDone;
        _textfield.shouldReturnKeyboard = YES;
        _textfield.textLimit = 15;
    }
    return _textfield;
}
@end

@implementation TPAnimalInputRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAnimalInputCell.class];
    }
    return self;
}
- (void)setText:(NSString *)text {
    [self willChangeValueForKey:@"text"];
    _text = text;
    if (![self.cell.textfield.text isEqual:text]) {
        self.cell.textfield.text = text;
    }
    [self didChangeValueForKey:@"text"];
}
- (void)setTitle:(NSString *)title {
    [self willChangeValueForKey:@"title"];
    _title = title;
    self.cell.titleLable.text = title;
    [self didChangeValueForKey:@"title"];
}
- (void)setPlaceholder:(NSString *)placeholder {
    [self willChangeValueForKey:@"placeholder"];
    _placeholder = placeholder;
    self.cell.textfield.placeholder = placeholder;
    [self didChangeValueForKey:@"placeholder"];
}
/// 姓名
+ (instancetype)nameRowWithId:(NSString *)rowId {
    TPAnimalInputRow *row = [TPAnimalInputRow rowWithID:rowId];
    row.placeholder = @"请输入名称";
    row.title = @"萌宠名称";
    return row;
}
/// 品种
+ (instancetype)breedRowWithId:(NSString *)rowId {
    TPAnimalInputRow *row = [TPAnimalInputRow rowWithID:rowId];
    row.placeholder = @"请输入品种";
    row.title = @"萌宠品种";
    return row;
}
+ (instancetype)numberRowWithId:(NSString *)rowId {
    TPAnimalInputRow *row = [TPAnimalInputRow rowWithID:rowId];
    row.title = @"萌宠编号";
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPAnimalInputCell * _Nonnull cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textfield.userInteractionEnabled = NO;
    };
    return row;
}
+ (instancetype)ageRowWithId:(NSString *)rowId {
    TPAnimalInputRow *row = [TPAnimalInputRow rowWithID:rowId];
    row.title = @"萌宠年龄";
    row.placeholder = @"请输入年龄";
    row.cellPrepared = ^(__kindof TPTableRow * _Nonnull rowData, TPAnimalInputCell * _Nonnull cell, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        cell.textfield.regexpPattern = @"^\\d*";
        cell.textfield.keyboardType = UIKeyboardTypeNumberPad;
        cell.textfield.textLimit = 2;
    };
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAnimalInputCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLable.text = self.title;
    cell.textfield.placeholder = self.placeholder;
    cell.textfield.text = self.text;
    @weakify(self);
    [cell.textfield setTextDidChangedBlock:^(TPLimitTextField *textField) {
        @strongify(self);
        self.text = textField.text;
    }];
    [super tp_tableViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
