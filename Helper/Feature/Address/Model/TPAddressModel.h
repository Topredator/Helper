//
//  TPAddressModel.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import <Foundation/Foundation.h>
#import "TPUserModel.h"
NS_ASSUME_NONNULL_BEGIN

/// 地址模型
@interface TPAddressModel : NSObject
/// 地址id
@property (nonatomic, copy) NSString *addressId;
/// 详细地址
@property (nonatomic, copy) NSString *detailAddress;
/// 用户信息
@property (nonatomic, strong) TPUserModel *user;
/// 用户id
@property (nonatomic, copy) NSString *userId;
/// 用户名称
@property (nonatomic, copy) NSString *name;
/// 用户联系方式
@property (nonatomic, copy) NSString *phone;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;
/// 是否默认地址
@property (nonatomic, assign) BOOL isDefault;
+ (instancetype)generateModel;
@end

NS_ASSUME_NONNULL_END
