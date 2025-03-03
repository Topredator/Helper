//
//  TPNotifyVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPNotifyVC.h"
#import "TPNotifyAnnouncementSection.h"
#import "TPNotifyAnnouncementRow.h"
#import "TPNotifyButtonRow.h"
#import "TPCommonSection.h"
#import "TPApplyListVC.h"

@interface TPNotifyVC ()

@end

@implementation TPNotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self.tableview.mj_header endRefreshing];
        } afterDelaySecs:3];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self.tableview.mj_footer endRefreshing];
        } afterDelaySecs:3];
    }];
}
- (void)makeConstraints {
    [super makeConstraints];
}
- (void)loadData {
    TPNotifyAnnouncementSection *section = [TPNotifyAnnouncementSection section];
    [section addObjectsFromArray:[self rows]];
    
    TPCommonSection *operationSection = [TPCommonSection section];
    operationSection.h_height = 10;
    if (TPUserManager.manager.user.userType != TPUserTypeCustome) {
        [operationSection addObject:[self applyRow]];
    }
    [operationSection addObject:[self examineRow]];
    
    [self reloadData:@[section, operationSection]];
}
- (NSArray <TPNotifyAnnouncementRow *>*)rows {
    NSMutableArray *tempArray = @[].mutableCopy;
    TPNotifyAnnouncementModel *newsModel = [TPNotifyAnnouncementModel modelWithTheme:@"狸花猫之谜" details:@"" type:TPAnnouncementTypeNews];
    [tempArray addObject:[TPNotifyAnnouncementRow rowWithModel:newsModel]];
    
    TPNotifyAnnouncementModel *platformModel = [TPNotifyAnnouncementModel modelWithTheme:@"平台改进计划" details:@"当前平台在运营过程中已取得了一定的成绩，积累了一定数量的用户群体，涵盖了多个领域的业务。然而，通过对用户反馈、数据分析以及内部评估，发现平台仍存在一些亟待解决的问题..." type:TPAnnouncementTypePlatform];
    [tempArray addObject:[TPNotifyAnnouncementRow rowWithModel:platformModel]];
    
    TPNotifyAnnouncementModel *thirdModel = [TPNotifyAnnouncementModel modelWithTheme:@"青山救助机构" details:@"尊敬的社会各界爱心人士：\n首先，衷心感谢大家一直以来对本流浪动物救助机构的关注、支持与信任。为了让大家更好地了解我们的工作理念、运营原则以及相关事项，特发布本声明。" type:TPAnnouncementTypeThirdParty];
    [tempArray addObject:[TPNotifyAnnouncementRow rowWithModel:thirdModel]];
    return tempArray.copy;
}
- (void)applyAction {
    
}
- (void)examineAction {
    TPApplyListVC *listVC = [TPApplyListVC new];
    [self.navigationController pushViewController:listVC animated:YES];
}
- (TPNotifyButtonRow *)applyRow {
    TPNotifyButtonRow *row = [TPNotifyButtonRow applyRow];
    [row setTarget:self action:@selector(applyAction)];
    return row;
}
- (TPNotifyButtonRow *)examineRow {
    TPNotifyButtonRow *row = [TPNotifyButtonRow examineRow];
    [row setTarget:self action:@selector(examineAction)];
    return row;
}
@end
