//
//  TPDiaryDetailVC.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPDiaryDetailVC.h"

@interface TPDiaryDetailVC ()
@property (nonatomic, strong) UIScrollView *bgScroll;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation TPDiaryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"日记详情";
    
    self.logoImage.image = [UIImage imageNamed:self.diaryModel.image];
    self.avatarImage.image = [UIImage imageNamed:self.diaryModel.user.avatar];
    self.nameLabel.text = self.diaryModel.user.name;
    self.titleLabel.text = self.diaryModel.title;
    self.contentLabel.text = self.diaryModel.content;
    
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.bgScroll];
    [self.bgScroll addSubview:self.contentView];
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.nameLabel];
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
        make.height.mas_equalTo(TPUI.tp_screenWidth);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.top.equalTo(self.logoImage.mas_bottom).offset(20);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.avatarImage.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_bottom).offset(30);
        make.left.equalTo(self.avatarImage.mas_left);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.equalTo(self.avatarImage.mas_left);
        make.right.mas_equalTo(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}
#pragma mark----------------- Getter -----------------
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
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 40;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [TPUI tp_font:15 weight:FontMedium];
        _nameLabel.textColor = TPHelperDarkGrayTextColor;
    }
    return _nameLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:20 weight:FontSemibold];
        _titleLabel.textColor = TPHelperDarkTextColor;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [TPUI tp_font:18 weight:FontRegular];
        _contentLabel.textColor = TPHelperLightDarkTextColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
