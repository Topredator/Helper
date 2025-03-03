//
//  TPPublishSendRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPublishSendCell : TPUIBaseTableViewCell

@end

/// 发布操作row
@interface TPPublishSendRow : TPTableRow
@property (nonatomic, weak) TPPublishSendCell *cell;
/// 添加点击事件
- (void)setTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
