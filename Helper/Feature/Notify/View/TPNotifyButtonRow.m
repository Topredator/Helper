//
//  TPNotifyButtonRow.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPNotifyButtonRow.h"

@interface TPNotifyButtonCell ()
@property (nonatomic, strong) TPUISimButton *simBtn;
@end

@implementation TPNotifyButtonCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.simBtn];
}
- (void)makeConstraints {
    [self.simBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
}
#pragma mark----------------- Getter -----------------
- (TPUISimButton *)simBtn {
    if (!_simBtn) {
        _simBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _simBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _simBtn.iconTextMargin = 10;
        [_simBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _simBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _simBtn.layer.borderWidth = 1;
        _simBtn.layer.borderColor = TPHelperThemeColor.CGColor;
    }
    return _simBtn;
}
@end

typedef NS_ENUM(NSUInteger, TPNotifyOperationType) {
    /// 申请
    TPNotifyOperationTypeApply,
    /// 审核
    TPNotifyOperationTypeExamine
};

@interface TPNotifyButtonRow ()
@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;
@property (nonatomic, assign) TPNotifyOperationType type;
@end

@implementation TPNotifyButtonRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPNotifyButtonCell.class];
    }
    return self;
}
+ (instancetype)applyRow {
    TPNotifyButtonRow *row = [TPNotifyButtonRow row];
    row.type = TPNotifyOperationTypeApply;
    return row;
}
+ (instancetype)examineRow {
    TPNotifyButtonRow *row = [TPNotifyButtonRow row];
    row.type = TPNotifyOperationTypeExamine;
    return row;
}
- (void)setTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
    if (self.cell) {
        [self.cell.simBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        if (target && action) {
            [self.cell.simBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)tp_tableViewPreparedCell:(TPNotifyButtonCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [self setTarget:self.target action:self.action];
    [self.cell.simBtn setImage:[UIImage imageNamed:self.type == TPNotifyOperationTypeApply ? @"notify_ application" : @"notify_examine"] forState:UIControlStateNormal];
    [self.cell.simBtn setTitle:self.type == TPNotifyOperationTypeApply ? @"申请通知" : @"审核情况" forState:UIControlStateNormal];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 70;
}
@end
