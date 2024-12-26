//
//  TPAdoptCategoryRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>
#import "TPAnimalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPAdoptCategoryRow : TPTableRow
+ (instancetype)rowWithModel:(TPAnimalModel *)model;
@end

NS_ASSUME_NONNULL_END
