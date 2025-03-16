//
//  TPApplyModel.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

#import "TPAnimalModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 申请模型
@interface TPApplyModel : NSObject
/// 申请id
@property (nonatomic, copy) NSString *applyId;
/// 发布消息id
@property (nonatomic, copy, nullable) NSString *publishId;
/// 申请人id
@property (nonatomic, copy) NSString *applicantId;
/// 申请人
@property (nonatomic, strong, nullable) TPUserModel *applicant;

/// 宠物id
@property (nonatomic, copy, nullable) NSString *animalId;
/// 宠物
@property (nonatomic, strong, nullable) TPAnimalModel *animal;

/// 被申请人id
@property (nonatomic, copy) NSString *respondentId;
/// 被申请人
@property (nonatomic, strong, nullable) TPUserModel *respondent;
/// 申请状态 (1: 申请中、2: 被拒绝、3: 成功)
@property (nonatomic, assign) TPApplyStatus applyStatus;
/// 申请类型
@property (nonatomic, assign) TPApplyType type;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *endTime;
/// 拒绝原因
@property (nonatomic, copy, nullable) NSString *refusalReason;

+ (instancetype)modelWithUserId:(NSString *)userId animalId:(NSString *)animalId;

@end

NS_ASSUME_NONNULL_END
