//
//  TPUserModel.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <Foundation/Foundation.h>

/// 用户类型
typedef NS_ENUM(NSUInteger, TPUserType) {
    // 用户
    TPUserTypeCustome,
    // 管理员
    TPUserTypeManager,
    /// 超级管理员
    TPUserTypeSuperManager,
};

/// 用户模型
@interface TPUserModel : NSObject <TPJsonModel>
@property (nonatomic, copy) NSString *userId;
/// 用户名
@property (nonatomic, copy) NSString *name;
/// 账户
@property (nonatomic, copy) NSString *account;
/// 密码
@property (nonatomic, copy) NSString *password;
/// 用户类型
@property (nonatomic, assign) TPUserType userType;
@property (nonatomic, copy) NSString *token;
@property (nonatomic) CGRect rect;
@property (nonatomic, assign) CGFloat height;
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd type:(TPUserType)type;
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd name:(NSString *)name type:(TPUserType)type;

@end

