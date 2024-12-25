//
//  TPUserModule.h
//  Helper
//
//  Created by Topredator on 2024/11/25.
//

#import <Foundation/Foundation.h>

/// 用户表名
#define TABLE_NAME_USER  @"User_"

typedef NS_ENUM(NSUInteger, TPUserModuleMessageType) {
    /// 用户注册
    TPUserModuleRegister = 100000,
    /// 用户单个查询
    TPUserModuleSingleQuery,
    /// 修改密码
    TPUserModuleChangePassword,
};


@interface TPUserModule : NSObject <TPDBModuleProtocol>

@end


