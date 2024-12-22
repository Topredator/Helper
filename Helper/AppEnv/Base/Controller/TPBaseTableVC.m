//
//  TPBaseTableVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPBaseTableVC.h"

@interface TPBaseTableVC ()

@end

@implementation TPBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupSubviews {
    [self.view addSubview:self.tableview];
}
- (void)reloadData:(NSArray<TPTableSection<TPTableRow *> *> *)datas {
    [self.tableview.TPProxy reloadData:datas];
}
#pragma mark ------------------------  lazy method  ---------------------------
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableview.TPProxy = [TPTableViewProxy proxyWithTableView:_tableview];
        _tableview.backgroundColor = TPHelperDefaultBgColor;
        [TPUI tp_adjustsInsets:_tableview vc:self];
    }
    return _tableview;
}
@end
