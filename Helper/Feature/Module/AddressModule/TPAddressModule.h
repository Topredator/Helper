//
//  TPAddressModule.h
//  Helper
//
//  Created by Topredator on 2025/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TABLE_NAME_ADDRESS @"Address_"


typedef NS_ENUM(NSInteger, TPAddressModuleMessageType) {
    /// 获取用户地址信息 个人地址最大设置6个
    TPAddressFetchUserInfo = 800000,
    /// 获取用户默认地址
    TPAddressFetchUserDefaultAddress,
    /// 添加新用户地址
    TPAddressAddNewUserAddress,
    /// 编辑用户地址
    TPAddressEditUserAddress,
    /// 删除用户地址
    TPAddressDeleteUserAddress,
    /// 设置默认用户地址
    TPAddressSetUserDefaultAddress
};

/// 地址模块
@interface TPAddressModule : NSObject <TPDBModuleProtocol>

@end

NS_ASSUME_NONNULL_END
