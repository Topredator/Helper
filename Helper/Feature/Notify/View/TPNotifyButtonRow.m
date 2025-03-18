//
//  TPNotifyButtonRow.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPNotifyButtonRow.h"

@interface TPNotifyButtonCell ()
@property (nonatomic, strong) TPUISimButton *simBtn;
@property (nonatomic, strong) UIImageView *tipImage;
@end

@implementation TPNotifyButtonCell
- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.simBtn];
    [self.contentView addSubview:self.tipImage];
}
- (void)makeConstraints {
    [self.simBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    [self.tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-40);
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
- (UIImageView *)tipImage {
    if (!_tipImage) {
        _tipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notify_tip"]];
        _tipImage.hidden = YES;
    }
    return _tipImage;
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
    TPNotifyButtonRow *row = [TPNotifyButtonRow rowWithID:kTPNotifyApplyRowKey];
    row.type = TPNotifyOperationTypeApply;
    return row;
}
+ (instancetype)examineRow {
    TPNotifyButtonRow *row = [TPNotifyButtonRow rowWithID:kTPNotifyExamineRowKey];
    row.type = TPNotifyOperationTypeExamine;
    return row;
}
- (void)setTip:(BOOL)tip {
    _tip = tip;
    if (self.cell) {
        self.cell.tipImage.hidden = !tip;
    }
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
    self.cell.tipImage.hidden = !self.tip;
    [self.cell.simBtn setImage:[UIImage imageNamed:self.type == TPNotifyOperationTypeApply ? @"notify_ application" : @"notify_examine"] forState:UIControlStateNormal];
    [self.cell.simBtn setTitle:self.type == TPNotifyOperationTypeApply ? @"我的申请" : @"审核需要" forState:UIControlStateNormal];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 70;
}
@end
