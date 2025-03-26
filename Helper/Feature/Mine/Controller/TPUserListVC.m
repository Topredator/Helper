//
//  TPUserListVC.m
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import "TPUserListVC.h"
#import "TPCommonSection.h"
#import "TPUserListRow.h"
#import "TPUserDetailVC.h"
@interface TPUserListVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation TPUserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    self.pageSize = 20;
    self.navigationView.title = @"用户列表";
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreData];
    }];
    [self loadData];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPUserFetchAllUserDatas argument:@{
        @"pageSize": @(self.pageSize),
        @"pageNo": @1
    }];
}
- (void)moreData {
    [TPDBRouter sendTaskMessage:TPUserFetchAllUserDatas argument:@{
        @"pageSize": @(self.pageSize),
        @"pageNo": @(self.pageNo + 1)
    }];
}

- (void)handleDatas:(NSArray *)datas append:(BOOL)append {
    [self.tableview tp_hideBlankView];
    
    if (!append) {
        self.pageNo = 1;
        if (!datas.count) {
            [self.tableview tp_commonEmptyData];
        }
        [self.section removeAllObjects];
    } else {
        self.pageNo += 1;
        if (self.section.count <= 0) {
            [self.tableview tp_commonEmptyData];
        }
    }
    
    if (datas.count > 0) {
        for (NSDictionary *dic in datas) {
            TPUserModel *user = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            [self.section addObject:[self rowWithModel:user]];
        }
//        for (TPDonateOperate *operate in datas) {
//            [self.section addObject:[self rowWithModel:operate]];
//        }
    }
    
    if (datas.count < 20) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableview.mj_footer endRefreshing];
    }
    [self.tableview.mj_header endRefreshing];
    
    [self reloadData:@[self.section]];
}
- (TPUserListRow *)rowWithModel:(TPUserModel *)userModel {
    TPUserListRow *row = [TPUserListRow rowWithModel:userModel];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPUserDetailVC *detailVC = [TPUserDetailVC new];
        detailVC.userId = userModel.userId;
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPUserFetchAllUserDatas) {
        [self handleDatas:argument append:NO];
        return YES;
    } else if (messageType == TPUserFetchAllUserMoreDatas) {
        [self handleDatas:argument append:YES];
        return YES;
    }
    return NO;
}
#pragma mark ==================  Getter   ==================
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
