//
//  TPMineVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPMineVC.h"
#import "TPMineHeaderView.h"
#import "TPMineFunctionRow.h"
#import "TPCommonSection.h"
#import "TPMineToolSection.h"
#import "TPMineToolRow.h"
#import "TPPublicOperationVC.h"
#import "TPReleaseDiaryVC.h"
#import "TPCollectListVC.h"
@interface TPMineVC ()
@property (nonatomic, strong) TPMineHeaderView *headerView;
@end

@implementation TPMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableview.tableHeaderView = self.headerView;
}

- (void)loadData {
    TPCommonSection *section = [TPCommonSection section];
    [section addObject:[self functionRow]];
    
    TPMineToolSection *toolSection = [TPMineToolSection section];
    if (TPUserManager.manager.user.userType == TPUserTypeCustome) {
        [toolSection addObject:[self applyRow]];
    }
    [toolSection addObject:[self feedbackRow]];
    [toolSection addObject:[self ruleRow]];
    [toolSection addObject:[self agreementRow]];
    [toolSection addObject:[self customerServiceRow]];
    [self reloadData:@[section, toolSection]];
}
- (TPMineFunctionRow *)functionRow {
    TPMineFunctionRow *row = [TPMineFunctionRow row];
    [row setPublicTarget:self action:@selector(publicAction)];
    [row setCollectTarget:self action:@selector(collectAction)];
    [row setDonateTarget:self action:@selector(donateAction)];
    return row;
}
- (TPMineToolRow *)applyRow {
    TPMineToolRow *row = [TPMineToolRow rowWithIcon:@"mine_apply_admin" name:@"申请成为管理员"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPDBRouter sendTaskMessage:TPApplyToAdmin];
    };
    return row;
}
- (TPMineToolRow *)feedbackRow {
    TPMineToolRow *row = [TPMineToolRow rowWithIcon:@"mine_feedback" name:@"帮助与反馈"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPMineToolRow *)ruleRow {
    TPMineToolRow *row = [TPMineToolRow rowWithIcon:@"mine_rule" name:@"平台规则"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPMineToolRow *)agreementRow {
    TPMineToolRow *row = [TPMineToolRow rowWithIcon:@"mine_agreement" name:@"领养协议"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        
    };
    return row;
}
- (TPMineToolRow *)customerServiceRow {
    TPMineToolRow *row = [TPMineToolRow rowWithIcon:@"mine_customer_service" name:@"客服电话"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            make.title(@"客服电话");
            make.addOption(TPUIAlertBlockOption(@"15238272309", ^{
                NSString *telURL = [NSString stringWithFormat:@"tel:15238272309"];
                    NSURL *url = [NSURL URLWithString:telURL];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                    }
            }));
            make.cancleOption(@"取消");
        }];
    };
    return row;
}

- (void)publicAction {
    if (TPUserManager.manager.user.userType != TPUserTypeCustome) {
        TPPublicOperationVC *vc = [TPPublicOperationVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        TPReleaseDiaryVC *dailyVC = [TPReleaseDiaryVC new];
        [self.navigationController pushViewController:dailyVC animated:YES];
    }
}
- (void)collectAction {
    TPCollectListVC *listVC = [TPCollectListVC new];
    [TPUINavigator pushViewController:listVC animated:YES];
}
- (void)donateAction {
    
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPApplyToAdminWaiting) {
        [self.view tp_toast:@"已申请，请等待审批"];
        return YES;
    } else if (messageType == TPApplyToAdmin) {
        [self.view tp_toast:@"申请成功，请等待审批"];
        return YES;
    }
    return NO;
}
#pragma mark----------------- Getter -----------------
- (TPMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TPMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 284)];
    }
    return _headerView;
}
@end
