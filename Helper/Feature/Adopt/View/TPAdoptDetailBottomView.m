//
//  TPAdoptDetailBottomView.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAdoptDetailBottomView.h"

@interface TPAdoptDetailBottomView ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) TPUISimButton *collectBtn;
@property (nonatomic, strong) UIButton *wantAdoptBtn;
@end

@implementation TPAdoptDetailBottomView
- (void)setupSubviews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.line];
    [self addSubview:self.collectBtn];
    [self addSubview:self.wantAdoptBtn];
}
- (void)makeConstraints {
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(0.6);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.top.mas_equalTo(10);
    }];
    [self.wantAdoptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.top.mas_equalTo(10);
    }];
}
- (void)collectBtnAction {
    if (self.collectionCallback) self.collectionCallback();
}
- (void)wantAdoptBtnAction {
    if (self.wantAdoptCallback) self.wantAdoptCallback();
}
- (void)configCollected:(BOOL)isCollected {
    self.collectBtn.selected = isCollected;
    self.collectBtn.layer.borderColor = isCollected ? TPHelperThemeColor.CGColor : TPHelperDarkGrayTextColor.CGColor;
}
#pragma mark----------------- Getter -----------------
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = TPHelperLightDarkTextColor;
    }
    return _line;
}
- (TPUISimButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _collectBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _collectBtn.iconTextMargin = 5;
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:TPHelperDarkGrayTextColor forState:UIControlStateNormal];
        [_collectBtn setTitleColor:TPHelperThemeColor forState:UIControlStateSelected];
        [_collectBtn setImage:[UIImage imageNamed:@"adopt_not_collect"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"adopt_collected"] forState:UIControlStateSelected];
        _collectBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _collectBtn.layer.borderColor = TPHelperDarkGrayTextColor.CGColor;
        _collectBtn.layer.borderWidth = 0.6;
        _collectBtn.layer.cornerRadius = 22;
        _collectBtn.layer.masksToBounds = YES;
    }
    return _collectBtn;
}
- (UIButton *)wantAdoptBtn {
    if (!_wantAdoptBtn) {
        _wantAdoptBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_wantAdoptBtn setTitle:@"想领养" forState:UIControlStateNormal];
        [_wantAdoptBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_wantAdoptBtn addTarget:self action:@selector(wantAdoptBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _wantAdoptBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _wantAdoptBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        _wantAdoptBtn.layer.borderWidth = 0.6;
        _wantAdoptBtn.layer.cornerRadius = 22;
        _wantAdoptBtn.layer.masksToBounds = YES;
    }
    return _wantAdoptBtn;
}
@end
