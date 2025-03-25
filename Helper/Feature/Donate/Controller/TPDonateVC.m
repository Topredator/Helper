//
//  TPDonateVC.m
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import "TPDonateVC.h"
#import "TPDonateSection.h"
#import "TPDonateModel.h"
#import "TPDonateModule.h"
#import "TPDonateSection.h"
#import "TPDonateRow.h"
#import "TPDonateExpressView.h"
@interface TPDonateVC ()
@property (nonatomic, strong) TPDonateExpressView *expressView;
@property (nonatomic, strong) NSMutableArray <TPDonateCategoryModel *>*categoryDatas;
@property (nonatomic, strong) UIButton *donateBtn;
@end

@implementation TPDonateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"物资捐赠";
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.expressView];
    [self.navigationView addSubview:self.donateBtn];
}
- (void)makeConstraints {
    __weak typeof(self) weakSelf = self;
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(TPUI.tp_topBarHeight);
    }];
    [self.expressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50 + TPUI.tp_bottomSafeAreaHeight);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.navigationView.mas_bottom);
        make.bottom.equalTo(self.expressView.mas_top);
    }];
    [self.donateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.mas_equalTo(-2);
    }];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPDonateFetchAllCategories];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPDonateFetchAllCategories) {
        NSArray *array = argument;
        [self.categoryDatas removeAllObjects];
        for (NSDictionary *dic in array) {
            TPDonateCategoryModel *categoryModel = [TPDonateCategoryModel tp_modelWithDictionary:dic];
            [self.categoryDatas addObject:categoryModel];
        }
        NSMutableArray *mArray = @[].mutableCopy;
        for (TPDonateCategoryModel *model in self.categoryDatas) {
            TPDonateSection *section = [TPDonateSection sectionWithModel:model];
            for (TPDonateItemModel *item in model.items) {
                TPDonateRow *row = [TPDonateRow rowWithItem:item];
                [section addObject:row];
            }
            [mArray addObject:section];
        }
        [self reloadData:mArray.copy];
        return YES;
    } else if (messageType == TPDonatePetDonation) {
        [TPAppDelegate().window tp_toast:@"捐赠成功"];
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
    }
    return NO;
}
- (void)donateBtnAction {
    
    if (!self.expressView.expressNumber.length) {
        [self.view tp_toast:@"请填写快递单号"];
        return;
    }
    NSMutableArray *tempArr = @[].mutableCopy;
    for (TPDonateSection *section in self.tableview.TPProxy.data) {
        NSMutableArray *items = @[].mutableCopy;
        for (TPDonateItemModel *item in section.categoryModel.items) {
            if (item.quantity > 0) {
                [items addObject:item];
            }
        }
        if (items.count) {
            section.categoryModel.items = items.copy;
            [tempArr addObject:section.categoryModel];
        }
    }
    if (!tempArr.count) {
        [self.view tp_toast:@"请选择捐赠的物品"];
        return;
    }
    TPDonateModel *donateModel = [TPDonateModel model];
    donateModel.donaterId = TPUserManager.manager.user.userId;
    donateModel.doneeId = self.user.userId;
    donateModel.animalId = self.animal.animalId;
    donateModel.expressNumber = self.expressView.expressNumber;
    
    TPDonateOperate *operate = [TPDonateOperate new];
    operate.donate = donateModel;
    operate.categorys = tempArr.copy;
    [TPDBRouter sendTaskMessage:TPDonatePetDonation argument:operate];
}
#pragma mark ==================  Getter   ==================
- (NSMutableArray<TPDonateCategoryModel *> *)categoryDatas {
    if (!_categoryDatas) {
        _categoryDatas = @[].mutableCopy;
    }
    return _categoryDatas;
}
- (TPDonateExpressView *)expressView {
    if (!_expressView) {
        _expressView = [TPDonateExpressView view];
        _expressView.backgroundColor = UIColor.whiteColor;
    }
    return _expressView;
}
- (UIButton *)donateBtn {
    if (!_donateBtn) {
        _donateBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_donateBtn setTitle:@"捐赠" forState:UIControlStateNormal];
        [_donateBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _donateBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_donateBtn addTarget:self action:@selector(donateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _donateBtn;
}
@end
