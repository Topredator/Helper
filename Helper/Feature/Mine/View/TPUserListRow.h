//
//  TPUserListRow.h
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import <TPFoundation/TPFoundation.h>
#import "TPSingleBgTableCell.h"
#import "TPUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPUserListCell : TPSingleBgTableCell

@end


@interface TPUserListRow : TPTableRow
@property (nonatomic, weak) TPUserListCell *cell;
+ (instancetype)rowWithModel:(TPUserModel *)model;
@end

NS_ASSUME_NONNULL_END
