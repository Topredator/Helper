//
//  TPAdoptItemRow.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPCommonAnimalRow.h"
#import "TPSingleBgTableCell.h"

@interface TPCommonAnimalCell : TPSingleBgTableCell
/// 头像
@property (nonatomic, strong) UIImageView *avatarImage;
/// 名称
@property (nonatomic, strong) UILabel *nameLabel;
/// 性别icon
@property (nonatomic, strong) UIImageView *sexImage;
/// 品种
@property (nonatomic, strong) UILabel *breedLabel;
/// 绝育、驱虫、疫苗 容器
@property (nonatomic, strong) UIView *itemContainer;
@end

@implementation TPCommonAnimalCell
- (void)setupSubviews {
    [super setupSubviews];
    self.container.backgroundColor = UIColor.whiteColor;
    [self.container addSubview:self.avatarImage];
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.sexImage];
    [self.container addSubview:self.breedLabel];
    [self.container addSubview:self.itemContainer];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(90);
        make.bottom.mas_equalTo(-10);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    [self.breedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    [self.itemContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.breedLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-10);
    }];
}
- (void)configWithModel:(TPAnimalModel *)model {
    self.avatarImage.image = [UIImage imageNamed:model.thumbImage];
    self.nameLabel.text = model.name;
    self.sexImage.image = [UIImage imageNamed:model.sexType == TPAnimalSexTypeFemale ? @"sex_female" : @"sex_male"];
    self.breedLabel.text = [NSString stringWithFormat:@"品种: %@", model.breed];
    [self.itemContainer tp_removeAllSubviews];
    
    UILabel *sterilizationLabel = [self createLabel:model.isSterilization ? @"已绝育" : @"未绝育" flag:model.isSterilization];
    [self.itemContainer addSubview:sterilizationLabel];
    
    UILabel *dewormingLabel = [self createLabel:model.isDeworming ? @"已驱虫" : @"未驱虫" flag:model.isDeworming];
    [self.itemContainer addSubview:dewormingLabel];
    
    UILabel *vaccineLabel = [self createLabel:model.isVaccine ? @"已接种疫苗" : @"未接种疫苗" flag:model.isVaccine];
    [self.itemContainer addSubview:vaccineLabel];
    
    [sterilizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
    }];
    [dewormingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(sterilizationLabel.mas_right).offset(10);
        make.width.equalTo(sterilizationLabel.mas_width);
    }];
    [vaccineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.left.equalTo(dewormingLabel.mas_right).offset(10);
        make.width.equalTo(dewormingLabel.mas_width);
    }];
    
}
- (UILabel *)createLabel:(NSString *)title flag:(BOOL)flag {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [TPUI tp_font:11 weight:FontMedium];
    label.textColor = flag ? TPHelperThemeColor : TPHelperDarkGrayTextColor;
    label.backgroundColor = TPHelperDefaultBgColor;
    label.layer.borderWidth = 1;
    label.layer.borderColor = flag ? TPHelperThemeColor.CGColor : UIColor.clearColor.CGColor;
    label.layer.cornerRadius = 4;
    label.layer.masksToBounds = YES;
    return label;
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 10;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:15 weight:FontSemibold];
        _nameLabel.textColor = UIColor.blackColor;
    }
    return _nameLabel;
}
- (UIImageView *)sexImage {
    if (!_sexImage) {
        _sexImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _sexImage;
}
- (UILabel *)breedLabel {
    if (!_breedLabel) {
        _breedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _breedLabel.font = [UIFont systemFontOfSize:12];
        _breedLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _breedLabel;
}
- (UIView *)itemContainer {
    if (!_itemContainer) {
        _itemContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _itemContainer;
}
@end

@interface TPCommonAnimalRow ()
@property (nonatomic, strong) TPAnimalModel *animalModel;
@end

@implementation TPCommonAnimalRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCommonAnimalCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPAnimalModel *)model {
    TPCommonAnimalRow *row = [self rowWithID:kTPAnimalCommonRowKey];
    row.animalModel = model;
    return row;
}
+ (instancetype)rowWithModel:(TPAnimalModel *)model identifer:(NSString *)identifer {
    TPCommonAnimalRow *row = [self rowWithID:identifer];
    row.animalModel = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPCommonAnimalCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.animalModel];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 125;
}
@end
