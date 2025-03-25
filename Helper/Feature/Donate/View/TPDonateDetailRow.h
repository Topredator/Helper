//
//  TPDonateDetailRow.h
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import <TPFoundation/TPFoundation.h>
#import "TPDonateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPDonateDetailCell : TPUIBaseTableViewCell

@end


@interface TPDonateDetailRow : TPTableRow
@property (nonatomic, weak) TPDonateDetailCell *cell;
@property (nonatomic, strong) TPDonateItemModel *itemModel;
+ (instancetype)rowWithModel:(TPDonateItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END
