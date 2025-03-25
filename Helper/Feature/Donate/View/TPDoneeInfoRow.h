//
//  TPDoneeInfoRow.h
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
#import "TPUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPDoneeInfoCell : TPBackgroundCell

@end


/// 受捐人信息
@interface TPDoneeInfoRow : TPTableRow
@property (nonatomic, weak) TPDoneeInfoCell *cell;
@property (nonatomic, strong) TPUserModel *user;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *expressNumber;
@end

NS_ASSUME_NONNULL_END
