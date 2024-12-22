//
//  TPAdoptItemRow.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <TPFoundation/TPFoundation.h>
#import "TPAdoptModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPAdoptItemRow : TPTableRow
+ (instancetype)rowWithModel:(TPAdoptModel *)model;
@end

NS_ASSUME_NONNULL_END
