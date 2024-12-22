//
//  TPAuthLogoRow.m
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import "TPAuthLogoRow.h"
#import "FBShimmeringView.h"

@interface TPAuthLogoCell : TPUIBaseTableViewCell
@property (nonatomic, strong) FBShimmeringView *shimmeringView;
@property (nonatomic, strong) UIView *logoView;
@property (nonatomic, strong) UILabel *logoLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation TPAuthLogoCell
- (void)setupSubviews {
    [self.contentView addSubview:self.shimmeringView];
    [self.logoView addSubview:self.logoLabel];
    [self.logoView addSubview:self.line];
    [self.logoView addSubview:self.nameLabel];
}
- (void)makeConstraints {
    [self.shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
    }];
    self.shimmeringView.contentView = self.logoView;
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    NSString *logoString = @"Animal helper";
    NSMutableAttributedString *logoAttributedString = [logoString tp_mutableAttributedStringWithAttributes:@[
        [TPFontAttributeConfig tp_font:[TPUI tp_font:35 weight:FontLight] range:NSMakeRange(0, logoString.length)],
        [TPForegroundColorAttributeConfig tp_color:[UIColor.blackColor colorWithAlphaComponent:0.8] range:NSMakeRange(0, logoString.length)],
        [TPForegroundColorAttributeConfig tp_color:TPHelperThemeColor range:NSMakeRange(1, 1)]
    ]];
    self.logoLabel.attributedText = logoAttributedString;
    
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoLabel.mas_bottom).offset(3);
        make.left.equalTo(self.logoLabel.mas_left);
        make.right.equalTo(self.logoLabel.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.line.mas_bottom).offset(3);
        make.bottom.mas_equalTo(0);
    }];
}
#pragma mark----------------- Getter -----------------
- (UIView *)logoView {
    if (!_logoView) {
        _logoView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _logoView;
}
- (UILabel *)logoLabel {
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _logoLabel;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.7];
    }
    return _line;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"Dexterly";
        _nameLabel.font = [TPUI tp_font:15 weight:FontRegular];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor.grayColor colorWithAlphaComponent:0.8];
    }
    return _nameLabel;
}
- (FBShimmeringView *)shimmeringView {
    if (!_shimmeringView) {
        _shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 120, TPUI.tp_screenWidth, 56.5)];
        _shimmeringView.shimmering                  = YES;
        _shimmeringView.shimmeringBeginFadeDuration = 0.8;
        _shimmeringView.shimmeringOpacity           = 0.4f;
        _shimmeringView.shimmeringAnimationOpacity  = 1.f;
    }
    return _shimmeringView;
}
@end

@implementation TPAuthLogoRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPAuthLogoCell.class];
    }
    return self;
}
@end
