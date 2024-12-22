//
//  NSDictionary+TPMapExtension.h
//  Helper
//
//  Created by Topredator on 2024/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (TPMapExtension)

/// 字典中的key 去掉前缀
/// - Parameter prefix: 前缀
- (NSDictionary *)keyRemovePrefix:(NSString *)prefix;

/// 字典中的key 添加前缀
/// - Parameter prefix: 前缀
- (NSDictionary *)keyAddPrefix:(NSString *)prefix;
@end

NS_ASSUME_NONNULL_END
