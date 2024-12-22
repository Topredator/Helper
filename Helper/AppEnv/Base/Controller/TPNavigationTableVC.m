//
//  TPNavigationTableVC.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPNavigationTableVC.h"

@interface TPNavigationTableVC ()

@end

@implementation TPNavigationTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupSubviews {
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableview];
}
- (void)makeConstraints {
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(TPUI.tp_topBarHeight);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}

- (void)reloadData:(NSArray<TPTableSection<TPTableRow *> *> *)datas {
    [self.tableview.TPProxy reloadData:datas];
}
- (BOOL)showBack {
    return self.navigationController.childViewControllers.count > 1;
}
#pragma mark----------------- Getter -----------------
- (TPNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [self showBack] ? [TPNavigationView backView] : [TPNavigationView normalView];
        _navigationView.showLines = YES;
    }
    return _navigationView;
}
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableview.TPProxy = [TPTableViewProxy proxyWithTableView:_tableview];
        [TPUI tp_adjustsInsets:_tableview vc:self];
    }
    return _tableview;
}
@end
