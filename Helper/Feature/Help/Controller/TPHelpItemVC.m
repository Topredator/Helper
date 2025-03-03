//
//  TPAdoptItemVC.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPHelpItemVC.h"
#import "TPCommonSection.h"
#import "TPCommonAnimalRow.h"
#import "TPHelpDetailVC.h"
#import "TPPublishModule.h"
#import "TPPublishModel.h"
@interface TPHelpItemVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation TPHelpItemVC
+ (instancetype)itemType:(TPHelpItemType)itemType {
    TPHelpItemVC *itemVC = [self new];
    itemVC.itemType = itemType;
    itemVC.title = [self titleFromType:itemType];
    return itemVC;
}
+ (NSString *)titleFromType:(TPHelpItemType)type {
    switch (type) {
        case TPHelpItemToBeRescued: return @"待救助";
        case TPHelpItemInRecovery: return @"康复中";
        case TPHelpItemPendingAdoption: return @"待领养";
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
        @strongify(self);
        [self loadData];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreData];
    }];
}
- (void)loadData {

    [TPDBRouter sendTaskMessage:TPPublishAnimalDatas argument:@{
        @"pageNo": @(1),
        @"pageSize": @(self.pageSize),
        @"type": @(self.itemType)
    }];
}

- (void)moreData {
    [TPDBRouter sendTaskMessage:TPPublishAnimalMoreDatas argument:@{
        @"pageNo": @(self.pageNo + 1),
        @"pageSize": @(self.pageSize),
        @"type": @(self.itemType)
    }];
}

- (TPCommonAnimalRow *)rowWithModel:(TPPublishModel *)model {
    TPCommonAnimalRow *row = [TPCommonAnimalRow rowWithModel:model.animal];
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPHelpDetailVC *detailVC = [TPHelpDetailVC new];
        detailVC.publishModel = model;
        [[TPUINavigator currentNavigationController] pushViewController:detailVC animated:YES];
    };
    return row;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if ((messageType == TPFetchAllAnimalDatas ||
         messageType == TPFetchAllAnimalMoreDatas) && self.itemType == TPHelpItemTypeAll) {
        NSArray *tempArray = (NSArray *)argument;
        [self handleWithArray:tempArray append:messageType == TPFetchAllAnimalMoreDatas];
        
        return YES;
    } else if ((messageType == TPFetchBeRescuedAnimalDatas ||
                messageType == TPFetchBeRescuedAnimalMoreDatas) && self.itemType == TPHelpItemToBeRescued) {
        [self handleWithArray:(NSArray *)argument append:messageType == TPFetchBeRescuedAnimalMoreDatas];
        return YES;
    } else if ((messageType == TPFetchInRecoveryAnimalDatas ||
                messageType == TPFetchInRecoveryAnimalMoreDatas) && self.itemType == TPHelpItemInRecovery) {
        [self handleWithArray:(NSArray *)argument append:messageType == TPFetchInRecoveryAnimalMoreDatas];
        return YES;
    } else if ((messageType == TPFetchPendingAdoptAnimalDatas ||
                messageType == TPFetchPendingAdoptAnimalMoreDatas) && self.itemType == TPHelpItemPendingAdoption) {
        [self handleWithArray:(NSArray *)argument append:messageType == TPFetchPendingAdoptAnimalMoreDatas];
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
            TPPublishModel *publishModel = [TPPublishModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_PUBLISH]];
            
            TPUserModel *userModel = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            TPAnimalModel *animalModel = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
            publishModel.user = userModel;
            publishModel.animal = animalModel;
            [self.section addObject:[self rowWithModel:publishModel]];
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
