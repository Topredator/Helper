//
//  TPDonateRow.m
//  Helper
//
//  Created by Topredator on 2025/3/24.
//

#import "TPDonateRow.h"

typedef void(^TPDonateCellCallback)(NSInteger number);

@interface TPDonateCell ()
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TPLimitTextField *textField;
@property (nonatomic, copy) TPDonateCellCallback callback;
@end

@implementation TPDonateCell
- (void)setupSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subBtn];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.addBtn];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addBtn.mas_left).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(0);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.right.equalTo(self.textField.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
    }];
}
- (void)subBtnAction {
    NSInteger num = self.textField.text.integerValue;
    if (num <= 0) return;
    num -= 1;
    self.textField.text = [NSString stringWithFormat:@"%ld", num];
    if (self.callback) self.callback(num);
}
- (void)addBtnAction {
    NSInteger num = self.textField.text.integerValue;
    if (num >= 99) return;
    num += 1;
    self.textField.text = [NSString stringWithFormat:@"%ld", num];
    if (self.callback) self.callback(num);
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontSemibold];
        _titleLabel.textColor = TPHelperDarkTextColor;
    }
    return _titleLabel;
}
- (UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_subBtn setImage:[UIImage imageNamed:@"common_sub"] forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(subBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addBtn setImage:[UIImage imageNamed:@"common_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.font = [TPUI tp_font:16 weight:FontRegular];
        _textField.textColor = TPHelperDarkGrayTextColor;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderWidth = 2;
        _textField.layer.borderColor = UIColor.blackColor.CGColor;
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = YES;
        _textField.text = @"0";
        _textField.textLimit = 2;
    }
    return _textField;
}

@end

@implementation TPDonateRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPDonateCell.class];
    }
    return self;
}
+ (instancetype)rowWithItem:(TPDonateItemModel *)item {
    TPDonateRow *row = [TPDonateRow row];
    row.itemModel = item;
    return row;
}
- (void)setNumber:(NSString *)number {
    _number = number;
    if (![self.cell.textField.text isEqualToString:number]) {
        self.cell.textField.text = number;
    }
}
- (void)tp_tableViewPreparedCell:(TPDonateCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLabel.text = self.itemModel.itemName;
    cell.textField.text = self.number ?: @"0";
    @weakify(self);
    cell.textField.textDidChangedBlock = ^(TPLimitTextField *textField) {
        @strongify(self);
        self.number = textField.text;
        self.itemModel.quantity = textField.text.integerValue;
    };
    cell.callback = ^(NSInteger number) {
        @strongify(self);
        self.itemModel.quantity = number;
    };
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
