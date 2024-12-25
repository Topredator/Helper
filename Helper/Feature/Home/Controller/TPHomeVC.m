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
#import "TPDiaryModule.h"
#import "TPDiaryDetailVC.h"

@interface TPHomeVC ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) TPHomeBannerSection *bannerSection;
@property (nonatomic, strong) TPHomeLifeDiarySection *diarySection;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation TPHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = 20;
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
            [self loadData];
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
    self.bannerSection = [TPHomeBannerSection sectionWithBanners:@[
        [TPHomeBannerModel bannerWithName:@"banner_1"],
        [TPHomeBannerModel bannerWithName:@"banner_2"],
        [TPHomeBannerModel bannerWithName:@"banner_3"],
        [TPHomeBannerModel bannerWithName:@"banner_4"],
        [TPHomeBannerModel bannerWithName:@"banner_5"]
    ]];
    [self.collectionView.TPProxy reloadData:@[self.bannerSection]];
    
    // 获取日记
    [TPDBRouter sendTaskMessage:TPDiaryFetchDatas argument:@{
        @"pageNo": @(1),
        @"pageSize": @(self.pageSize)
    }];
}
- (void)moreData {
    // 获取日记
    [TPDBRouter sendTaskMessage:TPDiaryFetchDatas argument:@{
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(self.pageSize)
    }];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPDiaryFetchDatas ||
        messageType == TPDiaryFetchMoreDatas) {
        NSArray *tempArray = (NSArray *)argument;
        
        [self.collectionView tp_hideBlankView];
        
        if (messageType == TPDiaryFetchDatas) {
            self.pageNo = 1;
            if (!tempArray.count) {
                TPUIImageBlankView *blankView = [self.collectionView tp_commonEmptyData];
                blankView.topOffset = 350;
            }
            [self.diarySection removeAllObjects];
        } else {
            self.pageNo += 1;
            if (self.diarySection.count <= 0) {
                TPUIImageBlankView *blankView = [self.collectionView tp_commonEmptyData];
                blankView.topOffset = 350;
            }
        }
        
        if (tempArray.count > 0) {
            for (NSDictionary *dic in tempArray) {
                TPUserModel *userModel = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
                TPDiaryModel *dailyModel = [TPDiaryModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_DIARY]];
                dailyModel.user = userModel;
                [self.diarySection addObject:[self rowWithModel:dailyModel]];
            }
        }
        
        if (tempArray.count < 20) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView.mj_header endRefreshing];
        if (!self.bannerSection) {
            [self.collectionView.TPProxy reloadData:@[self.diarySection]];
        } else {
            [self.collectionView.TPProxy reloadData:@[self.bannerSection, self.diarySection]];
        }
        return YES;
    }
    return NO;
}
- (TPHomeLifeDiaryRow *)rowWithModel:(TPDiaryModel *)model {
    TPHomeLifeDiaryRow *row = [TPHomeLifeDiaryRow rowWithModel:model];
    row.didSelectedBlock = ^(__kindof TPCollectionRow * _Nonnull rowData, TPCollectionViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPDiaryDetailVC *detailVC = [TPDiaryDetailVC new];
        detailVC.diaryModel = model;
        [[TPUINavigator currentNavigationController] pushViewController:detailVC animated:YES];
    };
    return row;
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
- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = @[].mutableCopy;
    }
    return _sections;
}
- (TPHomeBannerSection *)bannerSection {
    if (!_bannerSection) {
        _bannerSection = [TPHomeBannerSection section];
    }
    return _bannerSection;
}
- (TPHomeLifeDiarySection *)diarySection {
    if (!_diarySection) {
        _diarySection = [TPHomeLifeDiarySection section];
    }
    return _diarySection;
}
@end
