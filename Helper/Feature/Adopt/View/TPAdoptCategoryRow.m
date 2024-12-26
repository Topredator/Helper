//
//  TPAdoptCategoryRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAdoptCategoryRow.h"

@interface TPAdoptCategoryCell : TPUIBaseTableViewCell
/// 年龄
@property (nonatomic, strong) UILabel *ageLabel;
/// 性别
@property (nonatomic, strong) UILabel *genderLabel;
/// 品类
@property (nonatomic, strong) UILabel *breedLabel;
/// 绝育
@property (nonatomic, strong) UILabel *sterilizationLabel;
/// 驱虫
@property (nonatomic, strong) UILabel *dewormingLabel;
/// 疫苗
@property (nonatomic, strong) UILabel *vaccineLabel;
@end
@implementation TPAdoptCategoryCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.ageLabel];
    [self.contentView addSubview:self.genderLabel];
    [self.contentView addSubview:self.breedLabel];
    [self.contentView addSubview:self.sterilizationLabel];
    [self.contentView addSubview:self.dewormingLabel];
    [self.contentView addSubview:self.vaccineLabel];
}
- (void)makeConstraints {
    CGFloat width = (TPUI.tp_screenWidth - 60 - 50) / 2;
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(width, 25));
    }];
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 25));
        make.left.equalTo(self.ageLabel.mas_right).offset(50);
        make.centerY.equalTo(self.ageLabel.mas_centerY);
    }];
    [self.breedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 25));
        make.left.mas_equalTo(30);
        make.top.equalTo(self.ageLabel.mas_bottom).offset(20);
    }];
    [self.sterilizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 25));
        make.left.equalTo(self.breedLabel.mas_right).offset(50);
        make.centerY.equalTo(self.breedLabel.mas_centerY);
    }];
    [self.dewormingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 25));
        make.left.mas_equalTo(30);
        make.top.equalTo(self.breedLabel.mas_bottom).offset(20);
    }];
    [self.vaccineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 25));
        make.left.equalTo(self.dewormingLabel.mas_right).offset(50);
        make.centerY.equalTo(self.dewormingLabel.mas_centerY);
    }];
}
- (void)configWithAnimal:(TPAnimalModel *)model {
    self.ageLabel.text = [NSString stringWithFormat:@"年龄:  %ld", model.age];
    self.genderLabel.text = [NSString stringWithFormat:@"性别:  %@", model.sexType == TPAnimalSexTypeMale ? @"雄性" : @"雌性"];
    self.breedLabel.text = [NSString stringWithFormat:@"品种:  %@", model.breed];
    self.sterilizationLabel.text = [NSString stringWithFormat:@"绝育:  %@", model.isSterilization ? @"是" : @"否"];
    self.dewormingLabel.text = [NSString stringWithFormat:@"驱虫:  %@", model.isDeworming ? @"是" : @"否"];
    self.vaccineLabel.text = [NSString stringWithFormat:@"疫苗:  %@", model.isVaccine ? @"是" : @"否"];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _ageLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _ageLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _ageLabel;
}
- (UILabel *)genderLabel {
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _genderLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _genderLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _genderLabel;
}
- (UILabel *)breedLabel {
    if (!_breedLabel) {
        _breedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _breedLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _breedLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _breedLabel;
}
- (UILabel *)sterilizationLabel {
    if (!_sterilizationLabel) {
        _sterilizationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sterilizationLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _sterilizationLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _sterilizationLabel;
}
- (UILabel *)dewormingLabel {
    if (!_dewormingLabel) {
        _dewormingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dewormingLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _dewormingLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _dewormingLabel;
}
- (UILabel *)vaccineLabel {
    if (!_vaccineLabel) {
        _vaccineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _vaccineLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _vaccineLabel.textColor = TPHelperLightDarkTextColor;
    }
    return _vaccineLabel;
}
@end

@interface TPAdoptCategoryRow ()
@property (nonatomic, strong) TPAnimalModel *model;
@end

@implementation TPAdoptCategoryRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAdoptCategoryCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPAnimalModel *)model {
    TPAdoptCategoryRow *row = [TPAdoptCategoryRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAdoptCategoryCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithAnimal:self.model];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 145;
}
@end
