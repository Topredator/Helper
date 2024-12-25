//
//  TPHomeBannerSection.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeBannerSection.h"
#import "TPBaseCollectionSectionView.h"
#import "TPHomeBannerPage.h"

@interface TPHomeBannerSectionHeaderView : TPBaseCollectionSectionView <TPUIBannerViewDelegate>
@property (nonatomic, strong) TPUIBannerView *bannerView;
@property (nonatomic, copy) NSArray *datas;
@end
@implementation TPHomeBannerSectionHeaderView
- (void)setupSubviews {
    [self addSubview:self.bannerView];
}
- (void)makeConstraints {
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
    
}
- (void)configWithBanners:(NSArray <TPHomeBannerModel *>*)banners {
    self.datas = banners;
    [self.bannerView reloadData];
    [self.bannerView startTimerWithTimeInterval:3];
}
#pragma mark----------------- Getter -----------------
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
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return CGSizeMake(TPUI.tp_screenWidth, 200);
}
- (void)tp_collectionViewHeader:(TPHomeBannerSectionHeaderView *)header preparedWithProxy:(TPCollectionViewProxy *)proxy section:(NSUInteger)section {
    [header configWithBanners:self.banners];
}
@end
