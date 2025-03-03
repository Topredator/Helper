//
//  TPCommonTitleRow.h
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 通用 带有标题 及 箭头的 单元格
@interface TPCommonTitleRow : TPTableRow
+ (instancetype)rowWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
