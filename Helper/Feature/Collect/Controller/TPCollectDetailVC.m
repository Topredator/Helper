//
//  TPCollectDetailVC.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectDetailVC.h"
#import "TPCollectModule.h"
#import "TPCommonTitleSection.h"
#import "TPAnimalCategoryRow.h"

@interface TPCollectDetailVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIButton *uncollectBtn;
@end

@implementation TPCollectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"收藏详情";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.headerView addSubview:self.avatarImage];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableview.tableHeaderView = self.headerView;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 0.01)];
    
    [self.navigationView addSubview:self.uncollectBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.uncollectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.mas_equalTo(-2);
    }];
}
- (void)loadData {
    self.avatarImage.image = [UIImage imageNamed:self.collectModel.animal.thumbImage];
    TPCommonTitleSection *section = [TPCommonTitleSection sectionWithTitle:self.collectModel.animal.name];
    [section addObject:[TPAnimalCategoryRow rowWithModel:self.collectModel.animal]];
    [self reloadData:@[section]];
}
- (void)uncollectBtnAction {
    @weakify(self);
    [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
        make.title(@"取消收藏").message(@"您确定取消收藏吗？");
        make.addOption(TPUIAlertBlockOption(@"确定", ^{
            @strongify(self);
            [TPDBRouter sendTaskMessage:TPCollectMododuleRemoveCollect argument:self.collectModel.animal.animalId];
        }));
        make.addOption(TPUIAlertColorOption(@"取消", ^{
            
        }, TPHelperLightDarkTextColor));
    }];
    
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPCollectMododuleRemoveCollect) {
        [TPAppDelegate().window tp_toast:@"取消收藏成功"];
        [TPUINavigator popViewControllerWithTimes:1 animated:YES];
    }
    return NO;
}
#pragma mark----------------- Getter -----------------
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, TPUI.tp_screenWidth)];
        _headerView.backgroundColor = UIColor.whiteColor;
    }
    return _headerView;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _avatarImage;
}
- (UIButton *)uncollectBtn {
    if (!_uncollectBtn) {
        _uncollectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_uncollectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_uncollectBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _uncollectBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_uncollectBtn addTarget:self action:@selector(uncollectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uncollectBtn;
}
@end
