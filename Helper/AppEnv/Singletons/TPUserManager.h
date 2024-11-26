//
//  TPUserManager.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <Foundation/Foundation.h>
#import "TPUserModel.h"

/// 用户管理类
@interface TPUserManager : NSObject
/// 用户令牌
@property (nonatomic, copy, readonly) NSString *token;
/// 当前登录用户 (未登录时为nil) （可用于KVO监听）
@property (nonatomic, strong) TPUserModel *user;
/// 单例初始化
+ (instancetype)manager;
/// 是否登录
- (BOOL)isLogin;

/// 获取最近登录的账号
- (NSString *)latestAccount;

- (void)setLoginUser:(TPUserModel *)user;
/// 注册
/// - Parameters:
///   - account: 账号
///   - password: 密码
- (void)registerWithAccount:(NSString *)account password:(NSString *)password;
/// 设置登出状态
- (void)setLogout;
@end

