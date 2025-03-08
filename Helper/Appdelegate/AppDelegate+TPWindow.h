//
//  AppDelegate+TPWindow.h
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// 窗口扩展
@interface AppDelegate (TPWindow)
/// 初始化窗口
- (void)tp_initWindow;
/// 重置窗口
- (void)tp_resetWindow;
/// 登录后重置
- (void)tp_resetWindowAfterLogin;
@end

NS_ASSUME_NONNULL_END
