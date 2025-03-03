//
//  TPPublishContentRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPPublishContentCell : TPUIBaseTableViewCell

@end

@interface TPPublishContentRow : TPTableRow
@property (nonatomic, weak) TPPublishContentCell *cell;
@property (nonatomic, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
