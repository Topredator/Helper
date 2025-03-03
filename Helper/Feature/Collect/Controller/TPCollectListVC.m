//
//  TPCollectListVC.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectListVC.h"
#import "TPCollectListSection.h"
#import "TPCollectRow.h"
#import "TPCollectModule.h"
#import "TPCollectModel.h"
#import "TPCollectDetailVC.h"
@interface TPCollectListVC ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TPCollectListSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation TPCollectListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    self.navigationView.title = @"我的收藏";
    // Do any additional setup after loading the view.
    @weakify(self);
    self.collectionView.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    self.collectionView.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreData];
    }];
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.collectionView];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPCollectModuleFetchUserCollectDatas argument:@{
        @"pageNo": @(1),
        @"pageSize": @(20),
        @"userId": TPUserManager.manager.user.userId
    }];
}
- (void)moreData {
    [TPDBRouter sendTaskMessage:TPCollectModuleFetchUserCollectDatas argument:@{
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(20),
        @"userId": TPUserManager.manager.user.userId
    }];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPCollectModuleFetchUserCollectDatas ||
        messageType == TPCollectModuleFetchUserCollectMoreDatas) {
        NSArray *tempArray = (NSArray *)argument;
        
        [self.collectionView tp_hideBlankView];
        
        if (messageType == TPCollectModuleFetchUserCollectDatas) {
            self.pageNo = 1;
            if (!tempArray.count) {
                TPUIImageBlankView *blankView = [self.collectionView tp_commonEmptyData];
                blankView.topOffset = 350;
            }
            [self.section removeAllObjects];
        } else {
            self.pageNo += 1;
            if (self.section.count <= 0) {
                TPUIImageBlankView *blankView = [self.collectionView tp_commonEmptyData];
                blankView.topOffset = 350;
            }
        }
        
        if (tempArray.count > 0) {
            for (NSDictionary *dic in tempArray) {
                TPCollectModel *collectModel = [TPCollectModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_COLLECT]];
                TPUserModel *userModel = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
                TPAnimalModel *animal = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
                collectModel.user = userModel;
                collectModel.animal = animal;
                [self.section addObject:[self rowWithModel:collectModel]];
            }
        }
        
        if (tempArray.count < 20) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.TPProxy reloadData:@[self.section]];
        return YES;
    } else if (messageType == TPCollectMododuleRemoveCollect) { // 取消收藏
        [self loadData];
    }
    return NO;
}
- (TPCollectRow *)rowWithModel:(TPCollectModel *)collectModel {
    TPCollectRow *row = [TPCollectRow rowWithModel:collectModel];
    row.didSelectedBlock = ^(__kindof TPCollectionRow * _Nonnull rowData, TPCollectionViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPCollectDetailVC *detailVC = [TPCollectDetailVC new];
        detailVC.collectModel = collectModel;
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return row;
}

#pragma mark ==================  Getter   ==================
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:UICollectionViewFlowLayout.new];
        _collectionView.TPProxy = [TPCollectionViewProxy proxyWithCollectionView:_collectionView];
    }
    return _collectionView;
}
- (TPCollectListSection *)section {
    if (!_section) {
        _section = [TPCollectListSection section];
    }
    return _section;
}
@end
