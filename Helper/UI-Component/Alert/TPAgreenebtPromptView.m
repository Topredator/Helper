//
//  TPCommonPromptBox.m
//  Helper
//
//  Created by Topredator on 2025/3/16.
//

#import "TPAgreenebtPromptView.h"

@interface TPAgreenebtPromptView () <TPTextDisplayViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleLine;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) TPTextDisplayView *displayView;
@property (nonatomic, strong) UIView *contentLine;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) MASConstraint *centerY;
@end

@implementation TPAgreenebtPromptView
+ (instancetype)view {
    TPAgreenebtPromptView *view = [[TPAgreenebtPromptView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, TPUI.tp_screenHeight)];
    return view;
}

- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.bgView];
    [self addSubview:self.container];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.titleLine];
    
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.selectBtn];
    [self.container addSubview:self.displayView];
    [self.container addSubview:self.contentLine];
    
    [self.container addSubview:self.cancleBtn];
    [self.container addSubview:self.line];
    [self.container addSubview:self.sureBtn];
}
- (void)makeConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        self.centerY = make.centerY.mas_equalTo(TPUI.tp_screenHeight);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    [self.titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.equalTo(self.titleLine.mas_bottom).offset(20);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentLabel.mas_left);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
    }];
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn.mas_centerY);
        make.left.equalTo(self.selectBtn.mas_right).offset(12);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo([TPTextDisplayView getHeightWithText:[self agreementText] rectSize:CGSizeMake(TPUI.tp_screenWidth - 60 - 20 - 12 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
    }];
    [self.contentLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.equalTo(self.contentLine.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancleBtn.mas_right);
        make.top.equalTo(self.contentLine.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.left.equalTo(self.line.mas_right);
        make.top.equalTo(self.contentLine.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.equalTo(self.cancleBtn.mas_width);
    }];
}
- (void)configTitle:(NSString *)title content:(NSString *)content {
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}
- (void)show {
    [self showIn:TPAppDelegate().window];
}
- (void)showIn:(UIView *)view {
    if (!view) return;
    
    [view addSubview:self];
    [self setupSubviews];
    [self makeConstraints];
    [self layoutIfNeeded];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.25 animations:^{
        self.centerY.mas_equalTo(0);
        [self layoutIfNeeded];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.25
                     animations:^{
        self.centerY.mas_equalTo(TPUI.tp_screenHeight);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)sureBtnAction {
    if (!self.selectBtn.selected) {
        [self tp_toast:@"请选中同意协议"];
        return;
    }
    if (self.callback) self.callback();
    [self dismiss];
}
- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}
#pragma mark ==================  TPTextDisplayViewDelegate   ==================
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView labelType:(TPRichTextLabelType)labelType content:(NSString *)content {
    TPBaseWebVC *webVC = [TPBaseWebVC new];
    webVC.fileName = @"adopt_agreement.html";
    [TPUINavigator pushViewController:webVC animated:YES];
}
- (NSString *)agreementText {
    return @"阅读并同意${《领养协议》}";
}
#pragma mark ==================  Getter   ==================
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [TPUI tp_t:0 alpha:0.5];
    }
    return _bgView;
}
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.backgroundColor = UIColor.whiteColor;
        _container.layer.cornerRadius = 8;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = TPHelperLightDarkTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textColor = TPHelperLightDarkTextColor;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
- (UIView *)titleLine {
    if (!_titleLine) {
        _titleLine = [[UIView alloc] initWithFrame:CGRectZero];
        _titleLine.backgroundColor = [TPUI tp_t:204];
    }
    return _titleLine;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"agreement_unselected"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"agreement_selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
- (TPTextDisplayView *)displayView {
    if (!_displayView) {
        _displayView = [[TPTextDisplayView alloc] initWithFrame:CGRectZero];
        _displayView.text = [self agreementText];
        _displayView.delegate = self;
        _displayView.backgroundColor = UIColor.whiteColor;
        TPRichTextLabelConfig *config = [TPRichTextLabelConfig new];
        config.keyColor = TPHelperThemeColor;
        _displayView.config = config;
    }
    return _displayView;
}
- (UIView *)contentLine {
    if (!_contentLine) {
        _contentLine = [[UIView alloc] initWithFrame:CGRectZero];
        _contentLine.backgroundColor = [TPUI tp_t:204];
    }
    return _contentLine;
}
- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:TPHelperLightDarkTextColor forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [TPUI tp_t:204];
    }
    return _line;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
