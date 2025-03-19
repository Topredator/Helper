//
//  TPExamineRow.h
//  Helper
//
//  Created by Topredator on 2025/3/18.
//

#import <TPFoundation/TPFoundation.h>
#import "TPApplyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPExamineCell : TPUIBaseTableViewCell

@end


@interface TPExamineRow : TPTableRow
@property (nonatomic, weak) TPExamineCell *cell;
+ (instancetype)rowWithModel:(TPApplyModel *)model;
@end

NS_ASSUME_NONNULL_END
