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
    [section addObject:[TPMineFunctionRow row]];
    
    TPMineToolSection *toolSection = [TPMineToolSection section];
    [toolSection addObject:[self feedbackRow]];
    [toolSection addObject:[self ruleRow]];
    [toolSection addObject:[self agreementRow]];
    [toolSection addObject:[self customerServiceRow]];
    [self reloadData:@[section, toolSection]];
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
        
    };
    return row;
}
#pragma mark----------------- Getter -----------------
- (TPMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TPMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 284)];
    }
    return _headerView;
}
@end
