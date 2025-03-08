//
//  TPAddressTVRow.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressTVRow.h"

@interface TPAddressTVCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TPAddressTVCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.textView];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-15);
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
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
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.contentSize = CGSizeZero;
        _textView.font = [TPUI tp_font:18 weight:FontMedium];
        _textView.textColor = TPHelperDarkTextColor;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.tp_placeHolder = @"请输入详细地址";
        _textView.tp_placeHolderFont = [TPUI tp_font:18 weight:FontMedium];
        _textView.tp_placeHolderColor = [TPUI tp_t:216];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [TPUI tp_t:216].CGColor;
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}
@end
@interface TPAddressTVRow ()
@property (nonatomic, copy) NSString *title;
@end
@implementation TPAddressTVRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAddressTVCell.class];
    }
    return self;
}
+ (instancetype)rowWithTitle:(NSString *)title {
    TPAddressTVRow *row = [TPAddressTVRow rowWithID:kTPAddressTVKey];
    row.title = title;
    row.placeholder = @"请输入具体地址";
    return row;
}
- (void)setText:(NSString *)text {
    _text = text;
    if (![self.cell.textView.text isEqualToString:text]) {
        self.cell.textView.text = text;
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.cell.textView.tp_placeHolder = placeholder;
}
- (void)tp_tableViewPreparedCell:(TPAddressTVCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLabel.text = self.title;
    cell.textView.text = self.text;
    cell.textView.tp_placeHolder = self.placeholder;
    @weakify(self);
    [[cell.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 300) {
            x = [x substringToIndex:300];
        }
        self.text = x;
    }];
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 230;
}
@end
