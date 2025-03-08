//
//  TPAddressListVC.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressListVC.h"
#import "TPAddressModule.h"
#import "TPAddressModel.h"
#import "TPCommonSection.h"
#import "TPAddressVC.h"
#import "TPAddressRow.h"

@interface TPAddressListVC ()
/// 创建按钮
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) TPCommonSection *section;
@end

@implementation TPAddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"地址列表";
    [self loadData];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.addBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-TPUI.tp_bottomSafeAreaHeight - 20);
    }];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPAddressFetchUserInfo argument:TPUserManager.manager.user.userId];
}
- (void)addBtnAction {
    if (self.section.count >= 6) {
        [self.view tp_toast:@"地址最多添加6个" duration:1.5];
        return;
    }
    TPAddressVC *addressVC = [TPAddressVC new];
    [TPUINavigator pushViewController:addressVC animated:YES];
}
- (TPAddressRow *)rowWithModel:(TPAddressModel *)model {
    TPAddressRow *row = [TPAddressRow rowWithModel:model];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPAddressVC *vc = [TPAddressVC new];
        vc.addressModel = model;
        [TPUINavigator pushViewController:vc animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPAddressFetchUserInfo) {
        [self.tableview tp_hideBlankView];
        [self.tableview.mj_header endRefreshing];
        NSArray *array = (NSArray *)argument;
        if (!array.count) {
            [self.tableview tp_commonEmptyData];
        }
        [self.datas removeAllObjects];
        [self.section removeAllObjects];
        
        for (NSDictionary *dic in array) {
            TPAddressModel *addressModel = [TPAddressModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ADDRESS]];
            TPUserModel *user = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            addressModel.user = user;
            TPCommonSection *section = [TPCommonSection section];
            [section addObject:[self rowWithModel:addressModel]];
            [self.datas addObject:section];
        }
        [self reloadData:self.datas.copy];
        
    } else if (messageType == TPAddressAddNewUserAddress ||
               messageType == TPAddressEditUserAddress ||
               messageType == TPAddressDeleteUserAddress) {
        [self loadData];
        return YES;
    }
    return NO;
}
#pragma mark ==================  Getter   ==================
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addBtn setTitle:@"创建地址" forState:UIControlStateNormal];
        [_addBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [TPUI tp_font:17 weight:FontMedium];
        _addBtn.backgroundColor = TPHelperThemeColor;
        _addBtn.layer.cornerRadius = 8;
        _addBtn.layer.masksToBounds = YES;
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = @[].mutableCopy;
    }
    return _datas;
}
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
