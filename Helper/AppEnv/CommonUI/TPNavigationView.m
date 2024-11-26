//
//  TPNavigationView.m
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import "TPNavigationView.h"
#import "TPLineView.h"
@interface TPNavigationView ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TPLineView *lineView;
@property (nonatomic, strong) UIView *line;
@end

@implementation TPNavigationView
+ (instancetype)normalView {
    TPNavigationView *navigationView = [self new];
    navigationView.backBtn.hidden = YES;
    return navigationView;
}
+ (instancetype)backView {
    TPNavigationView *navigationView = [self new];
    navigationView.backBtn.hidden = NO;
    return navigationView;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    [self addSubview:self.lineView];
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(8);
        make.bottom.mas_equalTo(-2);
    }];

    __weak typeof(self) weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(0).priorityHigh();
        make.bottom.mas_equalTo(-7);
        make.left.greaterThanOrEqualTo(weakSelf.backBtn.mas_right).offset(20);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setAttributeTitle:(NSAttributedString *)attributeTitle {
    _attributeTitle = attributeTitle;
    self.titleLabel.attributedText = attributeTitle;
}
- (void)backBtnAction {
    if (self.backAction) {
        self.backAction();
    } else {
        [[TPUINavigator currentNavigationController] popViewControllerAnimated:YES];
    }
}
- (void)setShowLines:(BOOL)showLines {
    _showLines = showLines;
    self.lineView.hidden = !showLines;
}
#pragma mark----------------- Getter -----------------
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backBtn setImage:[UIImage imageNamed:@"tp_common_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor = UIColor.clearColor;
    }
    return _backBtn;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font            = [TPUI tp_font:20 weight:FontMedium];
        _titleLabel.textColor       = [UIColor.blackColor colorWithAlphaComponent:0.8];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = UIColor.clearColor;
    }
    return _titleLabel;
}
- (TPLineView *)lineView {
    if (!_lineView) {
        _lineView = [TPLineView createWithLineWidth:4 lineGap:4 lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.05] rotate:45];
        _lineView.hidden = YES;
    }
    return _lineView;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.25];
    }
    return _line;
}
@end
