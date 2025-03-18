//
//  TPApplyRow.h
//  Helper
//
//  Created by Topredator on 2024/12/28.
//

#import <TPFoundation/TPFoundation.h>
#import "TPApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPApplyRow : TPTableRow
+ (instancetype)applyRowWithModel:(TPApplyModel *)model;
@end

NS_ASSUME_NONNULL_END
