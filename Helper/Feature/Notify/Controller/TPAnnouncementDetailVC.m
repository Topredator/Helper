//
//  TPAnnouncementDetailVC.m
//  Helper
//
//  Created by Topredator on 2025/3/19.
//

#import "TPAnnouncementDetailVC.h"

@interface TPAnnouncementDetailVC ()
@property (nonatomic, strong) UIScrollView *bgScroll;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation TPAnnouncementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"公告详情";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.bgScroll];
    [self.bgScroll addSubview:self.contentView];
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.bgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(TPUI.tp_topBarHeight, 0, 0, 0));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.equalTo(self.bgScroll.mas_width);
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.logoImage.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-10);
    }];
}
- (void)loadData {
    self.logoImage.image = [UIImage imageNamed:self.publishModel.image];
    self.titleLabel.text = self.publishModel.title;
    self.contentLabel.text = self.publishModel.content;
}
#pragma mark ==================  Getter   ==================
- (UIScrollView *)bgScroll {
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _bgScroll.showsVerticalScrollIndicator  = NO;
    }
    return _bgScroll;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImage;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = TPHelperDarkTextColor;
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
    }
    return _contentLabel;
}
@end
