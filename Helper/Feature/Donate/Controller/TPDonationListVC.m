//
//  TPMineDonationVC.m
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import "TPDonationListVC.h"
#import "TPCommonSection.h"
#import "TPDonateModule.h"
#import "TPDonateModel.h"
#import "TPOperateDonateRow.h"
#import "TPDonateDetailVC.h"
@interface TPDonationListVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation TPDonationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    self.pageSize = 20;
    self.navigationView.title = @"我的捐赠";
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
    [TPDBRouter sendTaskMessage:TPDonateFetchUserDonates argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @1,
        @"pageSize": @(self.pageSize)
    }];
}
- (void)moreData {
    [TPDBRouter sendTaskMessage:TPDonateFetchUserDonates argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(self.pageSize)
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
        for (TPDonateOperate *operate in datas) {
            [self.section addObject:[self rowWithModel:operate]];
        }
    }
    
    if (datas.count < 20) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableview.mj_footer endRefreshing];
    }
    [self.tableview.mj_header endRefreshing];
    
    [self reloadData:@[self.section]];
}
- (TPOperateDonateRow *)rowWithModel:(TPDonateOperate *)operate {
    TPOperateDonateRow *row = [TPOperateDonateRow rowWithModel:operate];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPDonateDetailVC *detailVC = [TPDonateDetailVC new];
        detailVC.operate = operate;
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPDonateFetchUserDonates) {
        [self handleDatas:argument append:NO];
        return YES;
    } else if (messageType == TPDonateFetchUserMoreDonates) {
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
