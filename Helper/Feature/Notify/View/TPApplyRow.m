//
//  TPApplyRow.m
//  Helper
//
//  Created by Topredator on 2024/12/28.
//

#import "TPApplyRow.h"

@interface TPApplyCell : TPUIBaseTableViewCell
@property (nonatomic, strong) TPTextDisplayView *dispalyView;
@end
@implementation TPApplyCell
- (void)configWithModel:(TPApplyModel *)model {
    
}
#pragma mark ==================  Getter   ==================
- (TPTextDisplayView *)dispalyView {
    if (!_dispalyView) {
//        _dispalyView = [[TPTextDisplayView alloc] initWithFrame:<#(CGRect)#>]
    }
    return _dispalyView;
}
@end

@interface TPApplyRow ()
@property (nonatomic, strong) TPApplyModel *model;
@end

@implementation TPApplyRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPApplyCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPApplyModel *)model {
    TPApplyRow *row = [TPApplyRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPApplyCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    
}
@end
