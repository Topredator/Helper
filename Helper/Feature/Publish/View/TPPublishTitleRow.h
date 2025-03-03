//
//  TPPublishTitleRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPublishTitleCell : TPUIBaseTableViewCell
@property (nonatomic, strong, readonly) TPLimitTextField *textField;
@end

/// 发布标题
@interface TPPublishTitleRow : TPTableRow
@property (nonatomic, weak, readonly) TPPublishTitleCell *cell;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

@end

NS_ASSUME_NONNULL_END
