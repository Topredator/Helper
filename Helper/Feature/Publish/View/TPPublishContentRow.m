//
//  TPPublishContentRow.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPPublishContentRow.h"

@interface TPPublishContentCell ()
@property (nonatomic, strong) UITextView *textView;
@end
@implementation TPPublishContentCell
- (void)setupSubviews {
    [self.contentView addSubview:self.textView];
}
- (void)makeConstraints {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
}
#pragma mark ==================  Getter   ==================
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.contentSize = CGSizeZero;
        _textView.font = [TPUI tp_font:16 weight:FontMedium];
        _textView.textColor = TPHelperDarkTextColor;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.tp_placeHolder = @"请输入内容...";
        _textView.tp_placeHolderFont = [TPUI tp_font:16 weight:FontMedium];
        _textView.tp_placeHolderColor = [TPUI tp_t:216];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [TPUI tp_t:216].CGColor;
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}
@end

@implementation TPPublishContentRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPPublishContentCell.class];
    }
    return self;
}
+ (instancetype)row {
    return [TPPublishContentRow rowWithID:kTPPublishContentRowKey];
}
- (void)setText:(NSString *)text {
    [self willChangeValueForKey:@"text"];
    _text = text;
    if (![self.cell.textView.text isEqualToString:text]) {
        self.cell.textView.text = text;
    }
    [self didChangeValueForKey:@"text"];
}
- (void)tp_tableViewPreparedCell:(TPPublishContentCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.textView.text = self.text;
    @weakify(self);
    [[cell.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 1000) {
            x = [x substringToIndex:1000];
        }
        self.text = x;
    }];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 200;
}
@end
