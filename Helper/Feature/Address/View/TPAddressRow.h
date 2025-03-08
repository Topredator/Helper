//
//  TPAddressRow.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
#import "TPAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPAddressCell : TPBackgroundCell

@end

@interface TPAddressRow : TPTableRow
@property (nonatomic, weak) TPAddressCell *cell;
+ (instancetype)rowWithModel:(TPAddressModel *)model;
@end

NS_ASSUME_NONNULL_END
