//
//  TPAdoptItemRow.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <TPFoundation/TPFoundation.h>
#import "TPAnimalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCommonAnimalRow : TPTableRow
+ (instancetype)rowWithModel:(TPAnimalModel *)model;
+ (instancetype)rowWithModel:(TPAnimalModel *)model identifer:(NSString *)identifer;
@end

NS_ASSUME_NONNULL_END
