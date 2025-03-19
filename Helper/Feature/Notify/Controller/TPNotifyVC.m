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
#import "TPNotifyEmptyRow.h"
#import "TPExamineVC.h"
@interface TPNotifyVC ()
@property (nonatomic, strong) TPNotifyAnnouncementSection *notifySection;
@property (nonatomic, strong) TPCommonSection *section;
@end

@implementation TPNotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"通知";
    [self loadData];
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)setupSubviews {
    [super setupSubviews];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestData];
    }];
}
- (void)makeConstraints {
    [super makeConstraints];
}
- (void)loadData {
    [self.notifySection removeAllObjects];
    [self.notifySection addObject:[TPNotifyEmptyRow row]];
    
    [self.section removeAllObjects];
    [self.section addObject:[self applyRow]];
    [self.section addObject:[self examineRow]];
    
    [self reloadData:@[self.notifySection, self.section]];
}
- (void)requestData {
    // 公告
    [TPDBRouter sendTaskMessage:TPPublishAnnouncementDatas];
    // 申请审批
    [TPDBRouter sendTaskMessage:TPWhetherAuditDataExists argument:TPUserManager.manager.user.userId];
}

- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPPublishAnnouncementDatas) {
        [self.tableview.mj_header endRefreshing];
        NSArray *array = argument;
        [self.notifySection removeAllObjects];
        if (!array.count) {
            [self.notifySection addObject:[TPNotifyEmptyRow row]];
        } else {
            if (array.count > 3) {
                array = [array subarrayWithRange:NSMakeRange(0, 3)];
            }
            for (NSDictionary *dic in array) {
                TPPublishModel *model = [TPPublishModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_PUBLISH]];
                [self.notifySection addObject:[self rowWithModel:model]];
            }
        }
        [self reloadData:@[self.notifySection, self.section]];
        return YES;
    } else if (messageType == TPWhetherAuditDataExists) {
        NSArray *array = argument;
        TPNotifyButtonRow *row = (TPNotifyButtonRow *)self.section[kTPNotifyExamineRowKey];
        row.tip = array.count;
        return YES;
    }
    return NO;
}
- (void)applyAction {
    TPApplyListVC *listVC = [TPApplyListVC new];
    [self.navigationController pushViewController:listVC animated:YES];
}
- (void)examineAction {
    TPExamineVC *examineVC = [TPExamineVC new];
    [self.navigationController pushViewController:examineVC animated:YES];
}


- (TPNotifyAnnouncementRow *)rowWithModel:(TPPublishModel *)model {
    TPNotifyAnnouncementRow *row = [TPNotifyAnnouncementRow rowWithModel:model];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
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
#pragma mark ==================  Getter   ==================
- (TPNotifyAnnouncementSection *)notifySection {
    if (!_notifySection) {
        _notifySection = [TPNotifyAnnouncementSection section];
    }
    return _notifySection;
}
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
        _section.h_height = 10;
    }
    return _section;
}
@end
