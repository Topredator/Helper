//
//  TPAdoptIntroduceRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAdoptIntroduceRow.h"

@interface TPAdoptIntroduceCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *conditionLabel;
@end
@implementation TPAdoptIntroduceCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.conditionLabel];
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.bottom.mas_equalTo(-10);
    }];
}
#pragma mark----------------- Getter -----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:20 weight:FontSemibold];
        _titleLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _titleLabel;
}
- (UILabel *)conditionLabel {
    if (!_conditionLabel) {
        _conditionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _conditionLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _conditionLabel.textColor = TPHelperLightDarkTextColor;
        _conditionLabel.numberOfLines = 0;
    }
    return _conditionLabel;
}
@end

@implementation TPAdoptIntroduceRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAdoptIntroduceCell.class];
    }
    return self;
}
- (void)tp_tableViewPreparedCell:(TPAdoptIntroduceCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.titleLabel.text = @"领养条件";
    cell.conditionLabel.text = @"1、‌年龄要求‌：领养者必须年满18周岁，具备完全民事行为能力。\n2、‌经济能力‌：领养者需要有稳定的收入来源，能够承担宠物的饮食、医疗、疫苗接种等费用。\n3、居住条件‌：需要有固定的住所，最好是自住房或整租房，确保有足够的空间让宠物活动，并且居住地不在禁止养宠物。\n4、家庭支持‌：领养前需要与家人沟通，确保家人同意并支持养宠物，避免因家庭变动等原因抛弃宠物。\n5、法律合规‌：需要按规定为宠物办理相关证件，如犬类准养证，确保合法养宠。\n6、领养宠物会给生活带来一定的变化，如需要定期清理宠物的排泄物、处理宠物的毛发等。领养者需要做好充分的准备，接受并适应这些变化。";
}
@end
