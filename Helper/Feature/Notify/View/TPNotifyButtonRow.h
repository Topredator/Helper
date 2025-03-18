//
//  TPNotifyButtonRow.h
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TPNotifyButtonCell : TPUIBaseTableViewCell
@end

static NSString *kTPNotifyApplyRowKey = @"com.helper.notify.apply.row";
static NSString *kTPNotifyExamineRowKey = @"com.helper.notify.examine.row";

/// 通知页 操作按钮
@interface TPNotifyButtonRow : TPTableRow
@property (nonatomic, weak) TPNotifyButtonCell *cell;
@property (nonatomic, assign) BOOL tip;
/// 申请
+ (instancetype)applyRow;
/// 审核
+ (instancetype)examineRow;
- (void)setTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
