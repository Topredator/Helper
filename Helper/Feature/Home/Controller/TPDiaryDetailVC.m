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
@property (nonatomic, strong) UIView *imageContainer;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *removeBtn;
@end

@implementation TPDiaryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"日记详情";
    [self refreshUI];
    self.avatarImage.image = [UIImage imageNamed:self.publishModel.user.avatar];
    self.nameLabel.text = self.publishModel.user.name;
    self.titleLabel.text = self.publishModel.title;
    self.contentLabel.text = self.publishModel.content;
    self.removeBtn.hidden = ![TPUserManager.manager.user.userId isEqualToString:self.publishModel.user.userId];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.navigationView addSubview:self.removeBtn];
    [self.view addSubview:self.bgScroll];
    [self.bgScroll addSubview:self.contentView];
    [self.contentView addSubview:self.imageContainer];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
    }];
    [self.bgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(TPUI.tp_topBarHeight, 0, 0, 0));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.equalTo(self.bgScroll.mas_width);
    }];
    [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.top.equalTo(self.imageContainer.mas_bottom).offset(20);
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
- (void)refreshUI {
    [self.imageContainer tp_removeAllSubviews];
    NSArray *images = [NSArray tp_modelWithJSON:self.publishModel.detailImages];
    if (images.count > 1) {
        NSInteger left = 0, top = 0;
        CGFloat width = (TPUI.tp_screenWidth - 40) / 3;
        UIImageView *lastView = nil;
        for (NSInteger i = 0; i < images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
            [self.imageContainer addSubview:imageView];
            left = (i % 3) * (width + 10);
            top = (i / 3) * (width + 10);
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
                make.top.mas_equalTo(top);
                make.size.mas_equalTo(CGSizeMake(width, width));
            }];
            lastView = imageView;
        }
        [self.imageContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom);
        }];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images.firstObject]];
        [self.imageContainer addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(TPUI.tp_screenWidth);
        }];
    }
}
- (void)removeBtnAction {
    [TPUIAlert alertShow:^(TPUIAlertMaker *make) {
        make.title(@"删除日记").message(@"您确定删除吗?");
        make.cancleOption(@"取消");
        make.addOption(TPUIAlertColorOption(@"确定", ^{
            [TPDBRouter sendTaskMessage:TPPublishDeleteDiary argument:self.publishModel.publishId];
        }, TPHelperThemeColor));
    }];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPPublishDeleteDiary) {
        [TPAppDelegate().window tp_toast:@"日记删除成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    return NO;
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
- (UIView *)imageContainer {
    if (!_imageContainer) {
        _imageContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _imageContainer.backgroundColor = TPHelperDefaultBgColor;
    }
    return _imageContainer;
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
- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_removeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_removeBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _removeBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        [_removeBtn addTarget:self action:@selector(removeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}
@end
