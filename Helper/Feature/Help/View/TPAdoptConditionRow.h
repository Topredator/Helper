//
//  TPAdoptConditionRow.h
//  Helper
//
//  Created by Topredator on 2025/3/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 领养条件
@interface TPAdoptConditionRow : TPTableRow
+ (instancetype)conditionRowWithTitle:(NSString *)title isSelected:(BOOL)isSelected;
+ (instancetype)flowWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
