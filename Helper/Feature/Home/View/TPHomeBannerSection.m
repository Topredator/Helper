//
//  TPHomeBannerSection.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeBannerSection.h"
#import "TPBaseCollectionSectionView.h"
#import "TPHomeBannerPage.h"
#import "TPHelpDetailVC.h"

@interface TPHomeBannerSectionHeaderView : TPBaseCollectionSectionView <TPUIBannerViewDelegate>
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) TPUIBannerView *bannerView;
@property (nonatomic, copy) NSArray *datas;
@end
@implementation TPHomeBannerSectionHeaderView
- (void)setupSubviews {
    self.layer.masksToBounds = YES;
    [self addSubview:self.bgImage];
    [self addSubview:self.bannerView];
}
- (void)makeConstraints {
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark----------------- TPUIBannerViewDelegate -----------------
- (NSInteger)numberOfPagesForBannerView:(TPUIBannerView *)bannerView {
    return self.datas.count;
}
- (TPUIBannerPageView *)bannerView:(TPUIBannerView *)banner viewForPageIndex:(NSInteger)pageIndex {
    TPHomeBannerPage *pageView = [banner dequeueReusablePageWithIdentifier:@"homeBanner"];
    if (!pageView) {
        pageView = [[TPHomeBannerPage alloc] initWithReuseIdentifier:@"homeBanner"];
    }
    TPHomeBannerModel *model = [self.datas tp_ObjectAtIndex:pageIndex];
    [pageView configWithModel:model];
    return pageView;
}
- (BOOL)bannerView:(TPUIBannerView *)bannerView canPageViewSelectedAtPageIndex:(NSInteger)pageIndex {
    return YES;
}
- (void)bannerView:(TPUIBannerView *)bannerView didSelectedAtPageIndex:(NSInteger)pageIndex {
    TPHomeBannerModel *model = [self.datas tp_ObjectAtIndex:pageIndex];
    if (model.publishModel.type == 0) { // 链接
        TPBaseWebVC *webVC = [TPBaseWebVC new];
        webVC.url = model.publishModel.content;
        [TPUINavigator pushViewController:webVC animated:YES];
    } else { // 图文
        
    }
}
- (void)configWithBanners:(NSArray <TPHomeBannerModel *>*)banners {
    if (!banners.count) {
        self.datas = @[];
        [self.bannerView stopTimer];
        self.bannerView.hidden = YES;
        return;
    }
    self.bannerView.hidden = NO;
    self.datas = banners;
    [self.bannerView reloadData];
    [self.bannerView startTimerWithTimeInterval:3];
}
#pragma mark----------------- Getter -----------------
- (UIImageView *)bgImage {
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg_image"]];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImage;
}
- (TPUIBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[TPUIBannerView alloc] initWithFrame:CGRectZero];
        _bannerView.delegate = self;
        _bannerView.isCarousel = YES;
        _bannerView.pageControl.pageIndicatorTintColor = UIColor.whiteColor;
        _bannerView.pageControl.currentPageIndicatorTintColor = TPHelperThemeColor;
    }
    return _bannerView;
}
@end

@interface TPHomeBannerSection ()
@property (nonatomic, weak) TPHomeBannerSectionHeaderView *headerView;
@end

@implementation TPHomeBannerSection
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setHeaderClass:TPHomeBannerSectionHeaderView.class];
    }
    return self;
}
+ (instancetype)sectionWithBanners:(NSArray <TPHomeBannerModel *>*)banners {
    TPHomeBannerSection *section = [self section];
    section.banners = banners;
    return section;
}
- (void)setBanners:(NSArray<TPHomeBannerModel *> *)banners {
    _banners = banners;
    if (self.headerView) {
        [self.headerView configWithBanners:banners];
    }
}
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return CGSizeMake(TPUI.tp_screenWidth, 200);
}
- (void)tp_collectionViewHeader:(TPHomeBannerSectionHeaderView *)header preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section {
    self.headerView = header;
    [header configWithBanners:self.banners];
}
@end
