//
//  TPPublicOperationVC.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPPublicOperationVC.h"
#import "TPReleaseDiaryVC.h"
#import "TPReleaseAdoptVC.h"
#import "TPCommonSection.h"
#import "TPCommonTitleRow.h"
#import "TPBaseWebVC.h"
#import "TPPublishVC.h"
@interface TPPublicOperationVC ()
@property (nonatomic, weak) TPUIPopupMenuVC *menuVC;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation TPPublicOperationVC
- (void)dealloc {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"发布选择";
    [self loadData];
}

- (void)loadData {
    TPCommonSection *section = [TPCommonSection section];
    [section addObject:[self notifyRow]];
    [section addObject:[self diaryRow]];
    [section addObject:[self beRescuedRow]];
    [section addObject:[self inRecoveryRow]];
    [section addObject:[self adoptRow]];
    [self reloadData:@[section]];
}
- (TPCommonTitleRow *)notifyRow {
    __weak typeof(self) weakSelf = self;
    TPCommonTitleRow *row = [TPCommonTitleRow rowWithTitle:@"公告信息"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        NSArray *titles = @[@"链接公告", @"图文公告"];
        TPUIPopupMenuConfig *config = TPUIPopupMenuConfig.new;
        config.shieldColor = [TPUI tp_t:0 alpha:0.5];
        config.selectedIndex = weakSelf.selectedIndex;
        TPUIPopupMenuVC *menuVC = [TPUIPopupMenuVC menuConfig:config titles:titles];
        [menuVC setDidSelectedBlock:^(NSInteger index) {
            weakSelf.selectedIndex = index;
            TPPublishVC *vc = [TPPublishVC new];
            if (index == 0) {
                vc.type = TPPublishTypeLinkNotice;
            } else {
                vc.type = TPPublishTypeGraphicNotice;
            }
            [TPUINavigator pushViewController:vc animated:YES];
        }];
        [menuVC setDismissBlock:^{
            NSLog(@"消失了");
        }];
        [menuVC presentInTargetVC:weakSelf contentHeight:[menuVC maxContentHeight] topOffset:TPUI.tp_topBarHeight + 60];
        weakSelf.menuVC = menuVC;
        
        
//        TPBaseWebVC *webVC = [[TPBaseWebVC alloc] init];
//        webVC.url = @"https://www.baidu.com";
//        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
    return row;
}
- (TPCommonTitleRow *)diaryRow {
    __weak typeof(self) weakSelf = self;
    TPCommonTitleRow *row = [TPCommonTitleRow rowWithTitle:@"生活日记"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPPublishVC *publishVC = [TPPublishVC new];
        publishVC.type = TPPublishTypeDaily;
        [TPUINavigator pushViewController:publishVC animated:YES];
//        TPReleaseDiaryVC *dailyVC = [TPReleaseDiaryVC new];
//        [weakSelf.navigationController pushViewController:dailyVC animated:YES];
    };
    return row;
}
- (TPCommonTitleRow *)beRescuedRow {
    TPCommonTitleRow *row = [TPCommonTitleRow rowWithTitle:@"待救助"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPPublishVC *publishVC = [TPPublishVC new];
        publishVC.type = TPPublishTypeToBeRescued;
        [TPUINavigator pushViewController:publishVC animated:YES];
    };
    return row;
}
- (TPCommonTitleRow *)inRecoveryRow {
    TPCommonTitleRow *row = [TPCommonTitleRow rowWithTitle:@"康复中"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPPublishVC *publishVC = [TPPublishVC new];
        publishVC.type = TPPublishTypeInRecovery;
        [TPUINavigator pushViewController:publishVC animated:YES];
    };
    return row;
}
- (TPCommonTitleRow *)adoptRow {
    __weak typeof(self) weakSelf = self;
    TPCommonTitleRow *row = [TPCommonTitleRow rowWithTitle:@"领养"];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPPublishVC *publishVC = [TPPublishVC new];
        publishVC.type = TPPublishTypeAdopt;
        [TPUINavigator pushViewController:publishVC animated:YES];
//        TPReleaseAdoptVC *adoptVC = [TPReleaseAdoptVC new];
//        [weakSelf.navigationController pushViewController:adoptVC animated:YES];
    };
    return row;
}
/// 生活日记
- (void)dailyBtnAction {
    TPReleaseDiaryVC *dailyVC = [TPReleaseDiaryVC new];
    [self.navigationController pushViewController:dailyVC animated:YES];
}
/// 领养
- (void)adoptBtnAction {
    TPReleaseAdoptVC *adoptVC = [TPReleaseAdoptVC new];
    [self.navigationController pushViewController:adoptVC animated:YES];
}
/// 公告信息
- (void)platformBtnAction {}
@end
