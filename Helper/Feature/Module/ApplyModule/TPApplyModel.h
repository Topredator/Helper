//
//  TPApplyModel.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 申请模型
@interface TPApplyModel : NSObject
/// 申请id
@property (nonatomic, copy) NSString *applyId;
/// 领养id
@property (nonatomic, copy) NSString *adoptId;

/// 申请人id
@property (nonatomic, copy) NSString *userId;
/// 申请人
@property (nonatomic, strong) TPUserModel *applicant;
/// 管理员id
@property (nonatomic, copy) NSString *adminId;
/// 管理员
@property (nonatomic, strong) TPUserModel *manager;
/// 申请状态 (1: 申请中、2: 被拒绝、3: 成功)
@property (nonatomic, assign) TPApplyStatus applyStatus;
/// 申请类型
@property (nonatomic, assign) TPApplyType type;

+ (instancetype)modelWithUserId:(NSString *)userId type:(TPApplyType)type adoptId:(NSString *)adoptId;

@end

NS_ASSUME_NONNULL_END
