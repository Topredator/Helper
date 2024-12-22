//
//  TPTopicVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPHomeVC.h"
#import "TPHomeBannerModel.h"
#import "TPHomeBannerSection.h"
#import "TPHomeLifeDiarySection.h"
#import "TPHomeLifeDiaryRow.h"
@interface TPHomeVC ()
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TPHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *string = @"Home";
//    NSMutableAttributedString *attString = [string tp_mutableAttributedStringWithAttributes:@[
//        [TPFontAttributeConfig tp_font:[TPUI tp_font:20 weight:FontMedium] range:NSMakeRange(0, string.length)],
//        [TPForegroundColorAttributeConfig tp_color:[UIColor.blackColor colorWithAlphaComponent:0.5] range:NSMakeRange(0, string.length)],
//        [TPForegroundColorAttributeConfig tp_color:TPHelperThemeColor range:NSMakeRange(0, 1)]
//    ]];
    self.navigationView.title = @"首页";
    [self loadData];
}

- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.collectionView];
    @weakify(self);
    self.collectionView.mj_header =  [TPUIRefreshHeader headerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self.collectionView.mj_header endRefreshing];
        } afterDelaySecs:2];
    }];
    self.collectionView.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            [self.collectionView.mj_footer endRefreshing];
        } afterDelaySecs:2];
    }];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}
- (void)loadData {
    TPHomeBannerSection *bannerSection = [TPHomeBannerSection sectionWithBanners:@[
        [TPHomeBannerModel bannerWithName:@"banner_1"],
        [TPHomeBannerModel bannerWithName:@"banner_2"],
        [TPHomeBannerModel bannerWithName:@"banner_3"],
        [TPHomeBannerModel bannerWithName:@"banner_4"],
        [TPHomeBannerModel bannerWithName:@"banner_5"]
    ]];
    TPHomeLifeDiarySection *diarySection = [TPHomeLifeDiarySection section];
    for (NSInteger i = 0; i < 20; i++) {
        [diarySection addObject:[TPHomeLifeDiaryRow row]];
    }
    [self.collectionView.TPProxy reloadData:@[bannerSection, diarySection]];
}
#pragma mark----------------- Getter -----------------
- (UICollectionView *)collectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.TPProxy = [TPCollectionViewProxy proxyWithCollectionView:_collectionView];
    }
    return _collectionView;
}
@end
