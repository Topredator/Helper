//
//  TPDonateRow.h
//  Helper
//
//  Created by Topredator on 2025/3/24.
//

#import <TPFoundation/TPFoundation.h>
#import "TPDonateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPDonateCell : TPUIBaseTableViewCell

@end


@interface TPDonateRow : TPTableRow
@property (nonatomic, strong) TPDonateItemModel *itemModel;
@property (nonatomic, weak) TPDonateCell *cell;
@property (nonatomic, copy) NSString *number;
+ (instancetype)rowWithItem:(TPDonateItemModel *)item;
@end

NS_ASSUME_NONNULL_END
