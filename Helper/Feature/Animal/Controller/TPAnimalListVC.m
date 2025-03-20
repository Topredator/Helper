//
//  TPAnimalListVC.m
//  Helper
//
//  Created by Topredator on 2025/3/2.
//

#import "TPAnimalListVC.h"
#import "TPAnimalVC.h"
#import "TPCommonSection.h"
#import "TPCommonAnimalRow.h"

@interface TPAnimalListVC ()
@property (nonatomic, strong) UIButton *createBtn;
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation TPAnimalListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"宠物列表";
    [self refreshData];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshData];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreData];
    }];
}
- (void)refreshData {
    [TPDBRouter sendTaskMessage:TPAnimalModuleFetchUserAnimal argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @(1),
        @"pageSize": @(20)
    }];
}
- (void)moreData {
    [TPDBRouter sendTaskMessage:TPAnimalModuleFetchUserAnimalDatas argument:@{
        @"userId": TPUserManager.manager.user.userId,
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(20)
    }];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.navigationView addSubview:self.createBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-7);
    }];
}
- (TPCommonAnimalRow *)rowWithModel:(TPAnimalModel *)model {
    TPCommonAnimalRow *row = [TPCommonAnimalRow rowWithModel:model];
    row.canDelete = YES;
    @weakify(self);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        if (self.callback) self.callback(model);
        [TPUINavigator popViewControllerWithTimes:1 animated:YES];
    };
    return row;
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
        for (NSDictionary *dic in datas) {
            TPAnimalModel *animalModel = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
            [self.section addObject:[self rowWithModel:animalModel]];
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

- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPAnimalModuleFetchUserAnimal) { // 获取用户名下宠物
        NSArray *tempArray = (NSArray *)argument;
        [self handleDatas:tempArray append:NO];
        return YES;
    } else if (messageType == TPAnimalModuleFetchUserAnimalDatas) { // 更多
        NSArray *tempArray = (NSArray *)argument;
        [self handleDatas:tempArray append:YES];
        return YES;
    } else if (messageType == TPAnimalModuleRegist) { // 注册
        [self refreshData];
        return YES;
    } else if (messageType == TPAnimalDeleteInfo) { // 删除动物信息
        [self refreshData];
    }
    return NO;
}

- (void)createAction {
    TPAnimalVC *animalVC = [TPAnimalVC new];
    animalVC.infoBlock = ^(TPAnimalModel * _Nonnull model) {
        [TPDBRouter sendTaskMessage:TPAnimalModuleRegist argument:[model tp_modelToJSONObject]];
    };
    [TPUINavigator pushViewController:animalVC animated:YES];
}
#pragma mark ==================  Getter   ==================
- (UIButton *)createBtn {
    if (!_createBtn) {
        _createBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_createBtn setTitle:@"创建宠物" forState:UIControlStateNormal];
        [_createBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _createBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_createBtn addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createBtn;
}
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
