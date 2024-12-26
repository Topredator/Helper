//
//  TPAdoptItemVC.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPAdoptItemVC.h"
#import "TPCommonSection.h"
#import "TPAdoptItemRow.h"
#import "TPAdoptDetailVC.h"

@interface TPAdoptItemVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation TPAdoptItemVC
+ (instancetype)itemType:(TPAdoptItemType)itemType {
    TPAdoptItemVC *itemVC = [self new];
    itemVC.itemType = itemType;
    itemVC.title = [self titleFromType:itemType];
    return itemVC;
}
+ (NSString *)titleFromType:(TPAdoptItemType)type {
    switch (type) {
        case TPAdoptItemTypeCat: return @"猫猫";
        case TPAdoptItemTypeDog: return @"狗狗";
        default: return @"全部";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageSize = 20;
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    @weakify(self);
    self.tableview.mj_header = [TPUIRefreshHeader headerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self loadData];
        } afterDelaySecs:3];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self moreData];
        } afterDelaySecs:3];
    }];
}
- (void)loadData {

    [TPDBRouter sendTaskMessage:TPFetchAdoptDatas argument:@{
        @"pageNo": @(1),
        @"pageSize": @(self.pageSize),
        @"type": @(self.itemType)
    }];
}

- (void)moreData {
    [TPDBRouter sendTaskMessage:TPFetchAdoptMoreDatas argument:@{
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(self.pageSize),
        @"type": @(self.itemType)
    }];
}

- (TPAdoptItemRow *)rowWithModel:(TPAdoptModel *)model {
    TPAdoptItemRow *row = [TPAdoptItemRow rowWithModel:model];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPAdoptDetailVC *detailVC = [TPAdoptDetailVC new];
        [[TPUINavigator currentNavigationController] pushViewController:detailVC animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if ((messageType == TPFetchAllAdoptDatas ||
         messageType == TPFetchAllAdoptMoreDatas) && self.itemType == TPAdoptItemTypeAll) {
        NSArray *tempArray = (NSArray *)argument;
        [self handleWithArray:tempArray append:messageType == TPFetchAllAdoptMoreDatas];
        
        return YES;
    } else if ((messageType == TPFetchCatAdoptDatas ||
                messageType == TPFetchCatAdoptMoreDatas) && self.itemType == TPAdoptItemTypeCat) {
        [self handleWithArray:(NSArray *)argument append:messageType == TPFetchCatAdoptMoreDatas];
        return YES;
    } else if ((messageType == TPFetchDogAdoptDatas ||
                messageType == TPFetchDogAdoptMoreDatas) && self.itemType == TPAdoptItemTypeDog) {
        [self handleWithArray:(NSArray *)argument append:messageType == TPFetchDogAdoptMoreDatas];
        return YES;
    }
    return NO;
}
- (void)handleWithArray:(NSArray *)tempArray append:(BOOL)append {
    [self.tableview tp_hideBlankView];
    
    if (!append) {
        self.pageNo = 1;
        if (!tempArray.count) {
            [self.tableview tp_commonEmptyData];
        }
        [self.section removeAllObjects];
    } else {
        self.pageNo += 1;
        if (self.section.count <= 0) {
            [self.tableview tp_commonEmptyData];
        }
    }
    
    if (tempArray.count > 0) {
        for (NSDictionary *dic in tempArray) {
            TPAdoptModel *adoptModel = [TPAdoptModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ADOPT]];
            TPUserModel *userModel = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            TPAnimalModel *animalModel = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
            adoptModel.publisher = userModel;
            adoptModel.animal = animalModel;
            [self.section addObject:[self rowWithModel:adoptModel]];
        }
    }
    
    if (tempArray.count < 20) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableview.mj_footer endRefreshing];
    }
    [self.tableview.mj_header endRefreshing];
    
    [self reloadData:@[self.section]];
}
#pragma mark----------------- Getter -----------------
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
