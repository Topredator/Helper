//
//  TPUserDetailRow.h
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPUserDetailCell : TPBackgroundCell

@end

@interface TPUserDetailRow : TPTableRow
@property (nonatomic, weak) TPUserDetailCell *cell;
+ (instancetype)avatarRow:(NSString *)title avatar:(NSString *)avatar;
+ (instancetype)rowWithTitle:(NSString *)title text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
