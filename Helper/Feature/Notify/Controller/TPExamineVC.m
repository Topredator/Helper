//
//  TPExamineVC.m
//  Helper
//
//  Created by Topredator on 2025/3/18.
//

#import "TPExamineVC.h"
#import "TPCommonSection.h"
#import "TPApplyModel.h"

@interface TPExamineVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation TPExamineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNo = 1;
    self.pageSize = 20;
    self.navigationView.title = @"审核数据";
    [self loadData];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreData];
    }];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPFetchUserAuditDatas argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @(self.pageNo),
        @"pageSize": @(self.pageSize)
    }];
}
- (void)moreData {
    [TPDBRouter sendTaskMessage:TPFetchUserAuditMoreDatas argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(self.pageSize)
    }];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPFetchUserAuditDatas ||
        messageType == TPFetchUserAuditMoreDatas) {
        NSArray *tempArray = (NSArray *)argument;
        
        [self.tableview tp_hideBlankView];
        
        if (messageType == TPFetchUserAuditDatas) {
            self.pageNo = 1;
            if (!tempArray.count) {
                [self.tableview tp_commonEmptyData];
            }
            [self.section removeAllObjects];
        } else {
            self.pageNo += 1;
            if (self.section.count <= 0) {
                [self.tableview tp_commonEmptyData];
            }
        }
        
        if (tempArray.count > 0) {
            for (NSDictionary *dic in tempArray) {
                TPApplyModel *model = [TPApplyModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_APPLY]];
                TPUserModel *user = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
                TPAnimalModel *animal = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
                model.applicant = user;
                model.animal = animal;
//                [self.section addObject:[self rowWithModel:model]];
            }
        }
        
        if (tempArray.count < 20) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableview.mj_footer endRefreshing];
        }
        [self.tableview.mj_header endRefreshing];
        [self reloadData:@[self.section]];
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
