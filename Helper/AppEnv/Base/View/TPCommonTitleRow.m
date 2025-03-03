//
//  TPCommonTitleRow.m
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import "TPCommonTitleRow.h"
#import "TPBackgroundCell.h"

@interface TPCommonTitleCell : TPBackgroundCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIView *line;
@end

@implementation TPCommonTitleCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.arrowImage];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(15);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
}
- (void)prepareCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    self.line.hidden = (rowCount == 1 || (rowCount > 1 && indexPath.row == rowCount - 1));
    [super prepareCellForTableView:tableView atIndexPath:indexPath];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _titleLabel.textColor = [TPUI tp_t:105];
    }
    return _titleLabel;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImage;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [TPUI tp_hexStringColor:@"#E6E6E6"];
    }
    return _line;
}
@end

@interface TPCommonTitleRow ()
@property (nonatomic, copy) NSString *title;
@end

@implementation TPCommonTitleRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCommonTitleCell.class];
    }
    return self;
}
+ (instancetype)rowWithTitle:(NSString *)title {
    TPCommonTitleRow *row = [TPCommonTitleRow row];
    row.title = title;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPCommonTitleCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLabel.text = self.title;
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
