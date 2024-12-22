//
//  TPMineToolRow.h
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 我的 工具单元格
@interface TPMineToolRow : TPTableRow
+ (instancetype)rowWithIcon:(NSString *)icon name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
