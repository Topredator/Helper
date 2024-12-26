//
//  TPAdoptPublisherRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>
#import "TPUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPAdoptPublisherRow : TPTableRow
+ (instancetype)rowWithModel:(TPUserModel *)model;
@end

NS_ASSUME_NONNULL_END
