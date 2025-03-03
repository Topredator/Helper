//
//  TPAdoptPublisherRow.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAnimalPublisherRow.h"

@interface TPAnimalPublisherCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) TPUserModel *model;
@end

@implementation TPAnimalPublisherCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneBtn];
}
- (void)makeConstraints {
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.right.equalTo(self.phoneBtn.mas_left).offset(-20);
    }];
}
- (void)configWithModel:(TPUserModel *)model {
    self.model = model;
    self.avatarImage.image = [UIImage imageNamed:model.avatar];
    self.nameLabel.text = model.name;
}
- (void)phoneBtnAction {
    @weakify(self);
    [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
        @strongify(self);
        make.title(@"发布者电话");
        make.addOption(TPUIAlertBlockOption(self.model.account, ^{
            @strongify(self);
            NSString *telURL = [NSString stringWithFormat:@"tel:%@", self.model.account];
                NSURL *url = [NSURL URLWithString:telURL];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
        }));
        make.cancleOption(@"取消");
    }];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 25;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _nameLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _nameLabel;
}
- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_phoneBtn setImage:[UIImage imageNamed:@"adopt_publisher_phone"] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}
@end

@interface TPAnimalPublisherRow ()
@property (nonatomic, strong) TPUserModel *model;
@end

@implementation TPAnimalPublisherRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAnimalPublisherCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPUserModel *)model {
    TPAnimalPublisherRow *row = [TPAnimalPublisherRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPAnimalPublisherCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.model];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 70;
}
@end
