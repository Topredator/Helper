//
//  TPPublishSendRow.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPPublishSendRow.h"

@interface TPPublishSendCell ()
@property (nonatomic, strong) UIButton *sendBtn;
@end
@implementation TPPublishSendCell
- (void)setupSubviews {
    [self.contentView addSubview:self.sendBtn];
}
- (void)makeConstraints {
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 40, 10, 40));
    }];
}
#pragma mark ==================  Getter   ==================
- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendBtn setTitle:@"发 布" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        [_sendBtn setTitleColor:TPHelperDarkTextColor forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[TPUI tp_r:39 g:119 b:248]];
        _sendBtn.layer.cornerRadius = 8;
        _sendBtn.layer.masksToBounds = YES;
    }
    return _sendBtn;
}
@end

@interface TPPublishSendRow ()
@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;
@end

@implementation TPPublishSendRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPPublishSendCell.class];
    }
    return self;
}
+ (instancetype)row {
    return [TPPublishSendRow rowWithID:kTPPublishSendRowKey];
}
- (void)setTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
    if (self.cell) {
        [self.cell.sendBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        if (target && action) {
            [self.cell.sendBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)tp_tableViewPreparedCell:(TPPublishSendCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [self setTarget:self.target action:self.action];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 65;
}
@end
