//
//  TPSettingRow.m
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import "TPSettingRow.h"
#import "TPBackgroundCell.h"

@interface TPSettingCell : TPBackgroundCell
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIView *line;
@end

@implementation TPSettingCell
- (void)setupSubviews {
    [super setupSubviews];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.arrowImage];
    [self.container addSubview:self.desLabel];
    [self.container addSubview:self.line];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImage.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.8);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)prepareCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    self.line.hidden = (rowCount == 1 || (rowCount > 1 && indexPath.row == rowCount - 1));
    [super prepareCellForTableView:tableView atIndexPath:indexPath];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [TPUI tp_t:105];
    }
    return _nameLabel;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.textColor = TPHelperLightDarkTextColor;
        _desLabel.textAlignment = NSTextAlignmentRight;
    }
    return _desLabel;
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

@interface TPSettingRow ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) BOOL isShowArrow;
@end

@implementation TPSettingRow
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isShowArrow = YES;
        [self setCellClass:TPSettingCell.class];
    }
    return self;
}
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image {
    TPSettingRow *row = [TPSettingRow row];
    row.name = name;
    row.image = image;
    return row;
}
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image des:(NSString *)des arrow:(BOOL)arrow {
    TPSettingRow *row = [TPSettingRow row];
    row.name = name;
    row.image = image;
    row.des = des;
    row.isShowArrow = arrow;
    return row;
}
+ (instancetype)disableRowWithName:(NSString *)name image:(NSString *)image {
    TPSettingRow *row = [TPSettingRow row];
    row.name = name;
    row.image = image;
    row.isShowArrow = NO;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPSettingCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.logoImage.image = [UIImage imageNamed:self.image];
    cell.nameLabel.text = self.name;
    cell.desLabel.text = self.des ?: @"";
    cell.arrowImage.hidden = !self.isShowArrow;
    [cell prepareCellForTableView:proxy.tableView atIndexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end
