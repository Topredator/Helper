//
//  TPAdoptItemVC.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPAdoptItemVC.h"
#import "TPCommonSection.h"
#import "TPAdoptItemRow.h"

@interface TPAdoptItemVC ()
@property (nonatomic, strong) TPCommonSection *section;
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
            [self.tableview.mj_header endRefreshing];
        } afterDelaySecs:3];
    }];
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            @strongify(self);
            [self.tableview.mj_footer endRefreshing];
        } afterDelaySecs:3];
    }];
}
- (void)loadData {
    switch (self.itemType) {
        case TPAdoptItemTypeCat:
            [self.section addObjectsFromArray:[self catItemRows]];
            break;
        case TPAdoptItemTypeDog:
            [self.section addObjectsFromArray:[self dogItemRows]];
            break;
        default: {
            [self.section addObjectsFromArray:[self catItemRows]];
            [self.section addObjectsFromArray:[self dogItemRows]];
        }
            break;
    }
    [self reloadData:@[self.section]];
}
- (NSArray <TPAdoptItemRow *>*)catItemRows {
    NSInteger count = 15;
    NSMutableArray *array = @[].mutableCopy;
    NSString *name = @"猫猫";
    TPAnimalCategory category = TPAnimalCategoryCat;
    
    for (NSInteger i = 0 ; i < count; i++) {
        TPAdoptModel *model = [TPAdoptModel adoptName:[NSString stringWithFormat:@"%@_%ld", name, i + 1] category:category sex:(TPAnimalSexType)(arc4random() % 2)];
        [array addObject:[TPAdoptItemRow rowWithModel:model]];
    }
    return array.copy;
}
- (NSArray <TPAdoptItemRow *>*)dogItemRows {
    NSInteger count = 15;
    NSMutableArray *array = @[].mutableCopy;
    NSString *name = @"狗狗";
    TPAnimalCategory category = TPAnimalCategoryDog;
    for (NSInteger i = 0 ; i < count; i++) {
        TPAdoptModel *model = [TPAdoptModel adoptName:[NSString stringWithFormat:@"%@_%ld", name, i + 1] category:category sex:(TPAnimalSexType)(arc4random() % 2)];
        [array addObject:[TPAdoptItemRow rowWithModel:model]];
    }
    return array.copy;
}

#pragma mark----------------- Getter -----------------
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
