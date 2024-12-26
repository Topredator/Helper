//
//  TPAdoptDetailVC.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPAdoptDetailVC.h"
#import "TPAdoptCategoryRow.h"
#import "TPCommonTitleSection.h"
#import "TPAdoptIntroduceRow.h"
#import "TPAdoptPublisherRow.h"
#import "TPAdoptDetailBottomView.h"

@interface TPAdoptDetailVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) TPAdoptDetailBottomView *bottomView;
@end

@implementation TPAdoptDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"领养详情";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.bottomView];
    [self.headerView addSubview:self.avatarImage];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableview.tableHeaderView = self.headerView;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 0.01)];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-64 - TPUI.tp_bottomSafeAreaHeight);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.tableview.mas_bottom);
    }];
}
- (void)operationAction {
    // 收藏回调
    self.bottomView.collectionCallback = ^{
        
    };
    // 想领养回调
    self.bottomView.wantAdoptCallback = ^{
        
    };
}
- (void)loadData {
    self.avatarImage.image = [UIImage imageNamed:self.adoptModel.animal.thumbImage];
    TPCommonTitleSection *section = [TPCommonTitleSection sectionWithTitle:self.adoptModel.animal.name];
    [section addObject:[TPAdoptCategoryRow rowWithModel:self.adoptModel.animal]];
    [section addObject:[TPAdoptIntroduceRow row]];
    
    TPCommonTitleSection *publicSection = [TPCommonTitleSection sectionWithTitle:@"发布者"];
    [publicSection addObject:[TPAdoptPublisherRow rowWithModel:self.adoptModel.publisher]];
    
    [self reloadData:@[section, publicSection]];
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
- (TPAdoptDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [TPAdoptDetailBottomView view];
    }
    return _bottomView;
}
@end
