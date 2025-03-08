//
//  AppDelegate+TPDatabase.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (TPDatabase)
/// 初始化数据库
- (void)tp_setupDatabase;
/// 初始化自定义数据
- (void)tp_initCustomInfo;
@end

NS_ASSUME_NONNULL_END
