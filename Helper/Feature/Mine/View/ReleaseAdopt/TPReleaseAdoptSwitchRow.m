//
//  TPReleaseAdoptSwitchRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPReleaseAdoptSwitchRow.h"

@interface TPReleaseAdoptSwitchCell ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UISwitch *switchBtn;
@end
@implementation TPReleaseAdoptSwitchCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.switchBtn];
}
- (void)makeConstraints {
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 30));
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
- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    return _switchBtn;
}
@end

@implementation TPReleaseAdoptSwitchRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPReleaseAdoptSwitchCell.class];
    }
    return self;
}

- (void)setOn:(BOOL)on {
    _on = on;
    if (self.cell.switchBtn.on != on) {
        self.cell.switchBtn.on = on;
    }
}
+ (instancetype)sterilizationRowWithId:(NSString *)rowId {
    TPReleaseAdoptSwitchRow *row = [TPReleaseAdoptSwitchRow rowWithID:rowId];
    row.title = @"是否绝育";
    return row;
}
/// 驱虫
+ (instancetype)dewormingRowWithId:(NSString *)rowId {
    TPReleaseAdoptSwitchRow *row = [TPReleaseAdoptSwitchRow rowWithID:rowId];
    row.title = @"是否驱虫";
    return row;
}
/// 疫苗
+ (instancetype)vaccineRowWithId:(NSString *)rowId {
    TPReleaseAdoptSwitchRow *row = [TPReleaseAdoptSwitchRow rowWithID:rowId];
    row.title = @"是否接种疫苗";
    return row;
}
- (void)switchBtnAction {
    self.on = self.cell.switchBtn.isOn;
}
- (void)tp_tableViewPreparedCell:(TPReleaseAdoptSwitchCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLable.text = self.title;
    cell.switchBtn.on = self.on;
    [cell.switchBtn addTarget:self action:@selector(switchBtnAction) forControlEvents:UIControlEventValueChanged];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
