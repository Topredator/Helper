//
//  TPAdoptModel.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <Foundation/Foundation.h>
#import "TPAnimalModel.h"
#import "TPUserModel.h"
/// 领养模型
@interface TPAdoptModel : NSObject <TPJsonModel>
/// 模型id
@property (nonatomic, copy) NSString *adoptId;
/// 动物
@property (nonatomic, strong) TPAnimalModel *animal;
/// 动物id
@property (nonatomic, copy) NSString *animalId;
/// 领养申请状态
@property (nonatomic, assign) TPApplyStatus applyStatus;

/// 领养人
@property (nonatomic, strong) TPUserModel *adopter;
/// 领养人id
@property (nonatomic, copy) NSString *adopterId;
/// 发布人
@property (nonatomic, strong) TPUserModel *publisher;
/// 发布者id
@property (nonatomic, copy) NSString *publisherId;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;

+ (instancetype)adopetWithAnimalId:(NSString *)animalId;
+ (instancetype)adoptName:(NSString *)name category:(TPAnimalCategory)category sex:(TPAnimalSexType)sex;

@end


