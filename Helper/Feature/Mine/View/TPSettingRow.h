//
//  TPSettingRow.h
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置 单元格
@interface TPSettingRow : TPTableRow
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image;
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image des:(NSString *)des arrow:(BOOL)arrow;
+ (instancetype)disableRowWithName:(NSString *)name image:(NSString *)image;
@end

NS_ASSUME_NONNULL_END
