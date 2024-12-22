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
@interface TPUserModel : NSObject <TPJsonModel, NSCopying, NSSecureCoding>
@property (nonatomic, copy) NSString *userId;
/// 用户名
@property (nonatomic, copy) NSString *name;
/// 账户
@property (nonatomic, copy) NSString *account;
/// 密码
@property (nonatomic, copy) NSString *password;
/// 用户类型
@property (nonatomic, assign) TPUserType userType;
/// 用户令牌
@property (nonatomic, copy) NSString *token;
/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 身份证号码
@property (nonatomic, copy) NSString *idCard;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;

+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd type:(TPUserType)type;
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd name:(NSString *)name type:(TPUserType)type;

@end

