//
//  TPOperateDonateRow.h
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import <TPFoundation/TPFoundation.h>
#import "TPSingleBgTableCell.h"
#import "TPDonateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPOperateDonateCell : TPSingleBgTableCell

@end

@interface TPOperateDonateRow : TPTableRow
@property (nonatomic, strong) TPDonateOperate *operate;
@property (nonatomic, weak) TPOperateDonateCell *cell;
@property (nonatomic, assign) BOOL isMine;
+ (instancetype)rowWithModel:(TPDonateOperate *)operate;
@end

NS_ASSUME_NONNULL_END
