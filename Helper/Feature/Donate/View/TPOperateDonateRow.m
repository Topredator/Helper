//
//  TPOperateDonateRow.m
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import "TPOperateDonateRow.h"

@interface TPOperateDonateCell ()
@property (nonatomic, strong) TPTextDisplayView *displayView;
@property (nonatomic, strong) UIImageView *arrowImage;
@end

@implementation TPOperateDonateCell
- (void)setupSubviews {
    [super setupSubviews];
    self.container.backgroundColor = UIColor.whiteColor;
    [self.container addSubview:self.displayView];
    [self.container addSubview:self.arrowImage];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 10, 20, 40));
    }];
}
- (void)configWithModel:(TPDonateOperate *)operate isMine:(BOOL)isMine {
    NSString *content = [NSString stringWithFormat:@"${ 我 } 捐赠了 <at value='%@'>%@</at> 的宠物 <subject value='%@'>%@</subject>", operate.donate.donee.userId, operate.donate.donee.name, operate.donate.animal.animalId, operate.donate.animal.name];
    if (!isMine) {
        content = [NSString stringWithFormat:@"<at value='%@'>%@</at> 捐赠了 <at value='%@'>%@</at> 的宠物 <subject value='%@'>%@</subject>", operate.donate.donater.userId, operate.donate.donater.name, operate.donate.donee.userId, operate.donate.donee.name, operate.donate.animal.animalId, operate.donate.animal.name];
    }
    self.displayView.text = content;
    [self.displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 30 - 10 - 10 - 20 - 10, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
    }];
}

#pragma mark ==================  Getter   ==================
- (TPTextDisplayView *)displayView {
    if (!_displayView) {
        _displayView = [[TPTextDisplayView alloc] initWithFrame:CGRectZero];
        _displayView.backgroundColor = UIColor.whiteColor;
        TPRichTextLabelConfig *config = [TPRichTextLabelConfig new];
        config.keyColor = TPHelperThemeColor;
        _displayView.config = config;
    }
    return _displayView;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImage;
}
@end


@interface TPOperateDonateRow () <TPTextDisplayViewDelegate>

@end

@implementation TPOperateDonateRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPOperateDonateCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPDonateOperate *)operate {
    TPOperateDonateRow *row = [TPOperateDonateRow row];
    row.operate = operate;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPOperateDonateCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.operate isMine:self.isMine];
    cell.displayView.delegate = self;
}
#pragma mark ==================  TPTextDisplayViewDelegate   ==================
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView labelType:(TPRichTextLabelType)labelType content:(NSString *)content {
    
}
@end
