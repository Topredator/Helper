//
//  TPMineFunctionRow.m
//  Helper
//
//  Created by Topredator on 2024/12/19.
//

#import "TPMineFunctionRow.h"

@interface TPMineFunctionCell : TPUIBaseTableViewCell
/// 发布
@property (nonatomic, strong) TPUISimButton *publicBtn;
/// 收藏
@property (nonatomic, strong) TPUISimButton *collectBtn;
/// 捐赠
@property (nonatomic, strong) TPUISimButton *donateBtn;
@end

@implementation TPMineFunctionCell
- (void)setupSubviews {
    [self.contentView addSubview:self.publicBtn];
    [self.contentView addSubview:self.collectBtn];
    [self.contentView addSubview:self.donateBtn];
}
- (void)makeConstraints {
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
    [self.publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(55);
        make.right.equalTo(self.collectBtn.mas_left).offset(-20);
        make.width.equalTo(self.collectBtn.mas_width);
    }];
    [self.donateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(55);
        make.left.equalTo(self.collectBtn.mas_right).offset(20);
        make.right.mas_equalTo(-20);
        make.width.equalTo(self.collectBtn.mas_width);
    }];
}
#pragma mark----------------- Getter -----------------
- (TPUISimButton *)publicBtn {
    if (!_publicBtn) {
        _publicBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _publicBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _publicBtn.iconTextMargin = 10;
        [_publicBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_publicBtn setImage:[UIImage imageNamed:@"mine_public"] forState:UIControlStateNormal];
        [_publicBtn setTitleColor:[TPUI tp_r:39 g:119 b:248] forState:UIControlStateNormal];
        _publicBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _publicBtn.layer.cornerRadius = 5;
        _publicBtn.layer.masksToBounds = YES;
        _publicBtn.layer.borderWidth = 1;
        _publicBtn.layer.borderColor = [TPUI tp_r:39 g:119 b:248].CGColor;
    }
    return _publicBtn;
}
- (TPUISimButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _collectBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _collectBtn.iconTextMargin = 10;
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"mine_collect"] forState:UIControlStateNormal];
        [_collectBtn setTitleColor:[TPUI tp_r:39 g:119 b:248] forState:UIControlStateNormal];
        _collectBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _collectBtn.layer.cornerRadius = 5;
        _collectBtn.layer.masksToBounds = YES;
        _collectBtn.layer.borderWidth = 1;
        _collectBtn.layer.borderColor = [TPUI tp_r:39 g:119 b:248].CGColor;
    }
    return _collectBtn;
}
- (TPUISimButton *)donateBtn {
    if (!_donateBtn) {
        _donateBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _donateBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _donateBtn.iconTextMargin = 10;
        [_donateBtn setTitle:@"捐赠" forState:UIControlStateNormal];
        [_donateBtn setImage:[UIImage imageNamed:@"mine_donate"] forState:UIControlStateNormal];
        [_donateBtn setTitleColor:[TPUI tp_r:39 g:119 b:248] forState:UIControlStateNormal];
        _donateBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        _donateBtn.layer.cornerRadius = 5;
        _donateBtn.layer.masksToBounds = YES;
        _donateBtn.layer.borderWidth = 1;
        _donateBtn.layer.borderColor = [TPUI tp_r:39 g:119 b:248].CGColor;
    }
    return _donateBtn;
}
@end

@implementation TPMineFunctionRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPMineFunctionCell.class];
    }
    return self;
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
